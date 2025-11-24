# ============================================================================
# Database Management
# ============================================================================

# migrate-ent: Run database migrations
# Usage: make migrate-ent
# What it does: Executes Ent database migrations to update your database schema
# Command: go run cmd/migrate/main.go
.PHONY: migrate-ent
migrate-ent:
	@echo "Running Ent migrations..."
	@go run cmd/migrate/main.go
	@echo "✅ Ent migrations complete"

# ============================================================================
# Code Generation
# ============================================================================

# generate-ent: Generate Ent ORM code from schema definitions
# Usage: make generate-ent
# What it does: Generates Go code from Ent schema files in ent/schema/
# Command: go run scripts/main.go -cmd generate-ent
# When to use: After modifying schema files in ent/schema/
.PHONY: generate-ent
generate-ent:
	@echo "Generating Ent schema..."
	@go run scripts/main.go -cmd generate-ent
	@echo "✅ Ent schema generated"

# generate-keys: Generate encrypted RSA key pair for production
# Usage: make generate-keys
# What it does: Creates encrypted RSA keys for production use
# Command: ./scripts/generate-keys.sh (script must be created)
# When to use: Before deploying to production
# Note: Script does not exist yet - needs to be implemented
.PHONY: generate-keys
generate-keys:
	@echo "Generating encrypted RSA key pair for production..."
	@./scripts/generate-keys.sh
	@echo "✅ Encrypted key pair generated"

# generate-dev-keys: Generate unencrypted RSA key pair for development
# Usage: make generate-dev-keys
# What it does: Creates unencrypted RSA keys for local development
# Command: ./scripts/generate-dev-keys.sh (script must be created)
# When to use: First time setup or local development
# Note: Script does not exist yet - needs to be implemented
.PHONY: generate-dev-keys
generate-dev-keys:
	@echo "Generating unencrypted RSA key pair for development..."
	@./scripts/generate-dev-keys.sh
	@echo "✅ Development key pair generated"

# ============================================================================
# Git & Code Quality
# ============================================================================

# install-hooks: Install Git pre-commit hooks
# Usage: make install-hooks
# What it does: Sets up Git hooks to run code quality checks before commits
# Command: git config core.hooksPath .githooks
# When to use: First time setup or when hooks need to be reinstalled
.PHONY: install-hooks
install-hooks:
	@echo "Installing Git hooks..."
	@git config core.hooksPath .githooks
	@chmod +x .githooks/pre-commit
	@echo "✅ Git hooks installed"

# run-hooks: Manually run Git pre-commit hooks
# Usage: make run-hooks
# What it does: Executes pre-commit hooks manually without committing
# Command: .githooks/pre-commit
# When to use: To test if your code passes pre-commit checks
.PHONY: run-hooks
run-hooks:
	@echo "Running Git hooks..."
	@.githooks/pre-commit

# lint-fix: Auto-fix linting issues in Go code
# Usage: make lint-fix
# What it does: Runs gofmt and golangci-lint to automatically fix code style issues
# Commands: gofmt -s -w . && golangci-lint run --fix
# When to use: Before committing code to fix formatting issues
.PHONY: lint-fix
lint-fix:
	@echo "🧼 Running gofmt to auto-format..."
	gofmt -s -w .
	@echo "🧹 Running golangci-lint with --fix (autofix where possible)..."
	golangci-lint run --fix || true
	@echo "✅ Lint fixes applied (where possible)."


# ============================================================================
# API Documentation (Swagger/OpenAPI)
# ============================================================================

# swagger: Generate complete API documentation (Swagger 2.0 + OpenAPI 3.0)
# Usage: make swagger
# What it does: Generates Swagger 2.0 docs and converts to OpenAPI 3.0
# Commands: Runs swagger-2-0 and swagger-3-0 targets
# When to use: After modifying API handlers or DTOs
.PHONY: swagger
swagger: swagger-2-0 swagger-3-0

