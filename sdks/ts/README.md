# @caygnus/nashik-darshan-sdk

Official TypeScript/JavaScript SDK for the Nashik Darshan API - A comprehensive tourism and travel discovery platform for Nashik city.

## Installation

```bash
npm install @caygnus/nashik-darshan-sdk
# or
yarn add @caygnus/nashik-darshan-sdk
# or
pnpm add @caygnus/nashik-darshan-sdk
```

## Requirements

- Node.js >= 18.0.0
- TypeScript >= 5.0.0 (optional, for TypeScript projects)

## Quick Start

### Basic Setup

```typescript
import { Configuration, AuthApi, PlaceApi } from "@caygnus/nashik-darshan-sdk";

// Configure the SDK
const configuration = new Configuration({
  basePath: "https://api.nashikdarshan.com/api/v1", // Your API base URL
  // Optional: Add authentication token
  accessToken: "your-access-token-here",
});

// Initialize API clients
const authApi = new AuthApi(configuration);
const placeApi = new PlaceApi(configuration);
```

### Authentication

The SDK supports Bearer token authentication. Set your access token when creating the configuration:

```typescript
import { Configuration } from "@caygnus/nashik-darshan-sdk";

const configuration = new Configuration({
  basePath: "https://api.nashikdarshan.com/api/v1",
  accessToken: "your-bearer-token",
});
```

### Example: User Signup

```typescript
import { AuthApi, DtoSignupRequest } from "@caygnus/nashik-darshan-sdk";

const authApi = new AuthApi(configuration);

const signupRequest: DtoSignupRequest = {
  name: "John Doe",
  email: "john@example.com",
  phone: "+1234567890",
  accessToken: "your-oauth-access-token", // From OAuth provider
};

try {
  const response = await authApi.authSignupPost(signupRequest);
  console.log("User ID:", response.data.id);
  console.log("Access Token:", response.data.accessToken);
} catch (error) {
  console.error("Signup failed:", error);
}
```

### Example: Get Places

```typescript
import { PlaceApi } from "@caygnus/nashik-darshan-sdk";

const placeApi = new PlaceApi(configuration);

try {
  // Get places with pagination
  const response = await placeApi.placesGet({
    limit: 10,
    offset: 0,
    status: "published",
  });

  console.log("Total places:", response.data.pagination?.total);
  response.data.items?.forEach((place) => {
    console.log(`${place.title} - ${place.placeType}`);
  });
} catch (error) {
  console.error("Failed to fetch places:", error);
}
```

### Example: Search Places

```typescript
import { PlaceApi } from "@caygnus/nashik-darshan-sdk";

const placeApi = new PlaceApi(configuration);

try {
  // Search with filters
  const response = await placeApi.placesGet({
    searchQuery: "hotel",
    placeTypes: ["hotel"],
    minRating: 4.0,
    limit: 20,
  });

  response.data.items?.forEach((place) => {
    console.log(`${place.title} - Rating: ${place.ratingAvg}/5`);
  });
} catch (error) {
  console.error("Search failed:", error);
}
```

### Example: Get Feed Data

```typescript
import {
  FeedApi,
  DtoFeedRequest,
  TypesFeedSectionType,
} from "@caygnus/nashik-darshan-sdk";

const feedApi = new FeedApi(configuration);

const feedRequest: DtoFeedRequest = {
  sections: [
    {
      type: TypesFeedSectionType.SectionTypeTrending,
      limit: 10,
    },
    {
      type: TypesFeedSectionType.SectionTypePopular,
      limit: 10,
    },
    {
      type: TypesFeedSectionType.SectionTypeNearby,
      latitude: 19.9975,
      longitude: 73.7898,
      radiusKm: 5,
      limit: 10,
    },
  ],
};

try {
  const response = await feedApi.feedPost(feedRequest);

  response.data.sections?.forEach((section) => {
    console.log(`Section: ${section.type}`);
    section.items?.forEach((item) => {
      console.log(`  - ${item.title}`);
    });
  });
} catch (error) {
  console.error("Failed to fetch feed:", error);
}
```

## API Clients

The SDK provides the following API clients:

- **AuthApi** - User authentication and signup
- **CategoryApi** - Category management
- **FeedApi** - Feed data (trending, popular, latest, nearby)
- **PlaceApi** - Places, hotels, restaurants, attractions
- **ReviewsApi** - Reviews and ratings
- **UserApi** - User profile management

## Configuration Options

```typescript
interface ConfigurationParameters {
  basePath?: string; // API base URL (default: http://localhost:8080/api/v1)
  accessToken?: string; // Bearer token for authentication
  apiKey?: string | ((name: string) => string); // API key authentication
  username?: string; // Basic auth username
  password?: string; // Basic auth password
  formDataCtor?: new () => any; // Custom FormData constructor
}
```

## Error Handling

All API calls return Axios promises. Handle errors appropriately:

```typescript
import { AxiosError } from "axios";

try {
  const response = await placeApi.placesIdGet("place-id");
  // Handle success
} catch (error) {
  if (error instanceof AxiosError) {
    if (error.response) {
      // Server responded with error
      console.error("API Error:", error.response.status, error.response.data);
    } else if (error.request) {
      // Request made but no response
      console.error("Network Error:", error.message);
    } else {
      // Something else happened
      console.error("Error:", error.message);
    }
  }
}
```

## TypeScript Support

The SDK is written in TypeScript and includes full type definitions. All types are exported and can be imported:

```typescript
import {
  DtoPlaceResponse,
  DtoCategoryResponse,
  DtoReviewResponse,
  TypesStatus,
  TypesFeedSectionType,
} from "@caygnus/nashik-darshan-sdk";
```

## Environment Variables

For production, configure the API base URL via environment variables:

```typescript
const configuration = new Configuration({
  basePath:
    process.env.NASHIK_DARSHAN_API_URL ||
    "https://api.nashikdarshan.com/api/v1",
  accessToken: process.env.NASHIK_DARSHAN_ACCESS_TOKEN,
});
```

## License

This SDK is proprietary software. See [LICENSE](./LICENSE) for details.

- **Personal and non-commercial use**: Permitted
- **Commercial use**: Requires explicit permission from Caygnus
- Contact: support@caygnus.com for commercial licensing

## Support

- **Documentation**: [GitHub Repository](https://github.com/Caygnus/nashik-darshan-v2)
- **API Docs**: Available at `/swagger/index.html` when server is running
- **Issues**: [GitHub Issues](https://github.com/Caygnus/nashik-darshan-v2/issues)
- **Email**: support@caygnus.com

## Version

Current version: See `package.json` or run:

```bash
npm list @caygnus/nashik-darshan-sdk
```

## Contributing

This SDK is auto-generated from the OpenAPI specification. To contribute:

1. Make changes to the API specification
2. Regenerate the SDK using the project's Makefile
3. Submit a pull request with your changes

For more information, see the [main repository](https://github.com/Caygnus/nashik-darshan-v2).
