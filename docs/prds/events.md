# 🛕 Nashik Darshan — **Events Module (Final PRD)**

## 1. Goal & Scope

Create a single, generic **Events system** powering all time-based content in Nashik Darshan:

* Temple Aartis and rituals
* Festivals (temple or citywide)
* Cultural or seasonal events (e.g., Kumbh Mela 2027)
* One-time or recurring happenings (heritage walks, special darshans)

The system must:

* Support **recurrence** (daily, weekly, monthly, yearly, one-off)
* Work for **place-level** and **city-level** contexts
* Be **configurable, searchable, and cache-efficient**
* Expose only **entity-level APIs** — permissions handled in middleware

---

## 2. Architecture Overview

```
Event (core metadata)
 └── EventSlot (recurrence rules / timings)
```

### Core Principles

| Principle                                                      | Reason                                         |
| -------------------------------------------------------------- | ---------------------------------------------- |
| **Generic types** (`AARTI`, `FESTIVAL`, `CITY_EVENT`, `OTHER`) | Same code serves multiple domains              |
| **Declarative recurrence rules**                               | No heavy pre-generation of dates               |
| **Entity routes only**                                         | Simple REST; auth done in middleware           |
| **Dynamic expansion**                                          | Compute actual occurrences on demand           |
| **Scalable caching**                                           | Place + City level keys, invalidated on change |

---

## 3. Data Model

### 3.1 `event`

| Field                          | Type                                                        | Notes                             |
| ------------------------------ | ----------------------------------------------------------- | --------------------------------- |
| id                             | ULID                                                        | PK                                |
| type                           | ENUM `AARTI`, `FESTIVAL`, `CULTURAL`, `CITY_EVENT`, `OTHER` | Distinguishes behaviour/FE render |
| place_id                       | TEXT NULL                                                   | FK→places; NULL = citywide        |
| title / subtitle / description | TEXT                                                        | Display info                      |
| start_date / end_date          | DATE                                                        | Validity window                   |
| tags                           | TEXT[]                                                      | e.g. ["morning","spiritual"]      |
| cover_image_url                | TEXT NULL                                                   | optional                          |
| metadata                       | JSONB                                                       | {stream_url, booking_link,…}      |
| status                         | ENUM `draft`,`published`,`archived`,`deleted`               | lifecycle                         |
| created_by                     | TEXT                                                        | user id                           |
| created_at / updated_at        | TIMESTAMPTZ                                                 | audit                             |

Indexes: `(place_id,status)`, `(city_id,status)`, `(type,status)`.

---

### 3.2 `event_slot`

| Field                                | Type                                            | Notes              |
| ------------------------------------ | ----------------------------------------------- | ------------------ |
| id                                   | ULID                                            | PK                 |
| event_id                             | TEXT                                            | FK→event(id)       |
| place_id                             | TEXT NULL                                       | denormalized       |
| occurrence                           | ENUM `DAILY`,`WEEKLY`,`MONTHLY`,`YEARLY`,`NONE` | recurrence         |
| start_time / end_time                | TIME                                            | time of day        |
| week_day                             | INT 1-7 (Sun-Sat)                               | for weekly         |
| month_day                            | INT 1-31                                        | for monthly/yearly |
| duration_minutes                     | INT generated                                   | computed diff      |
| status                               | ENUM `published`,`archived`,`deleted`           |                    |
| metadata                             | JSONB                                           | per-slot data      |
| created_by / created_at / updated_at | TEXT / TIMESTAMPTZ                              | audit              |

Indexes: `(event_id)`, `(place_id,occurrence)`, `(week_day)`, `(month_day)`.

---

## 4. Routes (entity-level, versioned under `/v1`)

*All write operations gated by middleware policies.*

| Method     | Endpoint                      | Purpose                                                                 |
| ---------- | ----------------------------- | ----------------------------------------------------------------------- |
| **GET**    | `/events`                     | Query by `type`, `place_id`, `city_id`, `from`, `to`, `limit`, `cursor` |
| **POST**   | `/events`                     | Create new event                                                        |
| **GET**    | `/events/:id`                 | Fetch single event with metadata                                        |
| **PATCH**  | `/events/:id`                 | Update event                                                            |
| **DELETE** | `/events/:id`                 | Soft-delete (status→deleted)                                            |
| **GET**    | `/events/:id/slots`           | Get slots                                                               |
| **POST**   | `/events/:id/slots`           | Add slot                                                                |
| **PATCH**  | `/events/:id/slots/:slot_id`  | Update slot                                                             |
| **DELETE** | `/events/:id/slots/:slot_id`  | Soft-delete slot                                                        |
| **GET**    | `/places/:place_id/events`    | Events under a place                                                    |
| **GET**    | `/events/:id/upcoming?days=7` | Expanded next N occurrences                                             |

---

## 5. Auth & Policy Layer

Authorization handled via middleware:

| Function                         | Logic                                        |
| -------------------------------- | -------------------------------------------- |
| `CanCreateEvent(user, place_id)` | allow admin/editor or partner for place_id   |
| `CanModifyEvent(user, event)`    | admin or creator or place partner            |
| `CanViewEvent(user, event)`      | public if published; otherwise admin/creator |
| `CanModifySlot(user, slot)`      | inherits from event policy                   |

