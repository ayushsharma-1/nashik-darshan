#!/bin/bash
# generate-dart-sdk.sh - Generate Dart SDK from OpenAPI specification
# This script generates the Dart SDK using OpenAPI Generator CLI

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

# Configuration
OPENAPI_SPEC="${OPENAPI_SPEC:-$PROJECT_ROOT/docs/swagger/swagger.yaml}"
SDK_DIR="${SDK_DIR:-$PROJECT_ROOT/sdks/dart}"
GENERATOR="dart-dio"

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

# Main execution
main() {
    log_info "Starting Dart SDK generation"
    log_info "Project root: $PROJECT_ROOT"
    log_info "OpenAPI spec: $OPENAPI_SPEC"
    log_info "SDK output directory: $SDK_DIR"
    log_info "Generator: $GENERATOR"
    echo ""

    # Step 1: Check OpenAPI spec exists
    log_step "Step 1/4: Verifying OpenAPI specification file"
    if [ ! -f "$OPENAPI_SPEC" ]; then
        error_exit "OpenAPI specification not found: $OPENAPI_SPEC"
    fi
    log_success "OpenAPI specification found: $OPENAPI_SPEC"
    SPEC_SIZE=$(du -h "$OPENAPI_SPEC" | cut -f1)
    log_info "Specification file size: $SPEC_SIZE"
    echo ""

    # Step 2: Check dependencies
    log_step "Step 2/4: Checking dependencies"
    if ! command -v openapi-generator-cli &> /dev/null; then
        error_exit "openapi-generator-cli not found. Run 'make install-deps' first"
    fi
    GEN_VERSION=$(openapi-generator-cli version 2>&1 | head -n 1 || echo "unknown")
    log_success "OpenAPI Generator CLI found: $GEN_VERSION"
    
    if ! command -v dart &> /dev/null; then
        error_exit "Dart not found. Required for Dart SDK"
    fi
    DART_VERSION=$(dart --version 2>&1 | head -n 1)
    log_success "Dart found: $DART_VERSION"
    echo ""

    # Step 3: Create SDK directory
    log_step "Step 3/4: Setting up SDK directory"
    mkdir -p "$SDK_DIR"
    log_success "SDK directory ready: $SDK_DIR"
    
    # Copy LICENSE if it exists
    if [ -f "$PROJECT_ROOT/sdks/LICENSE" ]; then
        cp "$PROJECT_ROOT/sdks/LICENSE" "$SDK_DIR/LICENSE"
        log_success "LICENSE file copied to SDK directory"
    fi
    
    # Copy README.md if it exists (preserved by .openapi-generator-ignore)
    if [ -f "$PROJECT_ROOT/sdks/dart/README.md" ] && [ ! -f "$SDK_DIR/README.md" ]; then
        cp "$PROJECT_ROOT/sdks/dart/README.md" "$SDK_DIR/README.md"
        log_success "README.md copied to SDK directory"
    fi
    echo ""

    # Step 4: Generate SDK
    log_step "Step 4/4: Generating Dart SDK"
    log_info "This may take a few moments..."
    log_info "Command: openapi-generator-cli generate -i $OPENAPI_SPEC -g $GENERATOR -o $SDK_DIR"
    echo ""

    cd "$PROJECT_ROOT"
    
    if openapi-generator-cli generate \
        -i "$OPENAPI_SPEC" \
        -g "$GENERATOR" \
        -o "$SDK_DIR" 2>&1 | tee /tmp/openapi-gen-dart.log; then
        echo ""
        log_success "Dart SDK generation completed successfully"
    else
        EXIT_CODE=$?
        echo ""
        log_error "Dart SDK generation failed with exit code: $EXIT_CODE"
        log_error "Check the log above for details"
        if [ -f /tmp/openapi-gen-dart.log ]; then
            log_error "Full log saved to: /tmp/openapi-gen-dart.log"
        fi
        exit $EXIT_CODE
    fi

    # Verify generated files
    echo ""
    log_step "Verifying generated SDK files"
    if [ ! -f "$SDK_DIR/pubspec.yaml" ]; then
        log_warn "Generated pubspec.yaml not found (may be preserved by .openapi-generator-ignore)"
    fi
    if [ ! -d "$SDK_DIR/lib" ]; then
        error_exit "Generated lib/ directory not found. SDK generation may have failed."
    fi
    
    FILE_COUNT=$(find "$SDK_DIR/lib" -type f -name "*.dart" 2>/dev/null | wc -l | tr -d ' ' || echo "0")
    log_success "Generated $FILE_COUNT Dart files"
    
    # Show directory structure
    echo ""
    log_info "SDK directory structure:"
    ls -lh "$SDK_DIR" | head -15 | tail -10 || true
    echo ""

    log_success "Dart SDK generation complete!"
    log_info "SDK location: $SDK_DIR"
    echo ""
}

# Run main function
main "$@"