# swagger-2-0: Generate Swagger 2.0 documentation
# Usage: make swagger-2-0
# What it does: Generates Swagger 2.0 JSON, YAML, and Go docs from code annotations
# Command: swag init (from swaggo/swag)
# When to use: When you only need Swagger 2.0 format
.PHONY: swagger-2-0
swagger-2-0: install-swag
	$(shell go env GOPATH)/bin/swag init \
		--generalInfo cmd/server/main.go \
		--dir . \
		--parseDependency \
		--parseInternal \
		--output docs/swagger \
		--generatedTime=false \
		--parseDepth 1 \
		--instanceName swagger \
		--parseVendor \
		--outputTypes go,json,yaml
	@make swagger-fix-refs

# swagger-3-0: Convert Swagger 2.0 to OpenAPI 3.0
# Usage: make swagger-3-0
# What it does: Converts existing Swagger 2.0 JSON to OpenAPI 3.0 format
# Command: curl POST to swagger.io converter API
# When to use: When you only need OpenAPI 3.0 format
.PHONY: swagger-3-0
swagger-3-0: install-swag
	@echo "Converting Swagger 2.0 to OpenAPI 3.0..."
	@curl -X 'POST' \
		'https://converter.swagger.io/api/convert' \
		-H 'accept: application/json' \
		-H 'Content-Type: application/json' \
		-d @docs/swagger/swagger.json > docs/swagger/swagger-3-0.json
	@echo "Conversion complete. Output saved to docs/swagger/swagger-3-0.json"

# swagger-fix-refs: Fix Swagger reference issues
# Usage: make swagger-fix-refs
# What it does: Post-processes Swagger files to fix reference problems
# Command: ./scripts/fix_swagger_refs.sh
# When to use: Automatically called by swagger-2-0, or manually if needed
.PHONY: swagger-fix-refs
swagger-fix-refs:
	@./scripts/fix_swagger_refs.sh

# swagger-clean: Remove all generated Swagger files
# Usage: make swagger-clean
# What it does: Deletes docs/swagger directory
# Command: rm -rf docs/swagger
# When to use: To start fresh with documentation generation
.PHONY: swagger-clean
swagger-clean:
	rm -rf docs/swagger

# install-swag: Install swag tool for Swagger generation
# Usage: make install-swag
# What it does: Installs swag CLI tool if not already installed
# Command: go install github.com/swaggo/swag/cmd/swag@latest
# When to use: Automatically called by swagger targets, or manually if swag is missing
.PHONY: install-swag
install-swag:
	@which swag > /dev/null || (go install github.com/swaggo/swag/cmd/swag@latest)


# ============================================================================
# Development & Build
# ============================================================================

# run: Start the development server
# Usage: make run
# What it does: Runs the Go server in development mode with hot reload
# Command: go run cmd/server/main.go
# When to use: Daily development work
.PHONY: run
run:
	@echo "Running development server..."
	@go run cmd/server/main.go
	@echo "✅ Development server running"

# build: Build production binary
# Usage: make build
# What it does: Compiles Go code into a production-ready binary
# Command: go build cmd/server/main.go
# When to use: Before deploying to production
.PHONY: build
build:
	@echo "Running production server..."
	@go build cmd/server/main.go
	@echo "✅ Production server running"

# ============================================================================
# SDK Generation Targets
# ============================================================================
# Directory structure:
#   docs/swagger/swagger.yaml  - OpenAPI specification file (required)
#   sdks/ts/                  - Generated TypeScript SDK
#   sdks/dart/                - Generated Dart SDK

# OpenAPI specification file path
OPENAPI_SPEC := docs/swagger/swagger.yaml

# SDK output directories
SDK_TS_DIR := sdks/ts
SDK_DART_DIR := sdks/dart

# SDK version tracking file
SDK_VERSION_FILE := sdks/version.json

# install-deps: Install SDK generation dependencies
# Usage: make install-deps
# What it does: Installs openapi-generator-cli globally via npm if missing
# Command: npm install -g @openapitools/openapi-generator-cli
# When to use: First time SDK generation or if openapi-generator-cli is missing
.PHONY: install-deps
install-deps:
	@echo "📦 Installing dependencies..."
	@bash -c 'set -e; \
	if ! which openapi-generator-cli &> /dev/null; then \
		echo "Installing openapi-generator-cli globally..."; \
		npm install -g @openapitools/openapi-generator-cli || (echo "❌ Failed to install openapi-generator-cli" && exit 1); \
	else \
		echo "✓ openapi-generator-cli already installed"; \
	fi'
	@echo "✅ Dependencies installed"