---

## 6. Business Logic

### 6.1 Event Creation

1. Validate type + scope (city/temple).
2. Insert into `event`.
3. Return event payload.

### 6.2 Add Slot

1. Validate times (`start_time < end_time`).
2. If `occurrence=WEEKLY` → require `week_day`.
3. If `occurrence=MONTHLY/YEARLY` → require `month_day`.
4. Insert → invalidate `events:place:{place_id}` cache.

### 6.3 Expansion Logic

`ExpandSlot(slot, from, to, tz)` returns concrete ISO datetimes.
Handles DAILY, WEEKLY, MONTHLY, YEARLY, NONE (one-off).
Reject overnight spans initially.

---

## 7. Frontend Behaviour

| Type           | Display Pattern                    |
| -------------- | ---------------------------------- |
| **AARTI**      | Daily/Weekly grouped timings       |
| **FESTIVAL**   | Multi-day schedule (slots by date) |
| **CITY_EVENT** | List view (cards)                  |
| **CULTURAL**   | Rich detail + gallery              |
| **OTHER**      | fallback card view                 |

Endpoints used:

* `/places/:id/events?type=AARTI` for temple page
* `/events/:id/upcoming` for “Next Aarti” widget
* `/events?city_id=nashik` for discover feed

---

## 8. Edge Cases & Rules

| Case                            | Handling                                  |
| ------------------------------- | ----------------------------------------- |
| start_time > end_time           | Reject (no overnight)                     |
| Invalid month_day (e.g. 31 Feb) | Skip month                                |
| Overlapping slots               | Allowed                                   |
| Event without slots             | Valid; no timing UI                       |
| Past events                     | Hide unless include_archived              |
| Timezone                        | All stored UTC; display IST               |
| Cancellations                   | handled later via `event_exception` table |
| end_date expired                | event hidden from public feed             |

---

## 9. Caching & Performance

| Cache Key                    | TTL    | Scope                |
| ---------------------------- | ------ | -------------------- |
| `events:place:{place_id}`    | 15 min | all events for place |
| `events:city:{city_id}`      | 15 min | city feed            |
| `events:{id}`                | 10 min | single event         |
| `upcoming:{event_id}:{days}` | 5 min  | next occurrences     |

Invalidate on create/update/delete affecting same place_id or event_id.

Pagination: cursor-based using `start_date, id`.

---

## 10. Implementation Plan

**Week 1**

* DB migrations, Ent schemas, core handlers
* Auth middleware + policy functions

**Week 2**

* Slots CRUD + expansion service
* Caching layer + invalidations

**Week 3**

* Public GET endpoints / filters / pagination
* FE integration for temple pages & feed

**Week 4**

* Edge-case tests, perf tuning, rollout & monitoring

---

## 11. Testing Matrix

| Test Type       | Coverage                                                  |
| --------------- | --------------------------------------------------------- |
| **Unit**        | expand logic (DAILY/WEEKLY/MONTHLY/YEARLY), policy checks |
| **Integration** | event CRUD + slot grouping, cache invalidation            |
| **Edge**        | invalid times, month_day overflows, visibility rules      |
| **Load**        | expand 10 k events → p95 < target latency                 |
| **Security**    | unauthorized POST/PATCH/DELETE blocked                    |

---

## 12. Future Extensions

| Feature            | Approach                                           |
| ------------------ | -------------------------------------------------- |
| Bookings           | `event_booking` table (user_id, event_id, slot_id) |
| Notifications      | Schedule via expanded occurrences                  |
| Live Streams       | `metadata.stream_url` + status                     |
| Multi-place events | add `event_participation` mapping                  |
| Analytics          | track views & attendance by type                   |

---

## 13. Example Payloads

### 13.1 Temple Aarti

```json
{
  "id": "evt_001",
  "type": "AARTI",
  "place_id": "pl_trimbak",
  "title": "Morning Aarti",
  "start_date": "2025-01-01",
  "tags": ["daily","morning"],
  "slots": [
    {"occurrence":"DAILY","start_time":"06:00","end_time":"06:30"},
    {"occurrence":"DAILY","start_time":"19:00","end_time":"19:30"}
  ]
}
```

### 13.2 Citywide Festival

```json
{
  "id": "evt_045",
  "type": "FESTIVAL",
  "city_id": "nashik",
  "title": "Kumbh Mela 2027",
  "start_date": "2027-02-01",
  "end_date": "2027-03-15",
  "metadata": {"description": "World’s largest spiritual gathering"},
  "slots": [
    {"occurrence":"NONE","start_time":"00:00","end_time":"23:59"}
  ]
}
```

---

## 14. Acceptance Criteria

* [ ] All entity routes implemented per spec
* [ ] Auth policies enforce role + ownership
* [ ] Expansion returns correct ISO timestamps
* [ ] Cache invalidation verified
* [ ] FE renders grouped timings per occurrence
* [ ] Unit & integration tests > 90 % pass
