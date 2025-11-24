# SDK Publishing Guide

This guide explains how to publish the Nashik Darshan SDKs to their respective package registries.

> 📖 **Navigation:** [README.md](../README.md) → [SDK Generation](../README.md#sdk-generation--publishing) → This Guide

## Overview

We use a **monorepo approach** - both SDKs are maintained in the same repository but published independently to:

- **TypeScript SDK**: npm (`@caygnus/nashik-darshan-sdk`)
- **Dart SDK**: pub.dev (`nashik_darshan_sdk`)

## Prerequisites

### For TypeScript SDK (npm)

1. **npm account** with access to `@caygnus` organization
2. **Authentication** (choose one method):
   - **Method 1 (Recommended)**: Add token to `.env` file
     ```bash
     # Get token from: https://www.npmjs.com/settings/YOUR_USERNAME/tokens
     # Add to .env file:
     NPM_TOKEN=your_npm_token_here
     ```
   - **Method 2**: Use npm login
     ```bash
     npm login
     ```

### For Dart SDK (pub.dev)

1. **pub.dev account** (Google account)
2. **Authentication** (choose one method):
   - **Method 1 (Recommended)**: Add credentials to `.env` file
     ```bash
     # First, get credentials by running:
     dart pub token add https://pub.dev
     # Then copy credentials from ~/.pub-cache/credentials.json
     # Add to .env file:
     PUB_CREDENTIALS='{"accessToken":"...","refreshToken":"..."}'
     ```
   - **Method 2**: Use existing pub token
     ```bash
     dart pub token add https://pub.dev
     # Follow the prompts to authenticate
     ```

### Setting Up .env File

1. Copy the example file:

   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and add your tokens:

   ```bash
   NPM_TOKEN=your_actual_npm_token
   PUB_CREDENTIALS='{"accessToken":"...","refreshToken":"..."}'
   ```

3. The `.env` file is gitignored and will not be committed.

## Publishing Workflow

### Step 1: Update API Specification

If you've made API changes, regenerate the OpenAPI spec:

```bash
make swagger
```

### Step 2: Regenerate SDKs

Regenerate both SDKs with the latest API changes:

```bash
make generate-sdks
```

### Step 3: Update Versions

Update version numbers for both SDKs:

```bash
# Update both SDKs to the same version
make version-sdks VERSION=1.0.1

# Or update individually
make version-ts-sdk VERSION=1.0.1
make version-dart-sdk VERSION=1.0.1
```

**Version Format**: Follow [Semantic Versioning](https://semver.org/):

- `MAJOR.MINOR.PATCH` (e.g., `1.0.0`)
- `MAJOR`: Breaking changes
- `MINOR`: New features (backward compatible)
- `PATCH`: Bug fixes (backward compatible)

### Step 4: Test Before Publishing

Run dry-run to verify everything is correct:

```bash
# TypeScript SDK
make publish-ts-sdk-dry-run

# Dart SDK
make publish-dart-sdk-dry-run
```

### Step 5: Publish

Publish to registries:

```bash
# Publish both SDKs
make publish-sdks

# Or publish individually
make publish-ts-sdk
make publish-dart-sdk
```

## CI/CD Publishing (Recommended)

For production, set up automated publishing via GitHub Actions.

### Environment Variables

The publishing scripts automatically check for tokens in `.env` file first, then fallback to default authentication.

For GitHub Actions, set these secrets:

- `NPM_TOKEN`: npm authentication token
- `PUB_CREDENTIALS`: pub.dev credentials (optional, can use `pub token`)

**Local Publishing**: Use `.env` file (see [Setting Up .env File](#setting-up-env-file) above)

### Automated Workflow

Create `.github/workflows/publish-sdks.yml`:

```yaml
name: Publish SDKs

on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "18"
      - uses: dart-lang/setup-dart@v1

      - name: Install dependencies
        run: make install-deps

      - name: Generate SDKs
        run: make generate-sdks

      - name: Extract version from tag
        id: version
        run: echo "VERSION=${GITHUB_REF#refs/tags/v}" >> $GITHUB_OUTPUT

      - name: Update SDK versions
        run: make version-sdks VERSION=${{ steps.version.outputs.VERSION }}

      - name: Publish TypeScript SDK
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
        run: |
          cd sdks/ts
          echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > .npmrc
          npm publish

      - name: Publish Dart SDK
        run: |
          cd sdks/dart
          dart pub publish --force
```

Then publish by creating a GitHub Release with a tag like `v1.0.1`.

## Manual Publishing Steps

### TypeScript SDK (npm)

```bash
# Option 1: Using .env file (recommended)
# Add NPM_TOKEN=your_token to .env, then:
make publish-ts-sdk

# Option 2: Using npm login
npm login
make publish-ts-sdk

# Or publish manually:
cd sdks/ts
npm publish
```

### Dart SDK (pub.dev)

```bash
# Option 1: Using .env file (recommended)
# Add PUB_CREDENTIALS='{"accessToken":"..."}' to .env, then:
make publish-dart-sdk

# Option 2: Using pub token
dart pub token add https://pub.dev
make publish-dart-sdk

# Or publish manually:
cd sdks/dart
dart pub publish --force
```

## Version Management Strategy

### Recommended Approach

1. **Keep SDKs in sync**: Use the same version number for both SDKs
2. **Tag releases**: Create git tags matching SDK versions
3. **Changelog**: Maintain `CHANGELOG.md` in each SDK directory

### Version Bumping

```bash
# Patch release (bug fixes)
make version-sdks VERSION=1.0.1

# Minor release (new features)
make version-sdks VERSION=1.1.0

# Major release (breaking changes)
make version-sdks VERSION=2.0.0
```

## Troubleshooting

### npm: Package name already exists

If you see "package name already exists":

- Check if the version already exists: `npm view @caygnus/nashik-darshan-sdk versions`
- Bump the version number
- For scoped packages, ensure you have the correct permissions

### pub.dev: Package already exists

If you see "package already exists":

- Check existing versions: Visit `https://pub.dev/packages/nashik_darshan_sdk`
- Bump the version number in `pubspec.yaml`

### Authentication Issues

**npm**:

```bash
npm whoami  # Check if logged in
npm login   # Re-login if needed
```

**pub.dev**:

```bash
dart pub token list  # List tokens
dart pub token add https://pub.dev  # Add token
```

### SDK Generation Issues

If SDKs fail to generate:

```bash
# Clean and regenerate
make clean-sdks
make generate-sdks
```

## Best Practices

1. **Always test locally** before publishing
2. **Use dry-run** to verify package contents
3. **Keep versions in sync** between TypeScript and Dart SDKs
4. **Tag releases** in git for traceability
5. **Update changelogs** with each release
6. **Test SDKs** after publishing by installing them

## Package Information

### TypeScript SDK

- **Package**: `@caygnus/nashik-darshan-sdk`
- **Registry**: npmjs.org
- **Install**: `npm install @caygnus/nashik-darshan-sdk`

### Dart SDK

- **Package**: `nashik_darshan_sdk`
- **Registry**: pub.dev
- **Install**: Add to `pubspec.yaml`:
  ```yaml
  dependencies:
    nashik_darshan_sdk: ^1.0.0
  ```

## Support

For publishing issues:

1. Check this guide
2. Verify authentication
3. Check package registries for existing versions
4. Review Makefile targets: `make help` (if implemented)
