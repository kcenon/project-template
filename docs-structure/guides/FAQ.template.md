# Frequently Asked Questions

> **Language:** **English** | [한국어](FAQ_KO.md)

## Table of Contents

- [General](#general)
- [Installation & Setup](#installation--setup)
- [Usage](#usage)
- [Performance](#performance)
- [Troubleshooting](#troubleshooting)

---

## General

### Q: What is {{PROJECT_NAME}}?

**A:** {{PROJECT_NAME}} is {{PROJECT_DESCRIPTION}}. It is part of the kcenon C++ ecosystem and provides {{MAIN_PURPOSE}}.

### Q: What C++ standard is required?

**A:** {{PROJECT_NAME}} requires C++20. Supported compilers:
- GCC 11 or later
- Clang 14 or later
- MSVC 2022 or later
- Apple Clang 14 or later

### Q: Is {{PROJECT_NAME}} header-only?

**A:** {{HEADER_ONLY_ANSWER}}

### Q: What platforms are supported?

**A:** {{PROJECT_NAME}} supports:
- Linux (Ubuntu 20.04+, Debian 11+, etc.)
- macOS (11.0+)
- Windows (10/11, Server 2019+)

### Q: What is the license?

**A:** {{PROJECT_NAME}} is released under the MIT License. See [LICENSE](../../LICENSE) for details.

---

## Installation & Setup

### Q: How do I install {{PROJECT_NAME}}?

**A:** See the [Quick Start Guide](QUICK_START.md) for detailed instructions. The basic steps are:

```bash
git clone https://github.com/kcenon/common_system.git
git clone https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
cmake -B build && cmake --build build
```

### Q: What are the dependencies?

**A:** Required dependencies:
- **common_system** - Core interfaces and Result<T> pattern
{{ADDITIONAL_FAQ_DEPENDENCIES}}

### Q: Can I use vcpkg?

**A:** {{VCPKG_ANSWER}}

### Q: How do I integrate with CMake?

**A:**
```cmake
find_package({{CMAKE_PACKAGE_NAME}} REQUIRED)
target_link_libraries(your_target PRIVATE {{CMAKE_TARGET_NAME}})
```

---

## Usage

### Q: How do I handle errors?

**A:** {{PROJECT_NAME}} uses the Result<T> pattern for error handling:

```cpp
auto result = operation();
if (result.is_err()) {
    const auto& err = result.error();
    std::cerr << "Error: " << err.message << " (code: " << err.code << ")\n";
    return;
}
auto value = std::move(result.value());
```

### Q: Is {{PROJECT_NAME}} thread-safe?

**A:** {{THREAD_SAFETY_ANSWER}}

### Q: How do I {{COMMON_TASK_1}}?

**A:**
```cpp
{{COMMON_TASK_1_CODE}}
```

### Q: How do I {{COMMON_TASK_2}}?

**A:**
```cpp
{{COMMON_TASK_2_CODE}}
```

### Q: Can I use {{PROJECT_NAME}} with other logging frameworks?

**A:** {{LOGGING_INTEGRATION_ANSWER}}

---

## Performance

### Q: What is the performance overhead?

**A:** {{PERFORMANCE_OVERHEAD_ANSWER}}

Key benchmarks:
| Metric | Value |
|--------|-------|
| {{PERF_METRIC_1}} | {{PERF_VALUE_1}} |
| {{PERF_METRIC_2}} | {{PERF_VALUE_2}} |

See [Performance Baseline](../performance/BASELINE.md) for detailed benchmarks.

### Q: How can I optimize performance?

**A:** Key optimization strategies:
1. {{OPTIMIZATION_TIP_1}}
2. {{OPTIMIZATION_TIP_2}}
3. {{OPTIMIZATION_TIP_3}}

See [Performance Guide](../advanced/PERFORMANCE.md) for details.

### Q: Does {{PROJECT_NAME}} support SIMD?

**A:** {{SIMD_ANSWER}}

---

## Troubleshooting

### Q: Build fails with "C++20 features not available"

**A:** Ensure your compiler supports C++20:
```bash
# Check GCC version
g++ --version  # Should be 11+

# Check Clang version
clang++ --version  # Should be 14+
```

If using CMake, add:
```cmake
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
```

### Q: "common_system not found" error

**A:** Ensure common_system is cloned in the same parent directory:
```
parent_directory/
├── common_system/
└── {{PROJECT_NAME}}/
```

### Q: {{COMMON_ERROR_1}}

**A:** {{COMMON_ERROR_1_SOLUTION}}

### Q: {{COMMON_ERROR_2}}

**A:** {{COMMON_ERROR_2_SOLUTION}}

### Q: How do I report a bug?

**A:** Please open an issue on GitHub:
1. Go to [Issues](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues)
2. Click "New Issue"
3. Select "Bug Report" template
4. Fill in the required information

---

## Still Have Questions?

- Check the [Troubleshooting Guide](TROUBLESHOOTING.md)
- Search [existing issues](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues)
- Open a [new issue](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues/new)
- Read the [Architecture Documentation](../advanced/ARCHITECTURE.md)