# check-env: Verify all required tools and dependencies are installed
# Usage: make check-env
# What it does: Checks for Node.js (>=18), npm, Java, Dart, and openapi-generator-cli
# Command: bash scripts/assert.sh (checks each tool)
# When to use: Before generating SDKs or troubleshooting SDK generation issues
.PHONY: check-env
check-env:
	@echo "🔍 Checking environment and dependencies..."
	@bash -c 'set -e; \
	bash scripts/assert.sh command node 18; \
	bash scripts/assert.sh command npm; \
	bash scripts/assert.sh command java; \
	bash scripts/assert.sh command dart; \
	bash scripts/assert.sh command openapi-generator-cli; \
	bash scripts/assert.sh file $(OPENAPI_SPEC)'
	@echo "✅ Environment check passed"

# setup-sdk-dirs: Set up SDK directories with ignore files
# Usage: make setup-sdk-dirs
# What it does: Creates SDK directories and .openapi-generator-ignore files
# Command: mkdir and file creation commands
# When to use: Automatically called by SDK generation targets
.PHONY: setup-sdk-dirs
setup-sdk-dirs:
	@echo "📁 Setting up SDK directories..."
	@mkdir -p $(SDK_TS_DIR) $(SDK_DART_DIR)
	@if [ ! -f $(SDK_TS_DIR)/.openapi-generator-ignore ]; then \
		echo "Creating .openapi-generator-ignore for TypeScript SDK..."; \
		cp sdks/ts/.openapi-generator-ignore $(SDK_TS_DIR)/.openapi-generator-ignore 2>/dev/null || \
		echo -e "# OpenAPI Generator Ignore File for TypeScript SDK\npackage.json\ntsconfig.json\njest.config.js\n.eslintrc.js\n.gitignore\n.npmignore\nREADME.md\nLICENSE\nexamples/\ngit_push.sh" > $(SDK_TS_DIR)/.openapi-generator-ignore; \
	fi
	@if [ ! -f $(SDK_DART_DIR)/.openapi-generator-ignore ]; then \
		echo "Creating .openapi-generator-ignore for Dart SDK..."; \
		cp sdks/dart/.openapi-generator-ignore $(SDK_DART_DIR)/.openapi-generator-ignore 2>/dev/null || \
		echo -e "# OpenAPI Generator Ignore File for Dart SDK\npubspec.yaml\nanalysis_options.yaml\nREADME.md\n.gitignore\nLICENSE\nexample/\ngit_push.sh" > $(SDK_DART_DIR)/.openapi-generator-ignore; \
	fi
	@if [ -f sdks/LICENSE ]; then \
		cp sdks/LICENSE $(SDK_TS_DIR)/LICENSE; \
		cp sdks/LICENSE $(SDK_DART_DIR)/LICENSE; \
		echo "✓ LICENSE file copied to SDK directories"; \
	fi
	@echo "✅ SDK directories ready"

# generate-ts-sdk: Generate TypeScript SDK only
# Usage: make generate-ts-sdk
# What it does: Generates TypeScript SDK from OpenAPI spec using typescript-axios generator
# Command: openapi-generator-cli generate -i docs/swagger/swagger.yaml -g typescript-axios -o sdks/ts
# When to use: When you only need the TypeScript SDK
.PHONY: generate-ts-sdk
generate-ts-sdk: check-env setup-sdk-dirs
	@echo "🔧 Generating TypeScript SDK..."
	@bash -c 'set -e; \
	mkdir -p $(SDK_TS_DIR); \
	openapi-generator-cli generate \
		-i $(OPENAPI_SPEC) \
		-g typescript-axios \
		-o $(SDK_TS_DIR) || (echo "❌ TypeScript SDK generation failed" && exit 1)'
	@echo "✅ TypeScript SDK generated at $(SDK_TS_DIR)"

