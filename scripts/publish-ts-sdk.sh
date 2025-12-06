#!/bin/bash
# publish-ts-sdk.sh - Publish TypeScript SDK to npm registry
# This script handles authentication and publishing of the TypeScript SDK

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SDK_DIR="$PROJECT_ROOT/sdks/ts"
ENV_FILE="$PROJECT_ROOT/.env"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Error handler
error_exit() {
    log_error "$1"
    exit 1
}

# Load NPM_TOKEN from .env file
load_env_token() {
    if [ -f "$ENV_FILE" ]; then
        # Extract NPM_TOKEN from .env, handling comments and empty lines
        TOKEN=$(grep -v "^#" "$ENV_FILE" | grep "^NPM_TOKEN=" | head -1 | cut -d= -f2- | xargs)
        if [ -n "$TOKEN" ]; then
            echo "$TOKEN"
            return 0
        fi
    fi
    return 1
}

# Main execution
main() {
    log_info "Starting TypeScript SDK publishing"
    log_info "Project root: $PROJECT_ROOT"
    log_info "SDK directory: $SDK_DIR"
    echo ""

    # Step 1: Verify SDK directory exists
    log_step "Step 1/5: Verifying SDK directory"
    if [ ! -d "$SDK_DIR" ]; then
        error_exit "SDK directory not found: $SDK_DIR. Run 'make generate-ts-sdk' first."
    fi
    log_success "SDK directory found: $SDK_DIR"
    echo ""

    # Step 2: Verify package.json exists
    log_step "Step 2/5: Verifying package.json"
    if [ ! -f "$SDK_DIR/package.json" ]; then
        error_exit "package.json not found in SDK directory"
    fi
    
    PACKAGE_NAME=$(node -e "console.log(require('$SDK_DIR/package.json').name)" 2>/dev/null || echo "unknown")
    PACKAGE_VERSION=$(node -e "console.log(require('$SDK_DIR/package.json').version)" 2>/dev/null || echo "unknown")
    log_success "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    echo ""

    # Step 3: Check npm authentication
    log_step "Step 3/5: Checking npm authentication"
    
    NPM_TOKEN=""
    AUTH_METHOD=""
    
    # Try loading from .env file
    if TOKEN=$(load_env_token); then
        NPM_TOKEN="$TOKEN"
        AUTH_METHOD=".env file"
        log_success "Found NPM_TOKEN in .env file"
    # Try environment variable
    elif [ -n "$NPM_TOKEN" ]; then
        AUTH_METHOD="environment variable"
        log_success "Found NPM_TOKEN in environment"
    # Check npm login
    elif npm whoami &>/dev/null; then
        CURRENT_USER=$(npm whoami)
        AUTH_METHOD="npm login"
        log_success "Found npm login credentials (user: $CURRENT_USER)"
        
        # Check if user has access to @caygnus scope
        if [[ "$PACKAGE_NAME" == @caygnus/* ]]; then
            log_warn "Publishing to @caygnus scope as user: $CURRENT_USER"
            if [ "$CURRENT_USER" != "caygnus" ] && ! npm org ls @caygnus 2>/dev/null | grep -q "$CURRENT_USER"; then
                log_warn "User '$CURRENT_USER' may not have publish access to @caygnus organization"
                log_warn "Consider using NPM_TOKEN from @caygnus organization account"
            fi
        fi
    else
        error_exit "No npm authentication found. Options:\n  1. Add NPM_TOKEN=your_token to .env file\n  2. Set NPM_TOKEN environment variable\n  3. Run: npm login"
    fi
    echo ""

    # Step 4: Configure npm authentication
    log_step "Step 4/5: Configuring npm authentication"
    cd "$SDK_DIR"
    
    # Use npm's standard authentication methods (user-level config, not project files)
    if [ -n "$NPM_TOKEN" ]; then
        log_success "Using NPM_TOKEN from $AUTH_METHOD"
        
        # Configure authentication at user-level (~/.npmrc) - industry standard
        # This is secure as it's in the user's home directory, not the project
        if [[ "$PACKAGE_NAME" == @caygnus/* ]]; then
            # Set scope-specific registry and auth token (user-level)
            npm config set @caygnus:registry https://registry.npmjs.org/ --location=user
            npm config set "//registry.npmjs.org/:_authToken" "$NPM_TOKEN" --location=user
            log_info "Configured @caygnus scope authentication (user-level ~/.npmrc)"
        else
            # Set global registry auth token (user-level)
            npm config set "//registry.npmjs.org/:_authToken" "$NPM_TOKEN" --location=user
            log_info "Configured npm authentication (user-level ~/.npmrc)"
        fi
        log_info "Token stored in user's ~/.npmrc (not in project directory)"
    else
        log_info "Using existing npm login credentials from ~/.npmrc"
    fi
    echo ""

    # Step 5: Publish package
    log_step "Step 5/5: Publishing package to npm"
    log_info "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    log_info "Registry: https://registry.npmjs.org/"
    log_info "Access: public"
    echo ""

    # Dry run first to verify
    log_info "Running dry-run to verify package..."
    if ! npm publish --dry-run --access public &>/dev/null; then
        log_warn "Dry-run had warnings, but continuing..."
    fi
    echo ""

    # Actual publish
    # npm automatically uses NPM_TOKEN environment variable if set
    log_info "Publishing package (this may take a moment)..."
    if npm publish --access public 2>&1 | tee /tmp/npm-publish-ts.log; then
        echo ""
        log_success "Package published successfully!"
        log_info "View package at: https://www.npmjs.com/package/$PACKAGE_NAME"
    else
        EXIT_CODE=$?
        echo ""
        log_error "Publishing failed with exit code: $EXIT_CODE"
        
        # Check for common errors
        if grep -q "404" /tmp/npm-publish-ts.log 2>/dev/null; then
            log_error ""
            log_error "404 Error detected. This usually means:"
            log_error "  1. You're authenticated with the wrong npm account"
            log_error "  2. The @caygnus organization may not be fully set up"
            log_error "  3. You need an access token from the @caygnus organization account"
            log_error ""
            log_error "Solution: Get a token from https://www.npmjs.com/settings/caygnus/access-tokens"
            log_error "         and add it to .env file as NPM_TOKEN=your_token"
        elif grep -q "403" /tmp/npm-publish-ts.log 2>/dev/null; then
            log_error "403 Forbidden - Check your permissions for this package"
        elif grep -q "401" /tmp/npm-publish-ts.log 2>/dev/null; then
            log_error "401 Unauthorized - Check your authentication token"
            if [ -n "$NPM_TOKEN" ]; then
                log_error "NPM_TOKEN is set but authentication failed. Verify the token is valid."
            fi
        fi
        
        if [ -f /tmp/npm-publish-ts.log ]; then
            log_error "Full log saved to: /tmp/npm-publish-ts.log"
        fi
        
        exit $EXIT_CODE
    fi

    echo ""

    log_success "TypeScript SDK publishing complete!"
    log_info "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    log_info "URL: https://www.npmjs.com/package/$PACKAGE_NAME"
    echo ""
}

# Run main function
main "$@"

