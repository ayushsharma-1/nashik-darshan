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
    
    # Copy LICENSE - use Dart-specific MIT license (not the proprietary one)
    # We copy it AFTER generation to ensure it's not overwritten
    # The .openapi-generator-ignore should prevent overwriting, but we ensure it's correct
    
    # Copy README.md and CHANGELOG.md AFTER generation to preserve custom versions
    # These are listed in .openapi-generator-ignore but we copy them explicitly
    # to ensure they're always up-to-date with our custom versions
    # (The ignore file prevents generator from overwriting, but we want to ensure they exist)
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
        -o "$SDK_DIR" \
        --package-name nashik_darshan_sdk 2>&1 | tee /tmp/openapi-gen-dart.log; then
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

    # Fix package imports if generator didn't use the package name correctly
    # This is necessary because OpenAPI Generator uses 'openapi' as default package name
    log_step "Fixing package imports in generated files..."
    DART_FILES_WITH_OPENAPI=$(find "$SDK_DIR" -type f -name "*.dart" -exec grep -l "package:openapi" {} \; 2>/dev/null | wc -l | tr -d ' ' || echo "0")
    
    if [ "$DART_FILES_WITH_OPENAPI" -gt 0 ]; then
        log_info "Found $DART_FILES_WITH_OPENAPI Dart file(s) with 'package:openapi' imports"
        log_info "Replacing 'package:openapi' with 'package:nashik_darshan_sdk'..."
        
        # Fix imports in all directories (lib, test, example, etc.)
        # Use find with -exec to handle files with spaces in names
        find "$SDK_DIR" -type f -name "*.dart" -print0 | while IFS= read -r -d '' file; do
            # Use sed to replace, handling both macOS and Linux
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' 's/package:openapi/package:nashik_darshan_sdk/g' "$file"
            else
                sed -i 's/package:openapi/package:nashik_darshan_sdk/g' "$file"
            fi
        done
        
        # Verify the fix
        REMAINING=$(find "$SDK_DIR" -type f -name "*.dart" -exec grep -l "package:openapi" {} \; 2>/dev/null | wc -l | tr -d ' ' || echo "0")
        if [ "$REMAINING" -eq 0 ]; then
            log_success "Package imports fixed in all $DART_FILES_WITH_OPENAPI Dart file(s)"
        else
            log_warn "Some imports may not have been fixed. $REMAINING file(s) still contain 'package:openapi'"
        fi
    else
        log_info "No package import fixes needed - all files already use correct package name"
    fi

    # Rename openapi.dart to match package name (pub.dev requirement)
    log_step "Renaming main library file to match package name..."
    if [ -f "$SDK_DIR/lib/openapi.dart" ]; then
        mv "$SDK_DIR/lib/openapi.dart" "$SDK_DIR/lib/nashik_darshan_sdk.dart"
        log_success "Renamed lib/openapi.dart to lib/nashik_darshan_sdk.dart"
        
        # Update the export in the file itself if it exists
        if grep -q "export 'package:openapi" "$SDK_DIR/lib/nashik_darshan_sdk.dart" 2>/dev/null; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' 's/export '\''package:openapi/export '\''package:nashik_darshan_sdk/g' "$SDK_DIR/lib/nashik_darshan_sdk.dart"
            else
                sed -i 's/export '\''package:openapi/export '\''package:nashik_darshan_sdk/g' "$SDK_DIR/lib/nashik_darshan_sdk.dart"
            fi
        fi
    else
        log_warn "lib/openapi.dart not found (may have been renamed already)"
    fi
    echo ""

    # Run build_runner to generate .g.dart files (required for built_value)
    log_step "Generating code with build_runner..."
    cd "$SDK_DIR"
    
    if ! command -v dart &> /dev/null; then
        log_warn "Dart not found. Skipping build_runner. Run 'dart pub run build_runner build' manually."
    else
        log_info "Running: dart pub get"
        if dart pub get 2>&1 | tee /tmp/dart-pub-get.log; then
            log_success "Dependencies installed"
        else
            log_warn "dart pub get had issues, but continuing..."
        fi
        
        log_info "Running: dart pub run build_runner build --delete-conflicting-outputs"
        if dart pub run build_runner build --delete-conflicting-outputs 2>&1 | tee /tmp/build-runner.log; then
            log_success "Code generation completed"
        else
            EXIT_CODE=$?
            log_warn "build_runner had issues (exit code: $EXIT_CODE)"
            log_warn "You may need to run 'dart pub run build_runner build' manually"
            if [ -f /tmp/build-runner.log ]; then
                log_warn "Build runner log saved to: /tmp/build-runner.log"
            fi
        fi
    fi
    
    cd "$PROJECT_ROOT"
    echo ""

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
    
    # Check for generated .g.dart files
    G_FILE_COUNT=$(find "$SDK_DIR/lib" -type f -name "*.g.dart" 2>/dev/null | wc -l | tr -d ' ' || echo "0")
    if [ "$G_FILE_COUNT" -gt 0 ]; then
        log_success "Generated $G_FILE_COUNT .g.dart files"
    else
        log_warn "No .g.dart files found. Run 'dart pub run build_runner build' if needed."
    fi
    
    # Preserve custom README.md, CHANGELOG.md, and LICENSE (with correct content)
    # These must be copied AFTER generation to overwrite any generated versions
    # Note: We check if source and destination are different to avoid copying file to itself
    log_step "Preserving custom documentation and license files..."
    
    README_SOURCE="$PROJECT_ROOT/sdks/dart/README.md"
    README_DEST="$SDK_DIR/README.md"
    if [ -f "$README_SOURCE" ]; then
        # Only copy if source and destination are different files
        if [ "$(readlink -f "$README_SOURCE" 2>/dev/null || echo "$README_SOURCE")" != "$(readlink -f "$README_DEST" 2>/dev/null || echo "$README_DEST")" ]; then
            cp -f "$README_SOURCE" "$README_DEST"
            log_success "README.md preserved (custom version with correct imports)"
        else
            log_info "README.md already in place (source and destination are the same)"
        fi
    fi
    
    CHANGELOG_SOURCE="$PROJECT_ROOT/sdks/dart/CHANGELOG.md"
    CHANGELOG_DEST="$SDK_DIR/CHANGELOG.md"
    if [ -f "$CHANGELOG_SOURCE" ]; then
        if [ "$(readlink -f "$CHANGELOG_SOURCE" 2>/dev/null || echo "$CHANGELOG_SOURCE")" != "$(readlink -f "$CHANGELOG_DEST" 2>/dev/null || echo "$CHANGELOG_DEST")" ]; then
            cp -f "$CHANGELOG_SOURCE" "$CHANGELOG_DEST"
            log_success "CHANGELOG.md preserved"
        else
            log_info "CHANGELOG.md already in place"
        fi
    fi
    
    # Always copy the Dart-specific LICENSE file (not the generic proprietary one)
    # This overwrites any LICENSE file the generator might have created
    LICENSE_SOURCE="$PROJECT_ROOT/sdks/dart/LICENSE"
    LICENSE_DEST="$SDK_DIR/LICENSE"
    if [ -f "$LICENSE_SOURCE" ]; then
        if [ "$(readlink -f "$LICENSE_SOURCE" 2>/dev/null || echo "$LICENSE_SOURCE")" != "$(readlink -f "$LICENSE_DEST" 2>/dev/null || echo "$LICENSE_DEST")" ]; then
            cp -f "$LICENSE_SOURCE" "$LICENSE_DEST"
            log_success "LICENSE preserved"
        else
            log_info "LICENSE already in place"
        fi
    else
        log_warn "Dart SDK LICENSE file not found at $LICENSE_SOURCE"
        log_warn "Creating MIT LICENSE file..."
        cat > "$LICENSE_DEST" << 'EOF'
MIT License

Copyright (c) 2024 Caygnus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
        log_success "MIT LICENSE file created"
    fi
    echo ""
    
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