# generate-dart-sdk: Generate Dart SDK only
# Usage: make generate-dart-sdk
# What it does: Generates Dart SDK from OpenAPI spec using dart-dio generator
# Command: openapi-generator-cli generate -i docs/swagger/swagger.yaml -g dart-dio -o sdks/dart
# When to use: When you only need the Dart SDK
.PHONY: generate-dart-sdk
generate-dart-sdk: check-env setup-sdk-dirs
	@echo "🔧 Generating Dart SDK..."
	@bash -c 'set -e; \
	mkdir -p $(SDK_DART_DIR); \
	openapi-generator-cli generate \
		-i $(OPENAPI_SPEC) \
		-g dart-dio \
		-o $(SDK_DART_DIR) || (echo "❌ Dart SDK generation failed" && exit 1)'
	@echo "✅ Dart SDK generated at $(SDK_DART_DIR)"

# generate-sdks: Generate both TypeScript and Dart SDKs
# Usage: make generate-sdks
# What it does: Generates both SDKs from OpenAPI specification
# Commands: Runs install-deps, check-env, generate-ts-sdk, and generate-dart-sdk
# When to use: After API changes to regenerate both SDKs
.PHONY: generate-sdks
generate-sdks: install-deps check-env generate-ts-sdk generate-dart-sdk
	@echo "✅ All SDKs generated successfully!"
	@echo "📁 TypeScript SDK: $(SDK_TS_DIR)"
	@echo "📁 Dart SDK: $(SDK_DART_DIR)"

# clean-sdks: Remove all generated SDK directories
# Usage: make clean-sdks
# What it does: Deletes sdks/ts and sdks/dart directories
# Command: rm -rf sdks/ts sdks/dart
# When to use: To start fresh with SDK generation
.PHONY: clean-sdks
clean-sdks:
	@echo "🧹 Cleaning generated SDKs..."
	@rm -rf $(SDK_TS_DIR) $(SDK_DART_DIR)
	@echo "✅ SDK directories cleaned"

# show-sdk-version: Display current SDK versions from version.json
# Usage: make show-sdk-version
# What it does: Shows current versions tracked in sdks/version.json
# Command: Reads and displays version.json contents
# When to use: To check current SDK versions before updating
.PHONY: show-sdk-version
show-sdk-version:
	@echo "📦 Current SDK Versions:"
	@if [ -f $(SDK_VERSION_FILE) ]; then \
		node -e "const fs=require('fs'); const v=JSON.parse(fs.readFileSync('$(SDK_VERSION_FILE)')); console.log('  Version:', v.version); console.log('  TypeScript:', v.typescript || v.version); console.log('  Dart:', v.dart || v.version); console.log('  Last Updated:', v.last_updated || 'N/A');"; \
	else \
		echo "  ❌ $(SDK_VERSION_FILE) not found"; \
		echo "  Create it or use: make version-sdks VERSION=1.0.0"; \
	fi

# verify-sdks: Verify generated SDKs are complete
# Usage: make verify-sdks
# What it does: Checks if SDK directories exist and contain required files
# Command: Checks for package.json/index.ts (TS) and pubspec.yaml/lib/openapi.dart (Dart)
# When to use: Before publishing SDKs to ensure they're complete
.PHONY: verify-sdks
verify-sdks:
	@echo "🔍 Verifying generated SDKs..."
	@bash -c 'set -e; \
	if [ ! -d "$(SDK_TS_DIR)" ]; then \
		echo "❌ TypeScript SDK directory not found"; \
		exit 1; \
	fi; \
	if [ ! -f "$(SDK_TS_DIR)/package.json" ] && [ ! -f "$(SDK_TS_DIR)/index.ts" ]; then \
		echo "⚠️  TypeScript SDK appears incomplete"; \
	fi; \
	if [ ! -d "$(SDK_DART_DIR)" ]; then \
		echo "❌ Dart SDK directory not found"; \
		exit 1; \
	fi; \
	if [ ! -f "$(SDK_DART_DIR)/pubspec.yaml" ] && [ ! -f "$(SDK_DART_DIR)/lib/openapi.dart" ]; then \
		echo "⚠️  Dart SDK appears incomplete"; \
	fi; \
	echo "✅ SDK verification complete"'

