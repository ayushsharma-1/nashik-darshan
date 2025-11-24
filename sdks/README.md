# SDK Generation

This directory contains generated SDKs for the Nashik Darshan API.

> 📖 **For project overview, see [README.md](../README.md)** | **For developer reference, see [DEVELOPER_GUIDE.md](../DEVELOPER_GUIDE.md)**

## Generated SDKs

- **TypeScript SDK** (`ts/`) - Generated using `typescript-axios` generator
  - **Package**: `@caygnus/nashik-darshan-sdk` on npm
- **Dart SDK** (`dart/`) - Generated using `dart-dio` generator
  - **Package**: `nashik_darshan_sdk` on pub.dev

## Quick Start

### Generate All SDKs

```bash
make generate-sdks
```

### Publish SDKs

See [PUBLISHING.md](./PUBLISHING.md) for detailed publishing instructions.

```bash
# Update versions
make version-sdks VERSION=1.0.1

# Publish both SDKs
make publish-sdks
```

## Generation Workflow

### Prerequisites

Ensure you have the following installed:

- Node.js >= 18
- npm
- Java (required by openapi-generator-cli)
- Dart SDK
- openapi-generator-cli (will be installed automatically if missing)

### Generate All SDKs

```bash
make generate-sdks
```

This will:

1. Install missing dependencies (`openapi-generator-cli`)
2. Verify all required tools are installed
3. Generate TypeScript SDK
4. Generate Dart SDK

### Generate Individual SDKs

```bash
# TypeScript only
make generate-ts-sdk

# Dart only
make generate-dart-sdk
```

### Clean Generated SDKs

```bash
make clean-sdks
```

### Verify SDKs

```bash
make verify-sdks
```

## Customization

### Preserving Custom Files

The `.openapi-generator-ignore` files in each SDK directory specify which files should be preserved during regeneration. Add any custom files or configurations to these ignore files.

**Important**: The `package.json` (TypeScript) and `pubspec.yaml` (Dart) files are customized for publishing and are preserved during regeneration.

### TypeScript SDK Customization

Edit `sdks/ts/.openapi-generator-ignore` to preserve:

- Custom package.json configurations
- Custom TypeScript configurations
- Custom test files
- Example files

### Dart SDK Customization

Edit `sdks/dart/.openapi-generator-ignore` to preserve:

- Custom pubspec.yaml configurations
- Custom analysis_options.yaml
- Custom test files
- Example files

## Source Specification

The SDKs are generated from:

- **Source**: `docs/swagger/swagger.yaml`

To regenerate SDKs after API changes:

1. Update the OpenAPI specification: `make swagger`
2. Regenerate SDKs: `make generate-sdks`

## Publishing

### Monorepo Approach

We use a **monorepo approach** - both SDKs are maintained in the same repository but published independently to their respective registries. This provides:

- ✅ Single source of truth
- ✅ Easier version synchronization
- ✅ Simplified CI/CD
- ✅ Better developer experience

### Publishing Workflow

1. **Update API** (if needed): `make swagger`
2. **Regenerate SDKs**: `make generate-sdks`
3. **Update versions**: `make version-sdks VERSION=1.0.1`
4. **Publish**: `make publish-sdks`

For detailed publishing instructions, see [PUBLISHING.md](./PUBLISHING.md).

### Automated Publishing

SDKs can be automatically published via GitHub Actions when you create a release:

1. Create a GitHub Release with tag `v1.0.1`
2. GitHub Actions will automatically:
   - Generate SDKs
   - Update versions
   - Publish to npm and pub.dev

See `.github/workflows/publish-sdks.yml` for the workflow configuration.

## Production Notes

- Generated SDKs are version-controlled but build artifacts are ignored
- `.openapi-generator/` directories contain generator metadata and are ignored
- `git_push.sh` scripts are generated but ignored (not needed for monorepo)
- Node modules and build artifacts are excluded from version control
- Package configurations (`package.json`, `pubspec.yaml`) are customized for publishing and preserved during regeneration

## Troubleshooting

### Generator Not Found

If you see "generator not found" errors:

```bash
make install-deps
```

### Version Mismatch

Check your tool versions:

```bash
make check-env
```

### Clean Regeneration

If generation fails, try cleaning first:

```bash
make clean-sdks
make generate-sdks
```

### Publishing Issues

See [PUBLISHING.md](./PUBLISHING.md) for troubleshooting publishing problems.

## Package Information

### TypeScript SDK

- **Name**: `@caygnus/nashik-darshan-sdk`
- **Registry**: npmjs.org
- **Install**: `npm install @caygnus/nashik-darshan-sdk`

### Dart SDK

- **Name**: `nashik_darshan_sdk`
- **Registry**: pub.dev
- **Install**: Add to `pubspec.yaml`:
  ```yaml
  dependencies:
    nashik_darshan_sdk: ^1.0.0
  ```
