# SDK Architecture: Monorepo Approach

> 📖 **Navigation:** [README.md](../README.md) → [SDK Generation](../README.md#sdk-generation--publishing) → This Guide

## Why Monorepo Instead of Separate Repositories?

We've chosen a **monorepo approach** for managing our SDKs. Here's why this is the ideal solution for publishing to package registries:

## ✅ Advantages of Monorepo

### 1. **Single Source of Truth**

- One OpenAPI specification (`docs/swagger/swagger.yaml`)
- All SDKs generated from the same source
- No synchronization issues between repos
- Easier to maintain consistency

### 2. **Simplified Version Management**

- Both SDKs can share the same version number
- Single command to update versions: `make version-sdks VERSION=1.0.1`
- Easier to track which API version corresponds to which SDK version

### 3. **Unified CI/CD**

- One GitHub Actions workflow publishes both SDKs
- Single release process
- Consistent deployment pipeline

### 4. **Better Developer Experience**

- Developers work in one repository
- Easier to test SDK changes alongside API changes
- Single place to find documentation

### 5. **Cost Effective**

- One repository to maintain
- One CI/CD pipeline
- Less overhead

## 📦 Publishing Strategy

### Independent Publishing

Even though SDKs are in the same repo, they are **published independently**:

- **TypeScript SDK** → npm (`@caygnus/nashik-darshan-sdk`)
- **Dart SDK** → pub.dev (`nashik_darshan_sdk`)

Each SDK:

- Has its own package configuration
- Can be versioned independently (though we recommend keeping them in sync)
- Is published to its respective registry
- Can be installed independently by end users

### Version Synchronization

**Recommended**: Keep both SDKs at the same version number for consistency.

```bash
# Update both to same version
make version-sdks VERSION=1.0.1
```

**Alternative**: Version independently if needed (rare cases):

```bash
make version-ts-sdk VERSION=1.0.1
make version-dart-sdk VERSION=1.0.2
```

## 🔄 Workflow Comparison

### Monorepo Workflow (Current)

```
1. Update API → make swagger
2. Regenerate SDKs → make generate-sdks
3. Update versions → make version-sdks VERSION=1.0.1
4. Publish → make publish-sdks
5. Create git tag → git tag v1.0.1
```

**Total**: 5 steps, all in one repo

### Separate Repos Workflow (Alternative)

```
1. Update API → make swagger
2. Push to main repo
3. Clone/update TypeScript SDK repo
4. Copy OpenAPI spec to TS repo
5. Generate TypeScript SDK
6. Update version in TS repo
7. Publish TypeScript SDK
8. Commit and push TS repo
9. Repeat steps 3-8 for Dart SDK
10. Create tags in 3 different repos
```

**Total**: 10+ steps, 3 repos to manage

## 🏗️ Repository Structure

```
nashik-darshan-v2/
├── docs/
│   └── swagger/
│       └── swagger.yaml          # Single source of truth
├── sdks/
│   ├── ts/                       # TypeScript SDK
│   │   ├── package.json          # npm package config
│   │   └── .openapi-generator-ignore
│   ├── dart/                     # Dart SDK
│   │   ├── pubspec.yaml          # pub.dev package config
│   │   └── .openapi-generator-ignore
│   ├── README.md
│   ├── PUBLISHING.md
│   └── ARCHITECTURE.md           # This file
└── .github/
    └── workflows/
        └── publish-sdks.yml      # Automated publishing
```

## 🚀 Publishing Process

### Manual Publishing

```bash
# 1. Regenerate SDKs
make generate-sdks

# 2. Update versions
make version-sdks VERSION=1.0.1

# 3. Publish
make publish-sdks
```

### Automated Publishing (Recommended)

1. Create a GitHub Release with tag `v1.0.1`
2. GitHub Actions automatically:
   - Generates SDKs
   - Updates versions
   - Publishes to npm and pub.dev

## 📊 When to Use Separate Repos

Separate repos make sense when:

- ❌ SDKs have completely different release cycles
- ❌ Different teams maintain each SDK
- ❌ SDKs need independent versioning strategies
- ❌ You want separate issue trackers per SDK
- ❌ SDKs have different dependencies/lifecycles

**For our use case**: None of these apply. Monorepo is the better choice.

## 🔐 Security & Access Control

### npm (TypeScript SDK)

- Requires `@caygnus` organization membership
- Set `NPM_TOKEN` secret in GitHub
- Package is scoped: `@caygnus/nashik-darshan-sdk`

### pub.dev (Dart SDK)

- Requires Google account
- Set `PUB_CREDENTIALS` secret in GitHub (optional)
- Package name: `nashik_darshan_sdk`

## 📝 Best Practices

1. **Keep versions in sync** between SDKs
2. **Tag releases** in git for traceability
3. **Test before publishing** using dry-run
4. **Update changelogs** with each release
5. **Use semantic versioning** (MAJOR.MINOR.PATCH)

## 🎯 Summary

**Monorepo is the right choice** because:

- ✅ Simpler workflow
- ✅ Better consistency
- ✅ Easier maintenance
- ✅ Single source of truth
- ✅ Independent publishing still possible

You get all the benefits of separate repos (independent publishing) with none of the drawbacks (synchronization issues, multiple repos to manage).