# version-ts-sdk: Update TypeScript SDK version
# Usage: make version-ts-sdk [VERSION=1.0.1]
# What it does: Updates version in sdks/ts/package.json and sdks/version.json
# Command: Reads from sdks/version.json if VERSION not provided, otherwise uses VERSION
# When to use: Before publishing a new TypeScript SDK version
# Note: If VERSION is not provided, reads from sdks/version.json
.PHONY: version-ts-sdk
version-ts-sdk:
	@bash -c 'set -e; \
	if [ -z "$(VERSION)" ]; then \
		if [ -f $(SDK_VERSION_FILE) ]; then \
			VERSION=$$(node -e "const fs=require(\"fs\"); const v=JSON.parse(fs.readFileSync(\"$(SDK_VERSION_FILE)\")); console.log(v.typescript || v.version);"); \
			echo "📦 Using version from $(SDK_VERSION_FILE): $$VERSION"; \
		else \
			echo "❌ VERSION is required. Usage: make version-ts-sdk VERSION=1.0.1"; \
			echo "   Or create $(SDK_VERSION_FILE) with version information"; \
			exit 1; \
		fi; \
	else \
		VERSION="$(VERSION)"; \
	fi; \
	echo "📦 Updating TypeScript SDK version to $$VERSION..."; \
	cd $(SDK_TS_DIR); \
	node -e "const fs=require(\"fs\"); const pkg=JSON.parse(fs.readFileSync(\"package.json\")); pkg.version=\"$$VERSION\"; fs.writeFileSync(\"package.json\", JSON.stringify(pkg, null, 2));"; \
	node -e "const fs=require(\"fs\"); const v=JSON.parse(fs.readFileSync(\"../version.json\")); v.typescript=\"$$VERSION\"; v.version=\"$$VERSION\"; v.last_updated=new Date().toISOString(); fs.writeFileSync(\"../version.json\", JSON.stringify(v, null, 2));"; \
	echo "✅ TypeScript SDK version updated to $$VERSION"'

# version-dart-sdk: Update Dart SDK version
# Usage: make version-dart-sdk [VERSION=1.0.1]
# What it does: Updates version in sdks/dart/pubspec.yaml and sdks/version.json
# Command: Reads from sdks/version.json if VERSION not provided, otherwise uses VERSION
# When to use: Before publishing a new Dart SDK version
# Note: If VERSION is not provided, reads from sdks/version.json
.PHONY: version-dart-sdk
version-dart-sdk:
	@bash -c 'set -e; \
	if [ -z "$(VERSION)" ]; then \
		if [ -f $(SDK_VERSION_FILE) ]; then \
			VERSION=$$(node -e "const fs=require(\"fs\"); const v=JSON.parse(fs.readFileSync(\"$(SDK_VERSION_FILE)\")); console.log(v.dart || v.version);"); \
			echo "📦 Using version from $(SDK_VERSION_FILE): $$VERSION"; \
		else \
			echo "❌ VERSION is required. Usage: make version-dart-sdk VERSION=1.0.1"; \
			echo "   Or create $(SDK_VERSION_FILE) with version information"; \
			exit 1; \
		fi; \
	else \
		VERSION="$(VERSION)"; \
	fi; \
	echo "📦 Updating Dart SDK version to $$VERSION..."; \
	cd $(SDK_DART_DIR); \
	sed -i.bak "s/^version: .*/version: $$VERSION/" pubspec.yaml && rm -f pubspec.yaml.bak; \
	node -e "const fs=require(\"fs\"); const v=JSON.parse(fs.readFileSync(\"../version.json\")); v.dart=\"$$VERSION\"; v.version=\"$$VERSION\"; v.last_updated=new Date().toISOString(); fs.writeFileSync(\"../version.json\", JSON.stringify(v, null, 2));"; \
	echo "✅ Dart SDK version updated to $$VERSION"'

