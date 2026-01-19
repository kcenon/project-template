# Quick Start Guide

> **Language:** **English** | [한국어](QUICK_START_KO.md)

This guide will help you get started with sample_system in minutes.

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

# Clone thread_system (required dependency)
git clone https://github.com/kcenon/thread_system.git

# Clone sample_system
git clone https://github.com/kcenon/sample_system.git
```

### Step 2: Build the Project

```bash
cd sample_system

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
./build/bin/sample_system_sample
```

## Your First Program

Create a new file `main.cpp`:

```cpp
#include <kcenon/sample/core/sample_manager.h>
#include <iostream>

using namespace kcenon::sample;

int main() {
    // Create manager using builder pattern
    auto result = sample_builder()
        .with_name("MyApp")
        .with_threads(4)
        .build();

    if (result.is_err()) {
        std::cerr << "Error: " << result.error().message << "\n";
        return -1;
    }

    auto manager = std::move(result.value());

    // Process some work
    manager->submit([](){
        std::cout << "Processing work item\n";
    });

    // Clean shutdown
    manager->shutdown();

    std::cout << "sample_system is working!\n";
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

find_package(SampleSystem REQUIRED)

add_executable(my_app main.cpp)
target_link_libraries(my_app PRIVATE sample_system)
```

Build and run:

```bash
cmake -B build
cmake --build build
./build/my_app
```

## Common Patterns

### Pattern 1: Builder Configuration

```cpp
auto manager = sample_builder()
    .with_name("ServiceA")
    .with_threads(std::thread::hardware_concurrency())
    .with_queue_size(10000)
    .with_logger(my_logger)
    .build()
    .value();
```

### Pattern 2: Error Handling

```cpp
auto result = manager->process(data);
if (result.is_err()) {
    const auto& err = result.error();
    log_error("Failed: {} (code: {})", err.message, err.code);
    return handle_error(err);
}
auto output = std::move(result.value());
```

## Next Steps

Now that you have sample_system running:

1. 📖 Read the [Best Practices Guide](BEST_PRACTICES.md)
2. 🏗️ Explore the [Architecture Overview](../advanced/ARCHITECTURE.md)
3. 💡 Check out the [Examples](../../examples/)
4. ❓ Review the [FAQ](FAQ.md) for common questions

## Troubleshooting

Having issues? Check these common solutions:

| Error | Solution |
|-------|----------|
| `C++20 features not available` | Upgrade your compiler or add `-std=c++20` flag |
| `common_system not found` | Ensure common_system is cloned in the same parent directory |
| `CMake version too old` | Upgrade CMake to 3.20+ |

For more help, see [Troubleshooting Guide](TROUBLESHOOTING.md) or [open an issue](https://github.com/kcenon/sample_system/issues).
