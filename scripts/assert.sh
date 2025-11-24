#!/bin/bash
# assert.sh - Script for consistent error messaging in Makefile
# This script prints readable errors and exits non-zero on failure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if a command exists using which
check_command() {
    local cmd=$1
    local min_version=$2
    
    if ! which "$cmd" &> /dev/null; then
        echo -e "${RED}❌ $cmd not installed or incompatible. Install it before continuing.${NC}" >&2
        return 1
    fi
    
    # If min_version is provided, check version
    if [ -n "$min_version" ]; then
        case "$cmd" in
            node)
                local current_version=$(node --version | sed 's/v//' | cut -d. -f1)
                if [ "$current_version" -lt "$min_version" ]; then
                    echo -e "${RED}❌ $cmd version is too old. Required: >= $min_version, Found: $(node --version)${NC}" >&2
                    return 1
                fi
                echo -e "${GREEN}✓${NC} Node.js version: $(node --version)"
                ;;
            java)
                # Java version check
                if ! java -version &> /dev/null; then
                    echo -e "${RED}❌ $cmd not installed or incompatible. Install it before continuing.${NC}" >&2
                    return 1
                fi
                local java_version=$(java -version 2>&1 | head -n 1)
                echo -e "${GREEN}✓${NC} Java: $java_version"
                ;;
            dart)
                # Dart version check
                if ! dart --version &> /dev/null; then
                    echo -e "${RED}❌ $cmd not installed or incompatible. Install it before continuing.${NC}" >&2
                    return 1
                fi
                local dart_version=$(dart --version 2>&1 | head -n 1)
                echo -e "${GREEN}✓${NC} Dart: $dart_version"
                ;;
            npm)
                local npm_version=$(npm --version)
                echo -e "${GREEN}✓${NC} npm version: $npm_version"
                ;;
            openapi-generator-cli)
                local gen_version=$(openapi-generator-cli version 2>&1 | head -n 1 || echo "installed")
                echo -e "${GREEN}✓${NC} OpenAPI Generator CLI: $gen_version"
                ;;
        esac
    fi
    
    return 0
}

# Function to assert a command exists
assert_command() {
    local cmd=$1
    local min_version=$2
    
    if ! check_command "$cmd" "$min_version"; then
        exit 1
    fi
}

# Function to assert a file exists
assert_file() {
    local file=$1
    
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Required file not found: $file${NC}" >&2
        exit 1
    fi
}

# Function to assert a directory exists
assert_directory() {
    local dir=$1
    
    if [ ! -d "$dir" ]; then
        echo -e "${RED}❌ Required directory not found: $dir${NC}" >&2
        exit 1
    fi
}

# Main execution - if script is called directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    # Script is being executed directly
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <command> [args...]" >&2
        exit 1
    fi
    
    case "$1" in
        command)
            shift
            assert_command "$@"
            ;;
        file)
            shift
            assert_file "$@"
            ;;
        directory)
            shift
            assert_directory "$@"
            ;;
        *)
            echo "Unknown assertion type: $1" >&2
            exit 1
            ;;
    esac
fi