# version-sdks: Update both SDK versions to the same version
# Usage: make version-sdks [VERSION=1.0.1]
# What it does: Updates version in both TypeScript and Dart SDKs and sdks/version.json
# Commands: Runs version-ts-sdk and version-dart-sdk
# When to use: Before publishing both SDKs with the same version number
# Note: If VERSION is not provided, reads from sdks/version.json
.PHONY: version-sdks
version-sdks:
	@bash -c 'set -e; \
	if [ -z "$(VERSION)" ]; then \
		if [ -f $(SDK_VERSION_FILE) ]; then \
			VERSION=$$(node -e "const fs=require(\"fs\"); const v=JSON.parse(fs.readFileSync(\"$(SDK_VERSION_FILE)\")); console.log(v.version);"); \
			echo "📦 Using version from $(SDK_VERSION_FILE): $$VERSION"; \
		else \
			echo "❌ VERSION is required. Usage: make version-sdks VERSION=1.0.1"; \
			echo "   Or create $(SDK_VERSION_FILE) with version information"; \
			exit 1; \
		fi; \
	else \
		VERSION="$(VERSION)"; \
	fi; \
	echo "📦 Updating both SDK versions to $$VERSION..."; \
	$(MAKE) version-ts-sdk VERSION=$$VERSION; \
	$(MAKE) version-dart-sdk VERSION=$$VERSION; \
	echo "✅ All SDK versions updated to $$VERSION"'

# publish-ts-sdk: Publish TypeScript SDK to npm
# Usage: make publish-ts-sdk
# What it does: Publishes @caygnus/nashik-darshan-sdk to npm registry (public)
# Command: npm publish (in sdks/ts directory)
# When to use: After updating version and verifying SDK is complete
# Authentication: Checks .env for NPM_TOKEN first, falls back to npm login
# Note: SDKs are published as public packages
.PHONY: publish-ts-sdk
publish-ts-sdk: verify-sdks
	@echo "📤 Publishing TypeScript SDK to npm (public)..."
	@bash -c 'set -e; \
	cd $(SDK_TS_DIR); \
	# Load NPM_TOKEN from .env if it exists \
	if [ -f ../../.env ]; then \
		export $$(grep -v "^#" ../../.env | grep "^NPM_TOKEN=" | head -1); \
		if [ -n "$$NPM_TOKEN" ]; then \
			echo "✓ Using NPM_TOKEN from .env file"; \
			echo "//registry.npmjs.org/:_authToken=$$NPM_TOKEN" > .npmrc; \
			if npm publish --access public; then \
				rm -f .npmrc; \
				echo "✅ TypeScript SDK published to npm (public)"; \
				exit 0; \
			else \
				rm -f .npmrc; \
				echo "❌ npm publish failed. Check your token and package permissions."; \
				exit 1; \
			fi; \
		fi; \
	fi; \
	# Check environment variable \
	if [ -n "$$NPM_TOKEN" ]; then \
		echo "✓ Using NPM_TOKEN from environment"; \
		echo "//registry.npmjs.org/:_authToken=$$NPM_TOKEN" > .npmrc; \
		if npm publish --access public; then \
			rm -f .npmrc; \
			echo "✅ TypeScript SDK published to npm (public)"; \
			exit 0; \
		else \
			rm -f .npmrc; \
			echo "❌ npm publish failed. Check your token and package permissions."; \
			exit 1; \
		fi; \
	fi; \
	# Fallback to npm login if token not found \
	echo "⚠️  NPM_TOKEN not found in .env or environment, checking npm login..."; \
	if npm whoami &>/dev/null; then \
		echo "✓ Using npm login credentials (user: $$(npm whoami))"; \
		if npm publish --access public; then \
			echo "✅ TypeScript SDK published to npm (public)"; \
			exit 0; \
		else \
			echo "❌ npm publish failed. Check your authentication and package permissions."; \
			exit 1; \
		fi; \
	else \
		echo "❌ Not authenticated. Options:"; \
		echo "   1. Add NPM_TOKEN=your_token to .env file (recommended), or"; \
		echo "   2. Set NPM_TOKEN environment variable, or"; \
		echo "   3. Run: npm login"; \
		exit 1; \
	fi'

