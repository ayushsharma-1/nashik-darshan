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
// basePath should be the FULL URL including protocol (http:// or https://)
const configuration = new Configuration({
  basePath: "https://api.example.com/api/v1", // Full URL required
  // Optional: Add authentication token
  accessToken: "your-access-token-here",
});

// Initialize API clients
// API constructors: new ApiClass(configuration?, basePath?, axios?)
// All parameters are optional - you can just pass the Configuration object
// The basePath from Configuration will be used automatically
const authApi = new AuthApi(configuration);
const placeApi = new PlaceApi(configuration);
```

**Note about basePath:**

- `basePath` must be the **complete URL** including protocol (e.g., `https://api.example.com/api/v1`)
- You only need to set it **once** in the Configuration object
- All API clients created with the same Configuration will use the same basePath
- If using a custom axios instance with `baseURL` set, the SDK will use that instead (see Custom Axios section)

### Authentication

The SDK supports Bearer token authentication. Set your access token when creating the configuration:

```typescript
import { Configuration } from "@caygnus/nashik-darshan-sdk";

const configuration = new Configuration({
  basePath: "https://api.example.com/api/v1",
  accessToken: "your-bearer-token",
});
```

### Using Custom Axios Instance

You can configure the SDK to use your own axios instance with custom interceptors, default headers, or other configurations. The API classes extend `BaseAPI` which accepts an axios instance as the third constructor parameter.

#### Basic Custom Axios Setup

```typescript
import { Configuration, PlaceApi } from "@caygnus/nashik-darshan-sdk";
import axios, { AxiosInstance } from "axios";

// Create your custom axios instance
// If you set baseURL in axios, you don't need to set basePath in Configuration
const customAxios: AxiosInstance = axios.create({
  baseURL: "https://api.example.com/api/v1", // Full URL with protocol
  timeout: 10000,
  headers: {
    "Content-Type": "application/json",
  },
});

// Add request interceptor (e.g., for authentication)
customAxios.interceptors.request.use(
  (config) => {
    // Add auth token from your auth system
    const token = localStorage.getItem("authToken");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add response interceptor (e.g., for error handling)
customAxios.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Handle unauthorized - redirect to login, refresh token, etc.
      console.error("Unauthorized - please login");
    }
    return Promise.reject(error);
  }
);

// Use custom axios instance with SDK
// API constructors: new ApiClass(configuration?, basePath?, axios?)
// Since axios has baseURL set, basePath in Configuration is optional
const configuration = new Configuration({
  // basePath is optional if axios.defaults.baseURL is set
  // If not using axios baseURL, set full URL: basePath: "https://api.example.com/api/v1"
});

// Pass axios instance as third parameter to API constructor
// The SDK will use axios.defaults.baseURL if set, otherwise configuration.basePath
const placeApi = new PlaceApi(configuration, undefined, customAxios);
```

#### Using Global Axios Configuration

If you have a global axios instance configured elsewhere in your application, you can reuse it:

```typescript
import { Configuration, PlaceApi, AuthApi } from "@caygnus/nashik-darshan-sdk";
import axios from "axios";

// Your global axios instance (configured elsewhere in your app)
// This might be in a separate axios config file like: src/lib/axios.ts
// If baseURL is set in axios, you don't need basePath in Configuration
const globalAxios = axios.create({
  baseURL:
    process.env.REACT_APP_API_URL || "https://api.example.com/api/v1", // Full URL
  timeout: 30000,
});

// Add global interceptors (if not already added)
globalAxios.interceptors.request.use(/* your request interceptor */);
globalAxios.interceptors.response.use(/* your response interceptor */);

// Use with SDK
// Since axios has baseURL set, basePath in Configuration is optional
const configuration = new Configuration({
  // basePath not needed if axios.defaults.baseURL is set
});

// All API clients will use your global axios instance
// The SDK automatically uses axios.defaults.baseURL when available
const placeApi = new PlaceApi(configuration, undefined, globalAxios);
const authApi = new AuthApi(configuration, undefined, globalAxios);
```

#### Advanced: Shared Axios Instance Across All APIs

For better code organization, create a helper function to initialize all APIs with a shared axios instance:

