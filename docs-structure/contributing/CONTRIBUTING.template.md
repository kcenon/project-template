# Contributing Guide

> **Language:** **English** | [한국어](CONTRIBUTING_KO.md)

Thank you for your interest in contributing to {{PROJECT_NAME}}! This guide will help you get started.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

---

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](../../CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

---

## Getting Started

### Types of Contributions

We welcome:

- **Bug reports**: Found a bug? [Open an issue](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues/new?template=bug_report.md)
- **Feature requests**: Have an idea? [Open an issue](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues/new?template=feature_request.md)
- **Code contributions**: Fix bugs, add features, improve documentation
- **Documentation**: Improve guides, fix typos, add examples
- **Testing**: Add test cases, improve coverage

### First Time Contributors

Look for issues labeled:
- [`good first issue`](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/labels/good%20first%20issue) - Great for newcomers
- [`help wanted`](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/labels/help%20wanted) - We need your help!

---

## Development Setup

### Prerequisites

- C++20 compatible compiler (GCC 11+, Clang 14+, MSVC 2022+)
- CMake 3.20+
- Git
- (Optional) clang-format, clang-tidy

### Clone and Build

```bash
# Fork the repository on GitHub first, then:
git clone https://github.com/YOUR_USERNAME/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}

# Add upstream remote
git remote add upstream https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}.git

# Clone dependencies
git clone https://github.com/kcenon/common_system.git ../common_system

# Build
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON
cmake --build build

# Run tests
ctest --test-dir build --output-on-failure
```

### IDE Setup

#### VS Code

Recommended extensions:
- C/C++ (Microsoft)
- CMake Tools
- clangd

`.vscode/settings.json`:
```json
{
    "cmake.configureArgs": ["-DBUILD_TESTS=ON"],
    "C_Cpp.default.cppStandard": "c++20"
}
```

#### CLion

1. Open the project folder
2. CMake will auto-configure
3. Set build type to Debug

---

## Making Changes

### Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/description` | `feature/add-retry-logic` |
| Bugfix | `fix/description` | `fix/memory-leak-in-pool` |
| Docs | `docs/description` | `docs/update-quick-start` |
| Refactor | `refactor/description` | `refactor/simplify-api` |

### Workflow

```bash
# 1. Sync with upstream
git fetch upstream
git checkout main
git merge upstream/main

# 2. Create feature branch
git checkout -b feature/your-feature

# 3. Make changes
# ... edit files ...

# 4. Format code
cmake --build build --target format

# 5. Run tests
ctest --test-dir build --output-on-failure

# 6. Commit (see commit guidelines below)
git add .
git commit -m "feat(module): add new capability"

# 7. Push
git push origin feature/your-feature
```

### Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, no logic change)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(core): add retry mechanism with exponential backoff

fix(pool): resolve memory leak when connection times out

docs(readme): update installation instructions

test(worker): add edge case tests for shutdown
```

---

## Pull Request Process

### Before Submitting

- [ ] Code compiles without warnings
- [ ] All tests pass
- [ ] New code has tests (aim for >80% coverage)
- [ ] Documentation updated if needed
- [ ] Commit messages follow convention
- [ ] Branch is up-to-date with main

### PR Template

When you open a PR, fill in:

```markdown
## Summary
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing performed

## Checklist
- [ ] Code follows project style
- [ ] Self-review completed
- [ ] Documentation updated
```

### Review Process

1. **Automated checks** - CI must pass
2. **Code review** - At least one maintainer approval
3. **Changes requested** - Address feedback, push updates
4. **Approval** - Maintainer approves
5. **Merge** - Squash and merge to main

---

## Coding Standards

### General Principles

- Write clear, self-documenting code
- Follow existing patterns in the codebase
- Keep functions small and focused
- Use meaningful names

### C++ Style Guide

We follow the [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines) with these specifics:

```cpp
// Naming
class MyClass {};           // PascalCase for types
void my_function();         // snake_case for functions
int member_variable_;       // snake_case with trailing underscore for members
constexpr int kMaxSize = 100;  // kPascalCase for constants

// Braces
if (condition) {
    // Always use braces
}

// Includes (order)
#include "{{PROJECT_NAME}}/module.h"  // 1. Corresponding header
#include <vector>                      // 2. Standard library
#include <third_party/lib.h>          // 3. Third-party
#include "{{PROJECT_NAME}}/other.h"   // 4. Project headers
```

### Formatting

Use clang-format with the provided `.clang-format`:

```bash
# Format all files
cmake --build build --target format

# Check formatting (CI does this)
cmake --build build --target format-check
```

---

## Testing Guidelines

### Test Organization

```
tests/
├── unit/           # Unit tests (isolated, fast)
├── integration/    # Integration tests (multiple components)
└── benchmark/      # Performance benchmarks
```

### Writing Tests

```cpp
#include <gtest/gtest.h>
#include "{{PROJECT_NAME}}/module.h"

class ModuleTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Setup code
    }

    void TearDown() override {
        // Cleanup code
    }
};

TEST_F(ModuleTest, MethodReturnsExpectedValue) {
    // Arrange
    auto module = create_module();

    // Act
    auto result = module.method();

    // Assert
    ASSERT_TRUE(result.is_ok());
    EXPECT_EQ(result.value(), expected_value);
}

TEST_F(ModuleTest, MethodHandlesError) {
    // Arrange
    auto module = create_module_with_invalid_config();

    // Act
    auto result = module.method();

    // Assert
    ASSERT_TRUE(result.is_err());
    EXPECT_EQ(result.error().code, ErrorCode::InvalidConfig);
}
```

### Running Tests

```bash
# All tests
ctest --test-dir build --output-on-failure

# Specific test
./build/tests/unit/module_test

# With sanitizers
cmake -B build-asan -DENABLE_ASAN=ON
cmake --build build-asan
ctest --test-dir build-asan
```

---

## Documentation

### When to Update Docs

- Adding new public API
- Changing existing behavior
- Adding examples
- Fixing unclear documentation

### Documentation Style

- Use clear, simple language
- Include code examples
- Keep examples runnable
- Update both English and Korean if possible

---

## Getting Help

- **Questions**: Open a [Discussion](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/discussions)
- **Bugs**: Open an [Issue](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues)
- **Chat**: {{CHAT_LINK}}

Thank you for contributing!
