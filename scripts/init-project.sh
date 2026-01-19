#!/bin/bash
#
# init-project.sh - Initialize a new project from template
#
# Usage: ./scripts/init-project.sh <project_name> [options]
#
# Options:
#   --github-user <user>    GitHub username/org (default: kcenon)
#   --description <desc>    Project description
#   --no-git                Skip git initialization
#   --help                  Show this help message
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
GITHUB_USER="kcenon"
PROJECT_DESCRIPTION=""
INIT_GIT=true

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(dirname "$SCRIPT_DIR")"

print_usage() {
    echo "Usage: $0 <project_name> [options]"
    echo ""
    echo "Options:"
    echo "  --github-user <user>    GitHub username/org (default: kcenon)"
    echo "  --description <desc>    Project description"
    echo "  --no-git                Skip git initialization"
    echo "  --help                  Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 my_new_system --github-user myorg --description 'A new system'"
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

# Parse arguments
if [[ $# -lt 1 ]]; then
    print_usage
    exit 1
fi

PROJECT_NAME="$1"
shift

while [[ $# -gt 0 ]]; do
    case $1 in
        --github-user)
            GITHUB_USER="$2"
            shift 2
            ;;
        --description)
            PROJECT_DESCRIPTION="$2"
            shift 2
            ;;
        --no-git)
            INIT_GIT=false
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

# Validate project name
if [[ ! "$PROJECT_NAME" =~ ^[a-z][a-z0-9_]*$ ]]; then
    log_error "Invalid project name: $PROJECT_NAME"
    log_error "Project name must start with a letter and contain only lowercase letters, numbers, and underscores"
    exit 1
fi

# Generate derived names
PROJECT_TITLE=$(echo "$PROJECT_NAME" | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')
NAMESPACE=$(echo "$PROJECT_NAME" | sed 's/_system$//')
CMAKE_PACKAGE_NAME="${PROJECT_TITLE}System"
CMAKE_TARGET_NAME="${PROJECT_NAME}"
YEAR=$(date +%Y)
MONTH=$(date +%m)

log_info "Initializing project: $PROJECT_NAME"
log_info "  GitHub User: $GITHUB_USER"
log_info "  Project Title: $PROJECT_TITLE"
log_info "  Namespace: $NAMESPACE"

# Create project directory structure
log_info "Creating directory structure..."

mkdir -p "$PROJECT_NAME"/{src,include/"$PROJECT_NAME",tests,examples,docs/{guides,advanced,adr,contributing,performance}}

# Copy and process templates
log_info "Processing templates..."

# Function to replace template variables
process_template() {
    local src="$1"
    local dst="$2"

    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_TITLE}}/$PROJECT_TITLE/g" \
        -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION/g" \
        -e "s/{{GITHUB_USER}}/$GITHUB_USER/g" \
        -e "s/{{NAMESPACE}}/$NAMESPACE/g" \
        -e "s/{{CMAKE_PACKAGE_NAME}}/$CMAKE_PACKAGE_NAME/g" \
        -e "s/{{CMAKE_TARGET_NAME}}/$CMAKE_TARGET_NAME/g" \
        -e "s/{{YEAR}}/$YEAR/g" \
        -e "s/{{MONTH}}/$MONTH/g" \
        "$src" > "$dst"
}

# Process README templates
if [[ -f "$TEMPLATE_DIR/templates/README.template.md" ]]; then
    process_template "$TEMPLATE_DIR/templates/README.template.md" "$PROJECT_NAME/README.md"
    log_success "Created README.md"
fi

if [[ -f "$TEMPLATE_DIR/templates/README.kr.template.md" ]]; then
    process_template "$TEMPLATE_DIR/templates/README.kr.template.md" "$PROJECT_NAME/README.kr.md"
    log_success "Created README.kr.md"
fi

if [[ -f "$TEMPLATE_DIR/templates/CHANGELOG.template.md" ]]; then
    process_template "$TEMPLATE_DIR/templates/CHANGELOG.template.md" "$PROJECT_NAME/CHANGELOG.md"
    log_success "Created CHANGELOG.md"
fi

# Copy docs structure
log_info "Creating documentation structure..."

for template_file in "$TEMPLATE_DIR"/docs-structure/**/*.template.md; do
    if [[ -f "$template_file" ]]; then
        relative_path="${template_file#$TEMPLATE_DIR/docs-structure/}"
        target_path="$PROJECT_NAME/docs/${relative_path%.template.md}.md"
        target_dir=$(dirname "$target_path")
        mkdir -p "$target_dir"
        process_template "$template_file" "$target_path"
    fi
done
log_success "Created documentation structure"

# Copy .github templates
log_info "Creating GitHub templates..."
mkdir -p "$PROJECT_NAME/.github/ISSUE_TEMPLATE"
mkdir -p "$PROJECT_NAME/.github/workflows"

for github_file in "$TEMPLATE_DIR"/.github/**/*; do
    if [[ -f "$github_file" ]]; then
        relative_path="${github_file#$TEMPLATE_DIR/}"
        target_path="$PROJECT_NAME/$relative_path"
        target_dir=$(dirname "$target_path")
        mkdir -p "$target_dir"
        process_template "$github_file" "$target_path"
    fi
done
log_success "Created GitHub templates"

# Create CMakeLists.txt
log_info "Creating CMakeLists.txt..."
cat > "$PROJECT_NAME/CMakeLists.txt" << EOF
cmake_minimum_required(VERSION 3.20)
project($PROJECT_NAME
    VERSION 1.0.0
    DESCRIPTION "$PROJECT_DESCRIPTION"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Options
option(BUILD_TESTS "Build tests" ON)
option(BUILD_EXAMPLES "Build examples" ON)
option(ENABLE_ASAN "Enable AddressSanitizer" OFF)
option(ENABLE_TSAN "Enable ThreadSanitizer" OFF)
option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" OFF)
option(ENABLE_COVERAGE "Enable code coverage" OFF)

# Find dependencies
find_package(common_system REQUIRED)

# Main library
add_library(\${PROJECT_NAME} INTERFACE)
target_include_directories(\${PROJECT_NAME} INTERFACE
    \$<BUILD_INTERFACE:\${CMAKE_CURRENT_SOURCE_DIR}/include>
    \$<INSTALL_INTERFACE:include>
)
target_link_libraries(\${PROJECT_NAME} INTERFACE common_system::common_system)

# Tests
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# Examples
if(BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

# Installation
include(GNUInstallDirs)
install(TARGETS \${PROJECT_NAME}
    EXPORT \${PROJECT_NAME}Targets
)
install(DIRECTORY include/ DESTINATION \${CMAKE_INSTALL_INCLUDEDIR})
EOF
log_success "Created CMakeLists.txt"

# Create LICENSE
log_info "Creating LICENSE..."
cat > "$PROJECT_NAME/LICENSE" << EOF
MIT License

Copyright (c) $YEAR $GITHUB_USER

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
log_success "Created LICENSE"

# Create .gitignore
log_info "Creating .gitignore..."
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
# Build directories
build/
cmake-build-*/
out/

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# Compiled files
*.o
*.obj
*.a
*.lib
*.so
*.dylib
*.dll

# CMake
CMakeCache.txt
CMakeFiles/
cmake_install.cmake
Makefile

# Testing
Testing/
CTestTestfile.cmake

# Coverage
*.gcno
*.gcda
*.gcov
coverage/

# Package managers
vcpkg_installed/

# OS
.DS_Store
Thumbs.db
EOF
log_success "Created .gitignore"

# Initialize git repository
if [[ "$INIT_GIT" == true ]]; then
    log_info "Initializing git repository..."
    cd "$PROJECT_NAME"
    git init
    git add .
    git commit -m "Initial commit from project-template"
    log_success "Git repository initialized"
    cd ..
fi

# Summary
echo ""
echo "=========================================="
log_success "Project '$PROJECT_NAME' created successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_NAME"
echo "  2. Review and update README.md with your project details"
echo "  3. Fill in template variables (search for {{...}})"
echo "  4. Clone common_system: git clone https://github.com/kcenon/common_system.git ../"
echo "  5. Build: cmake -B build && cmake --build build"
echo ""
echo "Documentation:"
echo "  - docs/guides/QUICK_START.md"
echo "  - docs/advanced/ARCHITECTURE.md"
echo "  - docs/contributing/CONTRIBUTING.md"
echo ""