# publish-dart-sdk: Publish Dart SDK to pub.dev
# Usage: make publish-dart-sdk
# What it does: Publishes nashik_darshan_sdk to pub.dev (public)
# Command: dart pub publish (in sdks/dart directory)
# When to use: After updating version and verifying SDK is complete
# Authentication: Checks .env for PUB_CREDENTIALS first, falls back to pub token
# Note: SDKs are published as public packages
.PHONY: publish-dart-sdk
publish-dart-sdk: verify-sdks
	@echo "📤 Publishing Dart SDK to pub.dev (public)..."
	@bash -c 'set -e; \
	cd $(SDK_DART_DIR); \
	# Load PUB_CREDENTIALS from .env if it exists \
	if [ -f ../../.env ]; then \
		export $$(grep -v "^#" ../../.env | grep "^PUB_CREDENTIALS=" | head -1); \
		if [ -n "$$PUB_CREDENTIALS" ]; then \
			echo "✓ Using PUB_CREDENTIALS from .env file"; \
			mkdir -p ~/.pub-cache; \
			echo "$$PUB_CREDENTIALS" > ~/.pub-cache/credentials.json; \
			if dart pub publish --force; then \
				echo "✅ Dart SDK published to pub.dev (public)"; \
				exit 0; \
			else \
				echo "❌ dart pub publish failed. Check your credentials."; \
				exit 1; \
			fi; \
		fi; \
	fi; \
	# Check environment variable \
	if [ -n "$$PUB_CREDENTIALS" ]; then \
		echo "✓ Using PUB_CREDENTIALS from environment"; \
		mkdir -p ~/.pub-cache; \
		echo "$$PUB_CREDENTIALS" > ~/.pub-cache/credentials.json; \
		if dart pub publish --force; then \
			echo "✅ Dart SDK published to pub.dev (public)"; \
			exit 0; \
		else \
			echo "❌ dart pub publish failed. Check your credentials."; \
			exit 1; \
		fi; \
	fi; \
	# Fallback to pub token if credentials not found \
	echo "⚠️  PUB_CREDENTIALS not found in .env or environment, checking pub token..."; \
	if dart pub token list 2>/dev/null | grep -q "pub.dev"; then \
		echo "✓ Using existing pub.dev token"; \
		if dart pub publish --force; then \
			echo "✅ Dart SDK published to pub.dev (public)"; \
			exit 0; \
		else \
			echo "❌ dart pub publish failed. Check your token and package permissions."; \
			exit 1; \
		fi; \
	else \
		echo "❌ Not authenticated. Options:"; \
		echo "   1. Add PUB_CREDENTIALS=your_credentials to .env file (recommended), or"; \
		echo "   2. Set PUB_CREDENTIALS environment variable, or"; \
		echo "   3. Run: dart pub token add https://pub.dev"; \
		exit 1; \
	fi'

# publish-sdks: Publish both SDKs to their respective registries
# Usage: make publish-sdks
# What it does: Publishes both TypeScript (npm) and Dart (pub.dev) SDKs
# Commands: Runs publish-ts-sdk and publish-dart-sdk
# When to use: After updating versions and verifying both SDKs are complete
.PHONY: publish-sdks
publish-sdks: verify-sdks
	@echo "📤 Publishing all SDKs..."
	@$(MAKE) publish-ts-sdk
	@$(MAKE) publish-dart-sdk
	@echo "✅ All SDKs published"

# publish-ts-sdk-dry-run: Test TypeScript SDK publish without actually publishing
# Usage: make publish-ts-sdk-dry-run
# What it does: Runs npm publish --dry-run to validate package without publishing
# Command: npm publish --dry-run (in sdks/ts directory)
# When to use: Before actual publish to verify package contents
.PHONY: publish-ts-sdk-dry-run
publish-ts-sdk-dry-run: verify-sdks
	@echo "🔍 Dry-run: TypeScript SDK publish..."
	@bash -c 'set -e; cd $(SDK_TS_DIR); npm publish --dry-run'
	@echo "✅ Dry-run complete"

# publish-dart-sdk-dry-run: Test Dart SDK publish without actually publishing
# Usage: make publish-dart-sdk-dry-run
# What it does: Runs dart pub publish --dry-run to validate package without publishing
# Command: dart pub publish --dry-run (in sdks/dart directory)
# When to use: Before actual publish to verify package contents
.PHONY: publish-dart-sdk-dry-run
publish-dart-sdk-dry-run: verify-sdks
	@echo "🔍 Dry-run: Dart SDK publish..."
	@bash -c 'set -e; cd $(SDK_DART_DIR); pub publish --dry-run'
	@echo "✅ Dry-run complete"