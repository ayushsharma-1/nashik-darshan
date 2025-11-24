# Developer Guide

A comprehensive guide for developers working on the Nashik Darshan v2 backend.

> 📖 **This is a detailed reference guide. For project overview and quick start, see [README.md](./README.md)**

## Table of Contents

- [Quick Start](#quick-start)
- [Development Workflow](#development-workflow)
- [Make Commands Reference](#make-commands-reference)
- [SDK Development](#sdk-development)
- [Common Tasks](#common-tasks)
- [Troubleshooting](#troubleshooting)

## Quick Start

### First Time Setup

```bash
# 1. Clone the repository
git clone https://github.com/Caygnus/nashik-darshan-v2.git
cd nashik-darshan-v2

# 2. Install Go dependencies
go mod download

# 3. Install Git hooks (recommended)
make install-hooks

# 4. Generate development keys
make generate-dev-keys

# 5. Generate Ent code
make generate-ent

# 6. Run migrations
make migrate-ent

# 7. Generate API documentation
make swagger

# 8. Start the server
make run
```

## Development Workflow

### Daily Development Cycle

1. **Start your day:**

   ```bash
   git pull origin main
   make run
   ```

2. **Make changes:**

   - Edit code
   - Test locally
   - Run linter: `make lint-fix`

3. **Before committing:**

   ```bash
   make lint-fix          # Auto-fix issues
   make run-hooks         # Run pre-commit checks
   ```

4. **Commit and push:**
   ```bash
   git add .
   git commit -m "feat: your feature description"
   git push
   ```

### Schema Changes Workflow

When modifying database schemas:

```bash
# 1. Edit schema files in ent/schema/
vim ent/schema/your_schema.go

# 2. Generate Ent code
make generate-ent

# 3. Run migrations
make migrate-ent

# 4. Update API documentation
make swagger

# 5. Regenerate SDKs (if API changed)
make generate-sdks
```

### API Changes Workflow

When modifying API endpoints or DTOs:

```bash
# 1. Edit API handlers in internal/api/v1/
# 2. Edit DTOs in internal/api/dto/

# 3. Update documentation
make swagger

# 4. Regenerate SDKs
make generate-sdks

# 5. Test the changes
make run
```

## Make Commands Reference

### Code Generation

| Command              | Description                       | When to Use                          |
| -------------------- | --------------------------------- | ------------------------------------ |
| `make generate-ent`  | Generate Ent ORM code from schema | After modifying `ent/schema/` files  |
| `make swagger`       | Generate API documentation        | After modifying API handlers or DTOs |
| `make swagger-2-0`   | Generate Swagger 2.0 only         | When you only need Swagger 2.0       |
| `make swagger-3-0`   | Convert to OpenAPI 3.0            | When you only need OpenAPI 3.0       |
| `make swagger-clean` | Clean generated swagger files     | To start fresh                       |

### Database

| Command            | Description             | When to Use                            |
| ------------------ | ----------------------- | -------------------------------------- |
| `make migrate-ent` | Run database migrations | After schema changes or on fresh setup |

### Development

| Command      | Description              | When to Use       |
| ------------ | ------------------------ | ----------------- |
| `make run`   | Start development server | Daily development |
| `make build` | Build production binary  | Before deployment |

### SDK Generation

| Command                  | Description                            | When to Use                 |
| ------------------------ | -------------------------------------- | --------------------------- |
| `make generate-sdks`     | Generate both TypeScript and Dart SDKs | After API changes           |
| `make generate-ts-sdk`   | Generate TypeScript SDK only           | When you only need TS SDK   |
| `make generate-dart-sdk` | Generate Dart SDK only                 | When you only need Dart SDK |
| `make clean-sdks`        | Clean generated SDK directories        | To start fresh              |
| `make verify-sdks`       | Verify generated SDKs are complete     | Before publishing           |

### SDK Version Management

| Command                               | Description                   | Example                               |
| ------------------------------------- | ----------------------------- | ------------------------------------- |
| `make version-sdks VERSION=x.y.z`     | Update both SDK versions      | `make version-sdks VERSION=1.0.1`     |
| `make version-ts-sdk VERSION=x.y.z`   | Update TypeScript SDK version | `make version-ts-sdk VERSION=1.0.1`   |
| `make version-dart-sdk VERSION=x.y.z` | Update Dart SDK version       | `make version-dart-sdk VERSION=1.0.1` |

### SDK Publishing

| Command                         | Description                     | When to Use                      |
| ------------------------------- | ------------------------------- | -------------------------------- |
| `make publish-sdks`             | Publish both SDKs to registries | After version update and testing |
| `make publish-ts-sdk`           | Publish TypeScript SDK to npm   | When ready to publish TS SDK     |
| `make publish-dart-sdk`         | Publish Dart SDK to pub.dev     | When ready to publish Dart SDK   |
| `make publish-ts-sdk-dry-run`   | Test TypeScript SDK publish     | Before actual publish            |
| `make publish-dart-sdk-dry-run` | Test Dart SDK publish           | Before actual publish            |

### SDK Setup

| Command             | Description                   | When to Use                    |
| ------------------- | ----------------------------- | ------------------------------ |
| `make install-deps` | Install openapi-generator-cli | First time SDK generation      |
| `make check-env`    | Verify all required tools     | Troubleshooting or first setup |

### Code Quality

| Command              | Description                  | When to Use               |
| -------------------- | ---------------------------- | ------------------------- |
| `make lint-fix`      | Auto-fix linting issues      | Before committing         |
| `make install-hooks` | Install git pre-commit hooks | First time setup          |
| `make run-hooks`     | Manually run git hooks       | To test pre-commit checks |

### Security

| Command                  | Description                   | When to Use             |
| ------------------------ | ----------------------------- | ----------------------- |
| `make generate-dev-keys` | Generate unencrypted RSA keys | Development environment |
| `make generate-keys`     | Generate encrypted RSA keys   | Production environment  |

## SDK Development

### Generating SDKs

SDKs are automatically generated from the OpenAPI specification:

```bash
# Generate both SDKs
make generate-sdks

# Or generate individually
make generate-ts-sdk
make generate-dart-sdk
```

**Prerequisites:**

- Node.js >= 18
- npm
- Java (for openapi-generator-cli)
- Dart SDK

The `make generate-sdks` command will:

1. Install `openapi-generator-cli` if missing
2. Verify all required tools
3. Generate TypeScript SDK to `sdks/ts/`
4. Generate Dart SDK to `sdks/dart/`

### Publishing SDKs

**Workflow:**

```bash
# 1. Update API (if needed)
make swagger
make generate-sdks

# 2. Update versions
make version-sdks VERSION=1.0.1

# 3. Test before publishing
make publish-ts-sdk-dry-run
make publish-dart-sdk-dry-run

# 4. Publish
make publish-sdks
```

**Authentication:**

- **npm**: Run `npm login` or set `NPM_TOKEN` environment variable
- **pub.dev**: Run `dart pub token add https://pub.dev`

For detailed publishing instructions, see [`sdks/PUBLISHING.md`](./sdks/PUBLISHING.md).

## Common Tasks

### Adding a New Feature

1. **Create schema** (if database changes needed):

   ```bash
   # Edit ent/schema/your_feature.go
   make generate-ent
   make migrate-ent
   ```

2. **Create domain model**:

   - Add to `internal/domain/your_feature/`

3. **Create repository**:

   - Add to `internal/repository/ent/your_feature.go`

4. **Create service**:

   - Add to `internal/service/your_feature.go`

5. **Create API handler**:

   - Add DTOs to `internal/api/dto/your_feature.go`
   - Add handlers to `internal/api/v1/your_feature.go`

6. **Update documentation**:
   ```bash
   make swagger
   make generate-sdks
   ```

### Updating API Documentation

```bash
# After modifying API handlers or DTOs
make swagger

# This generates:
# - docs/swagger/swagger.json (Swagger 2.0)
# - docs/swagger/swagger.yaml (Swagger 2.0 YAML)
# - docs/swagger/swagger-3-0.json (OpenAPI 3.0)
```

### Regenerating SDKs

```bash
# After API changes
make swagger              # Update OpenAPI spec first
make generate-sdks        # Regenerate both SDKs
```

### Publishing a New SDK Version

```bash
# 1. Make sure API is up to date
make swagger
make generate-sdks

# 2. Update version (use semantic versioning)
make version-sdks VERSION=1.0.1

# 3. Test
make verify-sdks
make publish-ts-sdk-dry-run
make publish-dart-sdk-dry-run

# 4. Publish
make publish-sdks

# 5. Create git tag
git tag v1.0.1
git push origin v1.0.1
```

### Resetting Development Environment

```bash
# Clean generated files
make swagger-clean
make clean-sdks

# Regenerate everything
make generate-ent
make swagger
make generate-sdks
```

## Troubleshooting

### SDK Generation Fails

**Problem**: `openapi-generator-cli` not found

**Solution**:

```bash
make install-deps
```

**Problem**: Missing dependencies

**Solution**:

```bash
make check-env  # Shows what's missing
# Install missing tools, then:
make generate-sdks
```

### Swagger Generation Fails

**Problem**: `swag` command not found

**Solution**:

```bash
make install-swag  # Automatically installs swag
make swagger
```

### Database Migration Issues

**Problem**: Migration conflicts

**Solution**:

```bash
# Check migration status
# Manually resolve conflicts in database
# Then continue with:
make migrate-ent
```

### Publishing Fails

**Problem**: npm authentication error

**Solution**:

```bash
npm login
# Or set NPM_TOKEN environment variable
make publish-ts-sdk
```

**Problem**: pub.dev authentication error

**Solution**:

```bash
dart pub token add https://pub.dev
make publish-dart-sdk
```

### Version Update Fails

**Problem**: Version format error

**Solution**:

- Use semantic versioning: `MAJOR.MINOR.PATCH`
- Example: `1.0.1`, `1.1.0`, `2.0.0`
- Don't include 'v' prefix in VERSION parameter

## Best Practices

1. **Always run linter before committing:**

   ```bash
   make lint-fix
   ```

2. **Keep SDKs in sync:**

   - Use same version for both SDKs
   - Regenerate both after API changes

3. **Test before publishing:**

   - Always run dry-run before actual publish
   - Verify SDKs are complete

4. **Use semantic versioning:**

   - `MAJOR`: Breaking changes
   - `MINOR`: New features (backward compatible)
   - `PATCH`: Bug fixes

5. **Document API changes:**
   - Update Swagger annotations
   - Regenerate documentation
   - Update SDKs

## Getting Help

- **SDK Issues**: See [`sdks/README.md`](./sdks/README.md)
- **Publishing**: See [`sdks/PUBLISHING.md`](./sdks/PUBLISHING.md)
- **Architecture**: See [`sdks/ARCHITECTURE.md`](./sdks/ARCHITECTURE.md)
- **Configuration**: See [`CONFIG.md`](./CONFIG.md)
