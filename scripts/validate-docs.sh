#!/bin/bash
#
# validate-docs.sh - Validate documentation structure and content
#
# Usage: ./scripts/validate-docs.sh <project_path> [options]
#
# Options:
#   --strict          Fail on warnings (default: only fail on errors)
#   --fix             Attempt to fix simple issues
#   --verbose         Show detailed output
#   --help            Show this help message
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
STRICT=false
FIX=false
VERBOSE=false

# Counters
ERRORS=0
WARNINGS=0

print_usage() {
    echo "Usage: $0 <project_path> [options]"
    echo ""
    echo "Options:"
    echo "  --strict          Fail on warnings"
    echo "  --fix             Attempt to fix simple issues"
    echo "  --verbose         Show detailed output"
    echo "  --help            Show this help message"
}

log_info() {
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${BLUE}[INFO]${NC} $1"
    fi
}

log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

log_warning() {
    ((WARNINGS++))
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    ((ERRORS++))
    echo -e "${RED}[FAIL]${NC} $1"
}

# Parse arguments
if [[ $# -lt 1 ]]; then
    print_usage
    exit 1
fi

PROJECT_PATH="$1"
shift

while [[ $# -gt 0 ]]; do
    case $1 in
        --strict)
            STRICT=true
            shift
            ;;
        --fix)
            FIX=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Validate project path
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Project path does not exist: $PROJECT_PATH"
    exit 1
fi

PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"
PROJECT_NAME=$(basename "$PROJECT_PATH")

echo "=========================================="
echo "Validating documentation for: $PROJECT_NAME"
echo "=========================================="
echo ""

# Check required files
echo "Checking required files..."

REQUIRED_FILES=(
    "README.md"
    "LICENSE"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ -f "$PROJECT_PATH/$file" ]]; then
        log_pass "$file exists"
    else
        log_error "$file is missing"
    fi
done

# Check optional but recommended files
RECOMMENDED_FILES=(
    "README.kr.md"
    "CHANGELOG.md"
    "CODE_OF_CONDUCT.md"
)

for file in "${RECOMMENDED_FILES[@]}"; do
    if [[ -f "$PROJECT_PATH/$file" ]]; then
        log_pass "$file exists"
    else
        log_warning "$file is missing (recommended)"
    fi
done

echo ""

# Check docs directory structure
echo "Checking docs directory structure..."

REQUIRED_DOCS_DIRS=(
    "docs/guides"
    "docs/advanced"
    "docs/contributing"
)

RECOMMENDED_DOCS_DIRS=(
    "docs/adr"
    "docs/performance"
    "docs/integration"
)

for dir in "${REQUIRED_DOCS_DIRS[@]}"; do
    if [[ -d "$PROJECT_PATH/$dir" ]]; then
        log_pass "$dir exists"
    else
        log_error "$dir is missing"
        if [[ "$FIX" == true ]]; then
            mkdir -p "$PROJECT_PATH/$dir"
            echo "  -> Created $dir"
        fi
    fi
done

for dir in "${RECOMMENDED_DOCS_DIRS[@]}"; do
    if [[ -d "$PROJECT_PATH/$dir" ]]; then
        log_pass "$dir exists"
    else
        log_warning "$dir is missing (recommended)"
    fi
done

echo ""

# Check for essential documentation
echo "Checking essential documentation..."

ESSENTIAL_DOCS=(
    "docs/guides/QUICK_START.md"
    "docs/advanced/ARCHITECTURE.md"
    "docs/contributing/CONTRIBUTING.md"
)

for doc in "${ESSENTIAL_DOCS[@]}"; do
    if [[ -f "$PROJECT_PATH/$doc" ]]; then
        log_pass "$doc exists"
    else
        log_warning "$doc is missing"
    fi
done

echo ""

# Check README structure
echo "Checking README.md structure..."

if [[ -f "$PROJECT_PATH/README.md" ]]; then
    README_CONTENT=$(cat "$PROJECT_PATH/README.md")

    # Check for required sections
    REQUIRED_SECTIONS=(
        "## Overview"
        "## Quick Start"
        "## Requirements"
    )

    for section in "${REQUIRED_SECTIONS[@]}"; do
        if echo "$README_CONTENT" | grep -q "$section"; then
            log_pass "README has '$section' section"
        else
            log_warning "README missing '$section' section"
        fi
    done

    # Check for language toggle
    if echo "$README_CONTENT" | grep -q "한국어"; then
        log_pass "README has language toggle"
    else
        log_warning "README missing language toggle"
    fi

    # Check for unfilled template variables
    TEMPLATE_VARS=$(echo "$README_CONTENT" | grep -oE '\{\{[A-Z_]+\}\}' | sort -u || true)
    if [[ -n "$TEMPLATE_VARS" ]]; then
        log_warning "README contains unfilled template variables:"
        echo "$TEMPLATE_VARS" | while read -r var; do
            echo "  - $var"
        done
    else
        log_pass "No unfilled template variables in README"
    fi
fi

echo ""

# Check for broken internal links
echo "Checking for broken internal links..."

find "$PROJECT_PATH" -name "*.md" -type f | while read -r md_file; do
    # Extract markdown links
    links=$(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$md_file" | grep -oE '\(([^)]+)\)' | tr -d '()' || true)

    for link in $links; do
        # Skip external links and anchors
        if [[ "$link" =~ ^https?:// ]] || [[ "$link" =~ ^# ]]; then
            continue
        fi

        # Resolve relative path
        link_dir=$(dirname "$md_file")
        target_path="$link_dir/$link"

        # Remove anchor from path
        target_path="${target_path%%#*}"

        if [[ ! -e "$target_path" ]] && [[ ! -e "$PROJECT_PATH/$link" ]]; then
            relative_md="${md_file#$PROJECT_PATH/}"
            log_warning "Broken link in $relative_md: $link"
        fi
    done
done

log_pass "Link check complete"

echo ""

# Check .github templates
echo "Checking GitHub templates..."

GITHUB_TEMPLATES=(
    ".github/ISSUE_TEMPLATE/bug_report.md"
    ".github/ISSUE_TEMPLATE/feature_request.md"
    ".github/PULL_REQUEST_TEMPLATE.md"
)

for template in "${GITHUB_TEMPLATES[@]}"; do
    if [[ -f "$PROJECT_PATH/$template" ]]; then
        log_pass "$template exists"
    else
        log_warning "$template is missing"
    fi
done

# Check workflows
if [[ -d "$PROJECT_PATH/.github/workflows" ]]; then
    workflow_count=$(find "$PROJECT_PATH/.github/workflows" -name "*.yml" -o -name "*.yaml" | wc -l)
    if [[ $workflow_count -gt 0 ]]; then
        log_pass "Found $workflow_count workflow(s)"
    else
        log_warning "No workflows found in .github/workflows"
    fi
else
    log_warning ".github/workflows directory is missing"
fi

echo ""

# Summary
echo "=========================================="
echo "Validation Summary"
echo "=========================================="
echo ""
echo -e "Errors:   ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"
echo ""

if [[ $ERRORS -gt 0 ]]; then
    echo -e "${RED}Validation FAILED${NC}"
    exit 1
elif [[ $WARNINGS -gt 0 ]] && [[ "$STRICT" == true ]]; then
    echo -e "${YELLOW}Validation FAILED (strict mode)${NC}"
    exit 1
else
    echo -e "${GREEN}Validation PASSED${NC}"
    exit 0
fi
