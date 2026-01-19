#!/bin/bash
#
# apply-template.sh - Apply template to an existing project
#
# Usage: ./scripts/apply-template.sh <target_project_path> [options]
#
# Options:
#   --backup          Create backup before applying (default: true)
#   --no-backup       Skip backup
#   --dry-run         Show what would be done without making changes
#   --force           Overwrite existing files without prompting
#   --docs-only       Only update documentation structure
#   --github-only     Only update GitHub templates
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
CREATE_BACKUP=true
DRY_RUN=false
FORCE=false
DOCS_ONLY=false
GITHUB_ONLY=false

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(dirname "$SCRIPT_DIR")"

print_usage() {
    echo "Usage: $0 <target_project_path> [options]"
    echo ""
    echo "Options:"
    echo "  --backup          Create backup before applying (default: true)"
    echo "  --no-backup       Skip backup"
    echo "  --dry-run         Show what would be done without making changes"
    echo "  --force           Overwrite existing files without prompting"
    echo "  --docs-only       Only update documentation structure"
    echo "  --github-only     Only update GitHub templates"
    echo "  --help            Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/existing/project --backup"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_dry_run() {
    echo -e "${YELLOW}[DRY-RUN]${NC} Would: $1"
}

# Parse arguments
if [[ $# -lt 1 ]]; then
    print_usage
    exit 1
fi

TARGET_PATH="$1"
shift

while [[ $# -gt 0 ]]; do
    case $1 in
        --backup)
            CREATE_BACKUP=true
            shift
            ;;
        --no-backup)
            CREATE_BACKUP=false
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --docs-only)
            DOCS_ONLY=true
            shift
            ;;
        --github-only)
            GITHUB_ONLY=true
            shift
            ;;
        --help)
            print_usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Validate target path
if [[ ! -d "$TARGET_PATH" ]]; then
    log_error "Target path does not exist: $TARGET_PATH"
    exit 1
fi

TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"
PROJECT_NAME=$(basename "$TARGET_PATH")

log_info "Applying template to: $TARGET_PATH"
log_info "Project name detected: $PROJECT_NAME"

# Create backup
if [[ "$CREATE_BACKUP" == true ]] && [[ "$DRY_RUN" == false ]]; then
    BACKUP_DIR="${TARGET_PATH}_backup_$(date +%Y%m%d_%H%M%S)"
    log_info "Creating backup at: $BACKUP_DIR"
    cp -r "$TARGET_PATH" "$BACKUP_DIR"
    log_success "Backup created"
fi

# Function to copy template file
copy_template() {
    local src="$1"
    local dst="$2"
    local dst_dir=$(dirname "$dst")

    if [[ "$DRY_RUN" == true ]]; then
        if [[ -f "$dst" ]]; then
            log_dry_run "Update $dst"
        else
            log_dry_run "Create $dst"
        fi
        return
    fi

    if [[ -f "$dst" ]] && [[ "$FORCE" != true ]]; then
        log_warning "File exists: $dst (use --force to overwrite)"
        return
    fi

    mkdir -p "$dst_dir"
    cp "$src" "$dst"
    log_success "Created: $dst"
}

# Apply documentation structure
apply_docs() {
    log_info "Applying documentation structure..."

    # Create docs directories
    local docs_dirs=(
        "docs/guides"
        "docs/advanced"
        "docs/adr"
        "docs/contributing"
        "docs/performance"
        "docs/integration"
    )

    for dir in "${docs_dirs[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            if [[ ! -d "$TARGET_PATH/$dir" ]]; then
                log_dry_run "Create directory: $dir"
            fi
        else
            mkdir -p "$TARGET_PATH/$dir"
        fi
    done

    # Copy template files (keep .template.md extension for reference)
    for template_file in "$TEMPLATE_DIR"/docs-structure/**/*.template.md; do
        if [[ -f "$template_file" ]]; then
            relative_path="${template_file#$TEMPLATE_DIR/docs-structure/}"
            # Keep as .template.md so user knows to fill in variables
            target_path="$TARGET_PATH/docs/${relative_path}"
            copy_template "$template_file" "$target_path"
        fi
    done

    log_success "Documentation structure applied"
}

# Apply GitHub templates
apply_github() {
    log_info "Applying GitHub templates..."

    # Create .github directories
    local github_dirs=(
        ".github/ISSUE_TEMPLATE"
        ".github/workflows"
    )

    for dir in "${github_dirs[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            if [[ ! -d "$TARGET_PATH/$dir" ]]; then
                log_dry_run "Create directory: $dir"
            fi
        else
            mkdir -p "$TARGET_PATH/$dir"
        fi
    done

    # Copy GitHub templates
    for github_file in "$TEMPLATE_DIR"/.github/**/*; do
        if [[ -f "$github_file" ]]; then
            relative_path="${github_file#$TEMPLATE_DIR/}"
            target_path="$TARGET_PATH/$relative_path"
            copy_template "$github_file" "$target_path"
        fi
    done

    log_success "GitHub templates applied"
}

# Apply README templates
apply_readme() {
    log_info "Applying README templates..."

    for template in README.template.md README_KO.template.md CHANGELOG.template.md; do
        if [[ -f "$TEMPLATE_DIR/templates/$template" ]]; then
            # Copy as .template.md for reference
            target_name="${template%.template.md}.template.md"
            copy_template "$TEMPLATE_DIR/templates/$template" "$TARGET_PATH/$target_name"
        fi
    done

    log_success "README templates applied"
}

# Main execution
if [[ "$GITHUB_ONLY" == true ]]; then
    apply_github
elif [[ "$DOCS_ONLY" == true ]]; then
    apply_docs
else
    apply_readme
    apply_docs
    apply_github
fi

# Generate checklist
echo ""
echo "=========================================="
log_success "Template applied successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo ""
echo "1. Review template files and fill in variables:"
echo "   - Search for {{VARIABLE_NAME}} patterns"
echo "   - Update with project-specific values"
echo ""
echo "2. Rename template files:"
echo "   - README.template.md -> README.md (merge with existing)"
echo "   - docs/**/*.template.md -> *.md"
echo ""
echo "3. Run validation:"
echo "   $SCRIPT_DIR/validate-docs.sh $TARGET_PATH"
echo ""
if [[ "$CREATE_BACKUP" == true ]] && [[ "$DRY_RUN" == false ]]; then
    echo "4. Backup location: $BACKUP_DIR"
    echo "   Delete when satisfied: rm -rf $BACKUP_DIR"
    echo ""
fi
