#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# COMPREHENSIVE END-TO-END API TEST SUITE
# Tests: Categories, Places, Reviews, Hotels, Events, Itineraries
# Includes: Pagination, Filtering, Sorting, CRUD operations
# ============================================================================

ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
OUT_DIR="$ROOT_DIR/logs"
mkdir -p "$OUT_DIR"

TIMESTAMP=$(date -u +"%Y%m%dT%H%M%SZ")
LOG_FILE="$OUT_DIR/e2e_test_$TIMESTAMP.log"

# API Configuration
API_BASE="http://localhost:8080/v1"
TOKEN=""

# Test tracking
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0
SECTION_TITLE=""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_section() {
  SECTION_TITLE=$1
  echo "" | tee -a "$LOG_FILE"
  echo "=============================================================================" | tee -a "$LOG_FILE"
  echo -e "${BLUE}📦 $SECTION_TITLE${NC}" | tee -a "$LOG_FILE"
  echo "=============================================================================" | tee -a "$LOG_FILE"
}

print_test() {
  echo "" | tee -a "$LOG_FILE"
  echo -e "${YELLOW}🧪 $1${NC}" | tee -a "$LOG_FILE"
  echo "-----------------------------------------------------------------------------" | tee -a "$LOG_FILE"
}

test_result() {
  local test_name=$1
  local http_code=$2
  local expected_code=$3
  local response_body=${4:-""}
  TESTS_TOTAL=$((TESTS_TOTAL + 1))
  
  if [ "$http_code" -eq "$expected_code" ]; then
    TESTS_PASSED=$((TESTS_PASSED + 1))
    echo -e "${GREEN}✅ PASS${NC}: $test_name (HTTP $http_code)" | tee -a "$LOG_FILE"
    return 0
  else
    TESTS_FAILED=$((TESTS_FAILED + 1))
    echo -e "${RED}❌ FAIL${NC}: $test_name (Expected: $expected_code, Got: $http_code)" | tee -a "$LOG_FILE"
    if [ -n "$response_body" ]; then
      echo "   Response: $(echo "$response_body" | jq -c . 2>/dev/null || echo "$response_body")" | tee -a "$LOG_FILE"
    fi
    return 1
  fi
}

make_request() {
  local method=$1
  local endpoint=$2
  local auth=${3:-""}
  local data=${4:-""}
  
  if [ -n "$data" ]; then
    if [ -n "$auth" ]; then
      curl -sS -w "\n%{http_code}" -X "$method" "$API_BASE$endpoint" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "$data"
    else
      curl -sS -w "\n%{http_code}" -X "$method" "$API_BASE$endpoint" \
        -H "Content-Type: application/json" \
        -d "$data"
    fi
  else
    if [ -n "$auth" ]; then
      curl -sS -w "\n%{http_code}" -X "$method" "$API_BASE$endpoint" \
        -H "Authorization: Bearer $TOKEN"
    else
      curl -sS -w "\n%{http_code}" -X "$method" "$API_BASE$endpoint"
    fi
  fi
}

extract_http_code() {
  echo "$1" | tail -n1
}

extract_body() {
  echo "$1" | sed '$d'
}

# ============================================================================
# START TEST SUITE
# ============================================================================
echo "=============================================================================" | tee -a "$LOG_FILE"
echo -e "${BLUE}🚀 COMPREHENSIVE END-TO-END API TEST SUITE${NC}" | tee -a "$LOG_FILE"
echo "Timestamp: $TIMESTAMP" | tee -a "$LOG_FILE"
echo "=============================================================================" | tee -a "$LOG_FILE"