```typescript
import {
  Configuration,
  AuthApi,
  PlaceApi,
  CategoryApi,
  FeedApi,
  ReviewsApi,
  UserApi,
} from "@caygnus/nashik-darshan-sdk";
import axios, { AxiosInstance } from "axios";

// Create shared axios instance with interceptors
function createAxiosInstance(): AxiosInstance {
  const instance = axios.create({
    baseURL:
      process.env.NEXT_PUBLIC_API_URL || "https://api.example.com/api/v1",
    timeout: 30000,
  });

  // Request interceptor
  instance.interceptors.request.use(
    (config) => {
      const token = getAuthToken(); // Your token retrieval logic
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    },
    (error) => Promise.reject(error)
  );

  // Response interceptor
  instance.interceptors.response.use(
    (response) => response,
    async (error) => {
      if (error.response?.status === 401) {
        // Handle token refresh or redirect
        await handleUnauthorized();
      }
      return Promise.reject(error);
    }
  );

  return instance;
}

// Initialize all APIs with shared axios instance
const basePath =
  process.env.NEXT_PUBLIC_API_URL || "https://api.example.com/api/v1";
const configuration = new Configuration({ basePath });
const axiosInstance = createAxiosInstance();

export const apis = {
  auth: new AuthApi(configuration, basePath, axiosInstance),
  places: new PlaceApi(configuration, basePath, axiosInstance),
  categories: new CategoryApi(configuration, basePath, axiosInstance),
  feed: new FeedApi(configuration, basePath, axiosInstance),
  reviews: new ReviewsApi(configuration, basePath, axiosInstance),
  user: new UserApi(configuration, basePath, axiosInstance),
};

// Use in your application
const places = await apis.places.placesGet({ limit: 10 });
```

#### React/Next.js Example with Axios Provider

For React applications, you can create a context provider for your axios instance:

```typescript
// lib/api-client.tsx
import { createContext, useContext, ReactNode } from "react";
import { Configuration, AuthApi, PlaceApi } from "@caygnus/nashik-darshan-sdk";
import axios, { AxiosInstance } from "axios";

const ApiClientContext = createContext<{
  authApi: AuthApi;
  placeApi: PlaceApi;
} | null>(null);

export function ApiClientProvider({ children }: { children: ReactNode }) {
  const axiosInstance: AxiosInstance = axios.create({
    baseURL:
      process.env.NEXT_PUBLIC_API_URL || "https://api.example.com/api/v1",
  });

  // Add interceptors
  axiosInstance.interceptors.request.use((config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  });

  // Since axiosInstance has baseURL set, basePath in Configuration is optional
  const config = new Configuration({
    // basePath not needed - axios.defaults.baseURL will be used
  });

  const apis = {
    authApi: new AuthApi(config, undefined, axiosInstance),
    placeApi: new PlaceApi(config, undefined, axiosInstance),
  };

  return (
    <ApiClientContext.Provider value={apis}>
      {children}
    </ApiClientContext.Provider>
  );
}

export function useApiClient() {
  const context = useContext(ApiClientContext);
  if (!context) {
    throw new Error("useApiClient must be used within ApiClientProvider");
  }
  return context;
}

// Usage in components
function MyComponent() {
  const { placeApi } = useApiClient();
  // Use placeApi...
}
```

### Understanding basePath vs axios baseURL

**Important:** You don't need to set the URL multiple times. The SDK uses this priority:

1. **If axios instance has `baseURL` set** → Uses that (no need for `basePath` in Configuration)
2. **Otherwise** → Uses `basePath` from Configuration (must be full URL with protocol)
3. **Otherwise** → Uses default `http://localhost:8080/api/v1`

**Key points:**

- Set the URL **once** in either `Configuration.basePath` OR `axios.defaults.baseURL`
- `basePath` must be the **complete URL** including protocol (e.g., `https://api.example.com/api/v1`)
- If using custom axios with `baseURL`, you can omit `basePath` in Configuration
- All API clients created with the same Configuration share the same basePath

### Advanced: Shared Axios Instance Across All APIs

For better code organization, create a helper function to initialize all APIs with a shared axios instance:

```typescript
import {
  Configuration,
  AuthApi,
  PlaceApi,
  CategoryApi,
  FeedApi,
  ReviewsApi,
  UserApi,
} from "@caygnus/nashik-darshan-sdk";
import axios, { AxiosInstance } from "axios";

// Create shared axios instance
function createAxiosInstance(): AxiosInstance {
  const instance = axios.create({
    baseURL:
      process.env.NEXT_PUBLIC_API_URL || "https://api.example.com/api/v1",
    timeout: 30000,
  });

  // Request interceptor
  instance.interceptors.request.use(
    (config) => {
      const token = getAuthToken(); // Your token retrieval logic
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    },
    (error) => Promise.reject(error)
  );

  // Response interceptor
  instance.interceptors.response.use(
    (response) => response,
    async (error) => {
      if (error.response?.status === 401) {
        // Handle token refresh or redirect
        await handleUnauthorized();
      }
      return Promise.reject(error);
    }
  );

  return instance;
}

// Initialize all APIs with shared axios instance
const basePath =
  process.env.NEXT_PUBLIC_API_URL || "https://api.example.com/api/v1";
const configuration = new Configuration({ basePath });
const axiosInstance = createAxiosInstance();

export const apis = {
  auth: new AuthApi(configuration, basePath, axiosInstance),
  places: new PlaceApi(configuration, basePath, axiosInstance),
  categories: new CategoryApi(configuration, basePath, axiosInstance),
  feed: new FeedApi(configuration, basePath, axiosInstance),
  reviews: new ReviewsApi(configuration, basePath, axiosInstance),
  user: new UserApi(configuration, basePath, axiosInstance),
};

// Use in your application
const places = await apis.places.placesGet({ limit: 10 });
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
    "https://api.example.com/api/v1",
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
