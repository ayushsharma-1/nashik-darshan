#!/bin/bash
# publish-dart-sdk.sh - Publish Dart SDK to pub.dev
# This script verifies the package and uses standard 'dart pub publish' command

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
SDK_DIR="$PROJECT_ROOT/sdks/dart"

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

error_exit() {
    log_error "$1"
    exit 1
}

# Main execution
main() {
    log_info "Starting Dart SDK publishing"
    log_info "Project root: $PROJECT_ROOT"
    log_info "SDK directory: $SDK_DIR"
    echo ""

    # Step 1: Verify SDK directory exists
    log_step "Step 1/4: Verifying SDK directory"
    if [ ! -d "$SDK_DIR" ]; then
        error_exit "SDK directory not found: $SDK_DIR. Run 'make generate-dart-sdk' first."
    fi
    log_success "SDK directory found: $SDK_DIR"
    echo ""

    # Step 2: Verify pubspec.yaml exists
    log_step "Step 2/4: Verifying pubspec.yaml"
    if [ ! -f "$SDK_DIR/pubspec.yaml" ]; then
        error_exit "pubspec.yaml not found in SDK directory"
    fi
    
    PACKAGE_NAME=$(grep "^name:" "$SDK_DIR/pubspec.yaml" | cut -d: -f2 | xargs || echo "unknown")
    PACKAGE_VERSION=$(grep "^version:" "$SDK_DIR/pubspec.yaml" | cut -d: -f2 | xargs || echo "unknown")
    log_success "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    echo ""

    # Step 3: Check Dart installation
    log_step "Step 3/4: Checking Dart installation"
    
    if ! command -v dart &> /dev/null; then
        error_exit "Dart is not installed. Please install Dart SDK before continuing."
    fi
    DART_VERSION=$(dart --version 2>&1 | head -1)
    log_success "Dart found: $DART_VERSION"
    
    # Check if pub.dev token is configured (optional - will prompt during publish if not)
    if dart pub token list 2>/dev/null | grep -q "https://pub.dev"; then
        log_success "Found pub.dev token via 'dart pub token'"
    else
        log_warn "No pub.dev token found. You will be prompted to authenticate during publish."
        log_info "To add token manually, run: dart pub token add https://pub.dev"
    fi
    echo ""

    # Step 4: Run dry-run to verify package
    log_step "Step 4/4: Running dry-run to verify package"
    log_info "This will check the package without publishing..."
    echo ""
    
    cd "$SDK_DIR"
    
    if dart pub publish --dry-run 2>&1 | tee /tmp/dart-publish-dry-run.log; then
        echo ""
        log_success "Dry-run completed successfully!"
    else
        EXIT_CODE=$?
        echo ""
        log_error "Dry-run failed with exit code: $EXIT_CODE"
        if [ -f /tmp/dart-publish-dry-run.log ]; then
            log_error "Dry-run log saved to: /tmp/dart-publish-dry-run.log"
            log_error "Last 20 lines of log:"
            tail -20 /tmp/dart-publish-dry-run.log | sed 's/^/  /'
        fi
        exit $EXIT_CODE
    fi
    echo ""

    # Ready to publish
    log_success "Package verification complete!"
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    log_info "Registry: https://pub.dev"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info ""
    log_warn "⚠️  Ready to publish. This will publish to pub.dev!"
    log_info ""
    log_info "To publish, run manually:"
    log_info "  cd $SDK_DIR"
    log_info "  dart pub publish"
    log_info ""
    log_info "Or if you want to publish now, the script will proceed..."
    log_info ""

    # Ask for confirmation (non-interactive mode will skip)
    if [ -t 0 ]; then
        read -p "Do you want to publish now? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Publishing cancelled. Run 'dart pub publish' manually when ready."
            log_info ""
            log_info "Package is ready to publish from: $SDK_DIR"
            exit 0
        fi
    else
        log_info "Non-interactive mode: Skipping publish. Run 'dart pub publish' manually."
        log_info "Package is ready to publish from: $SDK_DIR"
        exit 0
    fi

    # Actual publish
    log_info "Publishing package (this may take a moment)..."
    log_info "You may be prompted to authenticate if not already configured."
    echo ""

    if dart pub publish 2>&1 | tee /tmp/dart-publish.log; then
        echo ""
        log_success "Package published successfully!"
        log_info "View package at: https://pub.dev/packages/$PACKAGE_NAME"
    else
        EXIT_CODE=$?
        echo ""
        log_error "Publishing failed with exit code: $EXIT_CODE"

        # Check for common errors
        if grep -qi "authentication\|not authenticated\|login" /tmp/dart-publish.log 2>/dev/null; then
            log_error ""
            log_error "Authentication error detected. This usually means:"
            log_error "  1. You need to authenticate with pub.dev"
            log_error "  2. Your token may have expired"
            log_error ""
            log_error "Solution: Run 'dart pub token add https://pub.dev' to authenticate"
            log_error "Then run 'dart pub publish' manually from: $SDK_DIR"
        elif grep -qi "already exists\|already published" /tmp/dart-publish.log 2>/dev/null; then
            log_error "Package version already exists on pub.dev"
            log_error "Update version in pubspec.yaml and try again"
        elif grep -qi "403\|Forbidden" /tmp/dart-publish.log 2>/dev/null; then
            log_error "403 Forbidden - Check your permissions for this package"
        fi

        if [ -f /tmp/dart-publish.log ]; then
            log_error "Full log saved to: /tmp/dart-publish.log"
        fi

        exit $EXIT_CODE
    fi
    echo ""

    log_success "Dart SDK publishing complete!"
    log_info "Package: $PACKAGE_NAME@$PACKAGE_VERSION"
    log_info "URL: https://pub.dev/packages/$PACKAGE_NAME"
    echo ""
}

# Run main function
main "$@"