# Health check
print_test "Health Check"
HEALTH_RESP=$(curl -sS -w "\n%{http_code}" http://localhost:8080/health)
HEALTH_HTTP=$(extract_http_code "$HEALTH_RESP")
test_result "Server Health Check" "$HEALTH_HTTP" 200

# ============================================================================
# SECTION 1: CATEGORIES API
# ============================================================================
print_section "SECTION 1: CATEGORIES API"

# Test 1.1: List categories (public)
print_test "List all categories (public endpoint)"
CAT_LIST=$(make_request GET "/categories?limit=10")
CAT_HTTP=$(extract_http_code "$CAT_LIST")
CAT_BODY=$(extract_body "$CAT_LIST")
test_result "GET /categories" "$CAT_HTTP" 200

if [ "$CAT_HTTP" -eq 200 ]; then
  CAT_TOTAL=$(echo "$CAT_BODY" | jq -r '.pagination.total // 0')
  echo "   Found $CAT_TOTAL categories" | tee -a "$LOG_FILE"
fi

# Test 1.2: List categories with pagination
print_test "List categories with pagination (limit=5, offset=0)"
CAT_PAGE=$(make_request GET "/categories?limit=5&offset=0")
CAT_PAGE_HTTP=$(extract_http_code "$CAT_PAGE")
test_result "GET /categories (pagination)" "$CAT_PAGE_HTTP" 200

# Test 1.3: Create category (requires auth)
print_test "Create new category (authenticated)"
SLUG_TIMESTAMP=$(echo "$TIMESTAMP" | tr '[:upper:]' '[:lower:]')
CAT_CREATE_DATA=$(cat <<EOF
{
  "name": "Test Category E2E $TIMESTAMP",
  "description": "End-to-end test category",
  "slug": "test-category-e2e-$SLUG_TIMESTAMP",
  "icon": "🏛️",
  "display_order": 99
}
EOF
)
CAT_CREATE=$(make_request POST "/categories" "auth" "$CAT_CREATE_DATA")
CAT_CREATE_HTTP=$(extract_http_code "$CAT_CREATE")
CAT_CREATE_BODY=$(extract_body "$CAT_CREATE")
test_result "POST /categories" "$CAT_CREATE_HTTP" 201 "$CAT_CREATE_BODY"

CREATED_CAT_ID=""
if [ "$CAT_CREATE_HTTP" -eq 201 ]; then
  CREATED_CAT_ID=$(echo "$CAT_CREATE_BODY" | jq -r '.data.id // .id')
  echo "   Created category: $CREATED_CAT_ID" | tee -a "$LOG_FILE"
fi

# Test 1.4: Get single category by ID
if [ -n "$CREATED_CAT_ID" ]; then
  print_test "Get category by ID"
  CAT_GET=$(make_request GET "/categories/$CREATED_CAT_ID")
  CAT_GET_HTTP=$(extract_http_code "$CAT_GET")
  test_result "GET /categories/:id" "$CAT_GET_HTTP" 200
fi

# Test 1.5: Update category
if [ -n "$CREATED_CAT_ID" ]; then
  print_test "Update category"
  CAT_UPDATE_DATA=$(cat <<EOF
{
  "name": "Updated Category E2E $TIMESTAMP",
  "description": "Updated end-to-end test category"
}
EOF
)
  CAT_UPDATE=$(make_request PUT "/categories/$CREATED_CAT_ID" "auth" "$CAT_UPDATE_DATA")
  CAT_UPDATE_HTTP=$(extract_http_code "$CAT_UPDATE")
  test_result "PUT /categories/:id" "$CAT_UPDATE_HTTP" 200
fi

# ============================================================================
# SECTION 2: PLACES API
# ============================================================================
print_section "SECTION 2: PLACES API"

# Test 2.1: List places (public)
print_test "List all places (public endpoint)"
PLACES_LIST=$(make_request GET "/places?limit=10")
PLACES_HTTP=$(extract_http_code "$PLACES_LIST")
PLACES_BODY=$(extract_body "$PLACES_LIST")
test_result "GET /places" "$PLACES_HTTP" 200

if [ "$PLACES_HTTP" -eq 200 ]; then
  PLACES_TOTAL=$(echo "$PLACES_BODY" | jq -r '.pagination.total // 0')
  echo "   Found $PLACES_TOTAL places" | tee -a "$LOG_FILE"
fi

# Test 2.2: List places with pagination
print_test "List places with pagination (limit=3, offset=0)"
PLACES_PAGE=$(make_request GET "/places?limit=3&offset=0")
PLACES_PAGE_HTTP=$(extract_http_code "$PLACES_PAGE")
PLACES_PAGE_BODY=$(extract_body "$PLACES_PAGE")
test_result "GET /places (pagination)" "$PLACES_PAGE_HTTP" 200

if [ "$PLACES_PAGE_HTTP" -eq 200 ]; then
  PAGE_COUNT=$(echo "$PLACES_PAGE_BODY" | jq -r '.items | length')
  echo "   Retrieved $PAGE_COUNT items in page" | tee -a "$LOG_FILE"
fi

# Test 2.3: List places with sorting
print_test "List places sorted by created_at desc"
PLACES_SORT=$(make_request GET "/places?sort=created_at&order=desc&limit=5")
PLACES_SORT_HTTP=$(extract_http_code "$PLACES_SORT")
test_result "GET /places (sorting)" "$PLACES_SORT_HTTP" 200

# Test 2.4: Filter places by status
print_test "Filter places by status=published"
PLACES_FILTER=$(make_request GET "/places?status=published&limit=5")
PLACES_FILTER_HTTP=$(extract_http_code "$PLACES_FILTER")
test_result "GET /places (filter by status)" "$PLACES_FILTER_HTTP" 200

# Test 2.5: Create place (requires auth)
print_test "Create new place (authenticated)"
PLACE_SLUG="test-place-e2e-$(date +%s)"
PLACE_CREATE_DATA=$(cat <<EOF
{
  "title": "E2E Test Place $TIMESTAMP",
  "slug": "$PLACE_SLUG",
  "place_type": "temple",
  "short_description": "End-to-end test place",
  "location": {
    "latitude": "19.9975",
    "longitude": "73.7898"
  }
}
EOF
)
PLACE_CREATE=$(make_request POST "/places" "auth" "$PLACE_CREATE_DATA")
PLACE_CREATE_HTTP=$(extract_http_code "$PLACE_CREATE")
PLACE_CREATE_BODY=$(extract_body "$PLACE_CREATE")
test_result "POST /places" "$PLACE_CREATE_HTTP" 201

CREATED_PLACE_ID=""
if [ "$PLACE_CREATE_HTTP" -eq 201 ]; then
  CREATED_PLACE_ID=$(echo "$PLACE_CREATE_BODY" | jq -r '.data.id // .id')
  echo "   Created place: $CREATED_PLACE_ID" | tee -a "$LOG_FILE"
fi

# Test 2.6: Get place by ID
if [ -n "$CREATED_PLACE_ID" ]; then
  print_test "Get place by ID"
  PLACE_GET=$(make_request GET "/places/$CREATED_PLACE_ID")
  PLACE_GET_HTTP=$(extract_http_code "$PLACE_GET")
  test_result "GET /places/:id" "$PLACE_GET_HTTP" 200
fi

# Test 2.7: Get place by slug
print_test "Get place by slug"
PLACE_SLUG_GET=$(make_request GET "/places/slug/$PLACE_SLUG")
PLACE_SLUG_HTTP=$(extract_http_code "$PLACE_SLUG_GET")
test_result "GET /places/slug/:slug" "$PLACE_SLUG_HTTP" 200

# Test 2.8: Update place
if [ -n "$CREATED_PLACE_ID" ]; then
  print_test "Update place"
  PLACE_UPDATE_DATA=$(cat <<EOF
{
  "title": "Updated E2E Test Place $TIMESTAMP",
  "short_description": "Updated test place"
}
EOF
)
  PLACE_UPDATE=$(make_request PUT "/places/$CREATED_PLACE_ID" "auth" "$PLACE_UPDATE_DATA")
  PLACE_UPDATE_HTTP=$(extract_http_code "$PLACE_UPDATE")
  test_result "PUT /places/:id" "$PLACE_UPDATE_HTTP" 200
fi

# ============================================================================
# SECTION 3: REVIEWS API
# ============================================================================
print_section "SECTION 3: REVIEWS API"

if [ -n "$CREATED_PLACE_ID" ]; then
  # Test 3.1: Create review
  print_test "Create review for place"
  REVIEW_CREATE_DATA=$(cat <<EOF
{
  "entity_type": "place",
  "entity_id": "$CREATED_PLACE_ID",
  "rating": 5,
  "title": "Excellent Place",
  "content": "Great place! E2E test review. Highly recommended for visitors."
}
EOF
)
  REVIEW_CREATE=$(make_request POST "/reviews" "auth" "$REVIEW_CREATE_DATA")
  REVIEW_CREATE_HTTP=$(extract_http_code "$REVIEW_CREATE")
  REVIEW_CREATE_BODY=$(extract_body "$REVIEW_CREATE")
  test_result "POST /reviews" "$REVIEW_CREATE_HTTP" 201 "$REVIEW_CREATE_BODY"
  
  CREATED_REVIEW_ID=""
  if [ "$REVIEW_CREATE_HTTP" -eq 201 ]; then
    CREATED_REVIEW_ID=$(echo "$REVIEW_CREATE_BODY" | jq -r '.data.id // .id')
    echo "   Created review: $CREATED_REVIEW_ID" | tee -a "$LOG_FILE"
  fi
  
  # Test 3.2: List reviews for place
  print_test "List reviews for place"
  REVIEWS_LIST=$(make_request GET "/reviews?entity_type=place&entity_id=$CREATED_PLACE_ID&limit=10")
  REVIEWS_HTTP=$(extract_http_code "$REVIEWS_LIST")
  test_result "GET /reviews (filtered by place)" "$REVIEWS_HTTP" 200
  
  # Test 3.3: List all reviews with pagination
  print_test "List all reviews with pagination"
  MY_REVIEWS=$(make_request GET "/reviews?limit=5&offset=0")
  MY_REVIEWS_HTTP=$(extract_http_code "$MY_REVIEWS")
  test_result "GET /reviews (pagination)" "$MY_REVIEWS_HTTP" 200
  
  # Test 3.4: Update review
  if [ -n "$CREATED_REVIEW_ID" ]; then
    print_test "Update review"
    REVIEW_UPDATE_DATA=$(cat <<EOF
{
  "rating": 4,
  "content": "Updated review comment - revised after second visit"
}
EOF
)
    REVIEW_UPDATE=$(make_request PUT "/reviews/$CREATED_REVIEW_ID" "auth" "$REVIEW_UPDATE_DATA")
    REVIEW_UPDATE_HTTP=$(extract_http_code "$REVIEW_UPDATE")
    test_result "PUT /reviews/:id" "$REVIEW_UPDATE_HTTP" 200
  fi
fi

# ============================================================================
# SECTION 4: HOTELS API
# ============================================================================
print_section "SECTION 4: HOTELS API"

# Test 4.1: List hotels (public)
print_test "List all hotels"
HOTELS_LIST=$(make_request GET "/hotels?limit=10")
HOTELS_HTTP=$(extract_http_code "$HOTELS_LIST")
HOTELS_BODY=$(extract_body "$HOTELS_LIST")
test_result "GET /hotels" "$HOTELS_HTTP" 200

if [ "$HOTELS_HTTP" -eq 200 ]; then
  HOTELS_TOTAL=$(echo "$HOTELS_BODY" | jq -r '.pagination.total // .total // 0')
  echo "   Found $HOTELS_TOTAL hotels" | tee -a "$LOG_FILE"
fi

# Test 4.2: List hotels with pagination
print_test "List hotels with pagination (limit=5)"
HOTELS_PAGE=$(make_request GET "/hotels?limit=5&offset=0")
HOTELS_PAGE_HTTP=$(extract_http_code "$HOTELS_PAGE")
test_result "GET /hotels (pagination)" "$HOTELS_PAGE_HTTP" 200

# Test 4.3: Create hotel
print_test "Create new hotel (authenticated)"
HOTEL_SLUG="e2e-test-hotel-$(date +%s)"
HOTEL_CREATE_DATA=$(cat <<EOF
{
  "slug": "$HOTEL_SLUG",
  "name": "E2E Test Hotel $TIMESTAMP",
  "description": "Test hotel for e2e testing",
  "star_rating": 4,
  "room_count": 50,
  "address": {
    "street": "123 Test Street",
    "city": "Nashik",
    "state": "Maharashtra",
    "country": "India",
    "pincode": "422001"
  },
  "location": {
    "latitude": 19.9975,
    "longitude": 73.7898
  },
  "phone": "+91-9876543210",
  "email": "test@hotel.com",
  "price_min": 2000.00,
  "price_max": 5000.00,
  "currency": "INR"
}
EOF
)
HOTEL_CREATE=$(make_request POST "/hotels" "auth" "$HOTEL_CREATE_DATA")
HOTEL_CREATE_HTTP=$(extract_http_code "$HOTEL_CREATE")
HOTEL_CREATE_BODY=$(extract_body "$HOTEL_CREATE")
test_result "POST /hotels" "$HOTEL_CREATE_HTTP" 201

CREATED_HOTEL_ID=""
if [ "$HOTEL_CREATE_HTTP" -eq 201 ]; then
  CREATED_HOTEL_ID=$(echo "$HOTEL_CREATE_BODY" | jq -r '.data.id // .id')
  echo "   Created hotel: $CREATED_HOTEL_ID" | tee -a "$LOG_FILE"
fi

# Test 4.4: Get hotel by ID
if [ -n "$CREATED_HOTEL_ID" ]; then
  print_test "Get hotel by ID"
  HOTEL_GET=$(make_request GET "/hotels/$CREATED_HOTEL_ID")
  HOTEL_GET_HTTP=$(extract_http_code "$HOTEL_GET")
  test_result "GET /hotels/:id" "$HOTEL_GET_HTTP" 200
fi

# ============================================================================
# SECTION 5: EVENTS API
# ============================================================================
print_section "SECTION 5: EVENTS API"

# Test 5.1: List events
print_test "List all events"
EVENTS_LIST=$(make_request GET "/events?limit=10")
EVENTS_HTTP=$(extract_http_code "$EVENTS_LIST")
EVENTS_BODY=$(extract_body "$EVENTS_LIST")
test_result "GET /events" "$EVENTS_HTTP" 200

if [ "$EVENTS_HTTP" -eq 200 ]; then
  EVENTS_TOTAL=$(echo "$EVENTS_BODY" | jq -r '.pagination.total // .total // 0')
  echo "   Found $EVENTS_TOTAL events" | tee -a "$LOG_FILE"
fi

# Test 5.2: List events with pagination
print_test "List events with pagination"
EVENTS_PAGE=$(make_request GET "/events?limit=5&offset=0")
EVENTS_PAGE_HTTP=$(extract_http_code "$EVENTS_PAGE")
test_result "GET /events (pagination)" "$EVENTS_PAGE_HTTP" 200

# Test 5.3: Create event
print_test "Create new event (authenticated)"
EVENT_SLUG="e2e-test-event-$(date +%s)"
EVENT_CREATE_DATA=$(cat <<EOF
{
  "slug": "$EVENT_SLUG",
  "type": "FESTIVAL",
  "title": "E2E Test Festival $TIMESTAMP",
  "subtitle": "Annual celebration",
  "description": "End-to-end test event for festival category",
  "start_date": "2025-12-25T00:00:00Z",
  "end_date": "2025-12-26T23:59:59Z",
  "location_name": "Nashik City Center",
  "latitude": 19.9975,
  "longitude": 73.7898
}
EOF
)
EVENT_CREATE=$(make_request POST "/events" "auth" "$EVENT_CREATE_DATA")
EVENT_CREATE_HTTP=$(extract_http_code "$EVENT_CREATE")
EVENT_CREATE_BODY=$(extract_body "$EVENT_CREATE")
test_result "POST /events" "$EVENT_CREATE_HTTP" 201 "$EVENT_CREATE_BODY"

CREATED_EVENT_ID=""
if [ "$EVENT_CREATE_HTTP" -eq 201 ]; then
  CREATED_EVENT_ID=$(echo "$EVENT_CREATE_BODY" | jq -r '.data.id // .id')
  echo "   Created event: $CREATED_EVENT_ID" | tee -a "$LOG_FILE"
fi

# Test 5.4: Get event by ID
if [ -n "$CREATED_EVENT_ID" ]; then
  print_test "Get event by ID"
  EVENT_GET=$(make_request GET "/events/$CREATED_EVENT_ID")
  EVENT_GET_HTTP=$(extract_http_code "$EVENT_GET")
  test_result "GET /events/:id" "$EVENT_GET_HTTP" 200
fi

# ============================================================================
# SECTION 6: ITINERARIES API
# ============================================================================
print_section "SECTION 6: ITINERARIES API"

# Get some places for itinerary creation
print_test "Setup: Fetch places for itinerary"
ITIN_PLACES=$(make_request GET "/places?limit=4&status=published")
ITIN_PLACES_HTTP=$(extract_http_code "$ITIN_PLACES")
ITIN_PLACES_BODY=$(extract_body "$ITIN_PLACES")

if [ "$ITIN_PLACES_HTTP" -eq 200 ]; then
  readarray -t PLACE_IDS < <(echo "$ITIN_PLACES_BODY" | jq -r '.items[]?.id')
  
  if [ ${#PLACE_IDS[@]} -ge 2 ]; then
    PLACE_1=${PLACE_IDS[0]}
    PLACE_2=${PLACE_IDS[1]}
    PLACE_3=${PLACE_IDS[2]:-$PLACE_1}
    
    echo "   Selected places: $PLACE_1, $PLACE_2, $PLACE_3" | tee -a "$LOG_FILE"
    
    # Test 6.1: Create itinerary
    print_test "Create itinerary with 3 places"
    ITIN_CREATE_DATA=$(cat <<EOF
{
  "title": "E2E Test Itinerary $TIMESTAMP",
  "planned_date": "2025-12-20T09:00:00Z",
  "start_location": {
    "latitude": 19.9975,
    "longitude": 73.7898
  },
  "transport_mode": "DRIVING",
  "selected_places": ["$PLACE_1", "$PLACE_2", "$PLACE_3"],
  "default_duration": 45
}
EOF
)
    ITIN_CREATE=$(make_request POST "/itineraries" "auth" "$ITIN_CREATE_DATA")
    ITIN_CREATE_HTTP=$(extract_http_code "$ITIN_CREATE")
    ITIN_CREATE_BODY=$(extract_body "$ITIN_CREATE")
    test_result "POST /itineraries" "$ITIN_CREATE_HTTP" 201
    
    CREATED_ITIN_ID=""
    if [ "$ITIN_CREATE_HTTP" -eq 201 ]; then
      CREATED_ITIN_ID=$(echo "$ITIN_CREATE_BODY" | jq -r '.id')
      ITIN_DISTANCE=$(echo "$ITIN_CREATE_BODY" | jq -r '.total_distance_km')
      ITIN_DURATION=$(echo "$ITIN_CREATE_BODY" | jq -r '.total_duration_minutes')
      echo "   Created itinerary: $CREATED_ITIN_ID" | tee -a "$LOG_FILE"
      echo "   Distance: $ITIN_DISTANCE km, Duration: $ITIN_DURATION min" | tee -a "$LOG_FILE"
    fi
    
    # Test 6.2: Get itinerary by ID
    if [ -n "$CREATED_ITIN_ID" ]; then
      print_test "Get itinerary by ID"
      ITIN_GET=$(make_request GET "/itineraries/$CREATED_ITIN_ID")
      ITIN_GET_HTTP=$(extract_http_code "$ITIN_GET")
      test_result "GET /itineraries/:id" "$ITIN_GET_HTTP" 200
    fi
    
    # Test 6.3: Get itinerary with details
    if [ -n "$CREATED_ITIN_ID" ]; then
      print_test "Get itinerary with visit details"
      ITIN_DETAILS=$(make_request GET "/itineraries/$CREATED_ITIN_ID/details")
      ITIN_DETAILS_HTTP=$(extract_http_code "$ITIN_DETAILS")
      ITIN_DETAILS_BODY=$(extract_body "$ITIN_DETAILS")
      test_result "GET /itineraries/:id/details" "$ITIN_DETAILS_HTTP" 200
      
      if [ "$ITIN_DETAILS_HTTP" -eq 200 ]; then
        VISIT_COUNT=$(echo "$ITIN_DETAILS_BODY" | jq -r '.visits | length')
        echo "   Found $VISIT_COUNT visits with full details" | tee -a "$LOG_FILE"
      fi
    fi
    
    # Test 6.4: List my itineraries
    print_test "List my itineraries (authenticated)"
    MY_ITINS=$(make_request GET "/itineraries/me" "auth")
    MY_ITINS_HTTP=$(extract_http_code "$MY_ITINS")
    MY_ITINS_BODY=$(extract_body "$MY_ITINS")
    test_result "GET /itineraries/me" "$MY_ITINS_HTTP" 200
    
    if [ "$MY_ITINS_HTTP" -eq 200 ]; then
      MY_ITIN_COUNT=$(echo "$MY_ITINS_BODY" | jq -r '.itineraries | length')
      echo "   User has $MY_ITIN_COUNT itineraries" | tee -a "$LOG_FILE"
    fi
    
    # Test 6.5: List all itineraries (public)
    print_test "List all itineraries (public)"
    ALL_ITINS=$(make_request GET "/itineraries?limit=5")
    ALL_ITINS_HTTP=$(extract_http_code "$ALL_ITINS")
    test_result "GET /itineraries" "$ALL_ITINS_HTTP" 200
    
    # Test 6.6: List itineraries with pagination
    print_test "List itineraries with pagination"
    ITINS_PAGE=$(make_request GET "/itineraries?limit=3&offset=0")
    ITINS_PAGE_HTTP=$(extract_http_code "$ITINS_PAGE")
    test_result "GET /itineraries (pagination)" "$ITINS_PAGE_HTTP" 200
    
    # Test 6.7: Update itinerary
    if [ -n "$CREATED_ITIN_ID" ]; then
      print_test "Update itinerary title"
      ITIN_UPDATE_DATA=$(cat <<EOF
{
  "title": "Updated E2E Test Itinerary $TIMESTAMP"
}
EOF
)
      ITIN_UPDATE=$(make_request PUT "/itineraries/$CREATED_ITIN_ID" "auth" "$ITIN_UPDATE_DATA")
      ITIN_UPDATE_HTTP=$(extract_http_code "$ITIN_UPDATE")
      test_result "PUT /itineraries/:id" "$ITIN_UPDATE_HTTP" 200
    fi
    
    # Test 6.8: Delete itinerary
    if [ -n "$CREATED_ITIN_ID" ]; then
      print_test "Delete itinerary (cascade delete visits)"
      ITIN_DELETE=$(make_request DELETE "/itineraries/$CREATED_ITIN_ID" "auth")
      ITIN_DELETE_HTTP=$(extract_http_code "$ITIN_DELETE")
      test_result "DELETE /itineraries/:id" "$ITIN_DELETE_HTTP" 204
      
      # Verify deletion
      if [ "$ITIN_DELETE_HTTP" -eq 204 ] || [ "$ITIN_DELETE_HTTP" -eq 200 ]; then
        print_test "Verify itinerary deletion"
        VERIFY_DEL=$(make_request GET "/itineraries/$CREATED_ITIN_ID" 2>/dev/null || echo -e "\n404")
        VERIFY_HTTP=$(extract_http_code "$VERIFY_DEL")
        test_result "Verify deletion (expect 404)" "$VERIFY_HTTP" 404
      fi
    fi
  else
    echo "⚠️  Not enough places to create itinerary. Skipping itinerary tests." | tee -a "$LOG_FILE"
  fi
fi

# ============================================================================
# CLEANUP (Optional - delete created test data)
# ============================================================================
print_section "CLEANUP: Deleting test data"

# Delete test review
if [ -n "$CREATED_REVIEW_ID" ]; then
  print_test "Delete test review"
  make_request DELETE "/reviews/$CREATED_REVIEW_ID" "auth" > /dev/null
  echo "   Deleted review: $CREATED_REVIEW_ID" | tee -a "$LOG_FILE"
fi

# Delete test place
if [ -n "$CREATED_PLACE_ID" ]; then
  print_test "Delete test place"
  make_request DELETE "/places/$CREATED_PLACE_ID" "auth" > /dev/null
  echo "   Deleted place: $CREATED_PLACE_ID" | tee -a "$LOG_FILE"
fi

# Delete test hotel
if [ -n "$CREATED_HOTEL_ID" ]; then
  print_test "Delete test hotel"
  make_request DELETE "/hotels/$CREATED_HOTEL_ID" "auth" > /dev/null
  echo "   Deleted hotel: $CREATED_HOTEL_ID" | tee -a "$LOG_FILE"
fi

# Delete test event
if [ -n "$CREATED_EVENT_ID" ]; then
  print_test "Delete test event"
  make_request DELETE "/events/$CREATED_EVENT_ID" "auth" > /dev/null
  echo "   Deleted event: $CREATED_EVENT_ID" | tee -a "$LOG_FILE"
fi

# Delete test category
if [ -n "$CREATED_CAT_ID" ]; then
  print_test "Delete test category"
  make_request DELETE "/categories/$CREATED_CAT_ID" "auth" > /dev/null
  echo "   Deleted category: $CREATED_CAT_ID" | tee -a "$LOG_FILE"
fi

# ============================================================================
# FINAL SUMMARY
# ============================================================================
echo "" | tee -a "$LOG_FILE"
echo "=============================================================================" | tee -a "$LOG_FILE"
echo -e "${BLUE}📊 FINAL TEST RESULTS${NC}" | tee -a "$LOG_FILE"
echo "=============================================================================" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Total Tests:  $TESTS_TOTAL" | tee -a "$LOG_FILE"
echo -e "${GREEN}✅ Passed:    $TESTS_PASSED${NC}" | tee -a "$LOG_FILE"
echo -e "${RED}❌ Failed:    $TESTS_FAILED${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

if [ "$TESTS_FAILED" -eq 0 ]; then
  echo -e "${GREEN}🎉 ALL TESTS PASSED! API is fully functional!${NC}" | tee -a "$LOG_FILE"
  SUCCESS_RATE="100%"
else
  SUCCESS_RATE=$(awk "BEGIN {printf \"%.1f\", ($TESTS_PASSED/$TESTS_TOTAL)*100}")
  echo -e "${YELLOW}⚠️  Some tests failed. Success rate: $SUCCESS_RATE%${NC}" | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo "Tested APIs:" | tee -a "$LOG_FILE"
echo "  ✅ Categories (List, Create, Get, Update)" | tee -a "$LOG_FILE"
echo "  ✅ Places (List, Create, Get, Update, Pagination, Filtering, Sorting)" | tee -a "$LOG_FILE"
echo "  ✅ Reviews (Create, List, Get My Reviews, Update)" | tee -a "$LOG_FILE"
echo "  ✅ Hotels (List, Create, Get, Pagination)" | tee -a "$LOG_FILE"
echo "  ✅ Events (List, Create, Get, Pagination)" | tee -a "$LOG_FILE"
echo "  ✅ Itineraries (Create, Get, Get Details, List, Update, Delete)" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Full test log saved to: $LOG_FILE" | tee -a "$LOG_FILE"
echo "=============================================================================" | tee -a "$LOG_FILE"

exit $TESTS_FAILED
