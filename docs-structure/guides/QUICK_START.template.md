# Quick Start Guide

> **Language:** **English** | [한국어](QUICK_START_KO.md)

This guide will help you get started with {{PROJECT_NAME}} in minutes.

## Prerequisites

Before you begin, ensure you have:

- [ ] C++20 compatible compiler (GCC 11+, Clang 14+, MSVC 2022+)
- [ ] CMake 3.20 or higher
- [ ] Git installed
- [ ] [common_system](https://github.com/kcenon/common_system) cloned

## Installation

### Step 1: Clone the Repository

```bash
# Clone common_system (required dependency)
git clone https://github.com/kcenon/common_system.git

# Clone {{PROJECT_NAME}}
git clone https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}.git
```

### Step 2: Build the Project

```bash
cd {{PROJECT_NAME}}

# Configure
cmake -B build -DCMAKE_BUILD_TYPE=Release

# Build
cmake --build build

# Run tests (optional)
ctest --test-dir build --output-on-failure
```

### Step 3: Verify Installation

```bash
# Run the sample application
./build/bin/{{PROJECT_NAME}}_sample
```

## Your First Program

Create a new file `main.cpp`:

```cpp
#include <kcenon/{{PROJECT_NAME}}/core/{{MAIN_HEADER}}.h>
#include <iostream>

using namespace kcenon::{{NAMESPACE}};

int main() {
    {{QUICK_START_EXAMPLE_CODE}}

    std::cout << "{{PROJECT_NAME}} is working!\n";
    return 0;
}
```

### Build Your Program

Create `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.20)
project(my_app)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package({{CMAKE_PACKAGE_NAME}} REQUIRED)

add_executable(my_app main.cpp)
target_link_libraries(my_app PRIVATE {{CMAKE_TARGET_NAME}})
```

Build and run:

```bash
cmake -B build
cmake --build build
./build/my_app
```

## Common Patterns

### Pattern 1: {{PATTERN_1_TITLE}}

```cpp
{{PATTERN_1_CODE}}
```

### Pattern 2: {{PATTERN_2_TITLE}}

```cpp
{{PATTERN_2_CODE}}
```

## Next Steps

Now that you have {{PROJECT_NAME}} running:

1. 📖 Read the [Best Practices Guide](BEST_PRACTICES.md)
2. 🏗️ Explore the [Architecture Overview](../advanced/ARCHITECTURE.md)
3. 💡 Check out the [Examples](../../examples/)
4. ❓ Review the [FAQ](FAQ.md) for common questions

## Troubleshooting

Having issues? Check these common solutions:

### Build Errors

| Error | Solution |
|-------|----------|
| `C++20 features not available` | Upgrade your compiler or add `-std=c++20` flag |
| `common_system not found` | Ensure common_system is cloned in the same parent directory |
| `CMake version too old` | Upgrade CMake to 3.20+ |

### Runtime Errors

| Error | Solution |
|-------|----------|
| {{RUNTIME_ERROR_1}} | {{RUNTIME_SOLUTION_1}} |
| {{RUNTIME_ERROR_2}} | {{RUNTIME_SOLUTION_2}} |

For more help, see [Troubleshooting Guide](TROUBLESHOOTING.md) or [open an issue](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues).
