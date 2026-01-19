[![CI](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml)
[![Code Coverage](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/coverage.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/coverage.yml)
[![Static Analysis](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/static-analysis.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/static-analysis.yml)
[![Documentation](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/build-Doxygen.yaml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/build-Doxygen.yaml)
[![License](https://img.shields.io/github/license/{{GITHUB_USER}}/{{PROJECT_NAME}})](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/blob/main/LICENSE)

# {{PROJECT_TITLE}}

> **Language:** **English** | [한국어](README.kr.md)

## Overview

{{PROJECT_DESCRIPTION}}

**Key Value Propositions**:
- 🚀 **{{FEATURE_1}}**: {{FEATURE_1_DESC}}
- 🔒 **{{FEATURE_2}}**: {{FEATURE_2_DESC}}
- 🏗️ **{{FEATURE_3}}**: {{FEATURE_3_DESC}}
- 🛡️ **{{FEATURE_4}}**: {{FEATURE_4_DESC}}
- 🌐 **{{FEATURE_5}}**: {{FEATURE_5_DESC}}

**Latest Updates** ({{YEAR}}-{{MONTH}}):
- ✅ {{UPDATE_1}}
- ✅ {{UPDATE_2}}
- ✅ {{UPDATE_3}}

---

## Quick Start

### Basic Example

```cpp
#include <kcenon/{{PROJECT_NAME}}/core/{{MAIN_HEADER}}.h>

using namespace kcenon::{{NAMESPACE}};

int main() {
    // {{EXAMPLE_COMMENT}}
    {{EXAMPLE_CODE}}

    return 0;
}
```

📖 **[Full Getting Started Guide →](docs/guides/QUICK_START.md)**

---

## Requirements

| Dependency | Version | Required | Description |
|------------|---------|----------|-------------|
| C++20 Compiler | GCC 11+ / Clang 14+ / MSVC 2022+ / Apple Clang 14+ | Yes | C++20 features required |
| CMake | 3.20+ | Yes | Build system |
| [common_system](https://github.com/kcenon/common_system) | latest | Yes | Common interfaces and Result<T> |
{{ADDITIONAL_DEPENDENCIES}}

### Dependency Flow

```
{{PROJECT_NAME}}
├── common_system (required)
{{DEPENDENCY_TREE}}
```

---

## Installation

### Option 1: CMake Integration (Recommended)

```bash
# Clone dependencies
git clone https://github.com/kcenon/common_system.git
{{CLONE_COMMANDS}}
git clone https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}.git

# Build
cd {{PROJECT_NAME}}
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### Option 2: vcpkg (if available)

```bash
vcpkg install kcenon-{{PROJECT_NAME}}
```

### Using in Your Project

```cmake
find_package({{CMAKE_PACKAGE_NAME}} REQUIRED)
target_link_libraries(your_app PRIVATE {{CMAKE_TARGET_NAME}})
```

---

## Architecture

### Ecosystem Integration

Part of a modular C++ ecosystem with clean interface boundaries:

```
                    ┌──────────────────┐
                    │  common_system   │  Foundation Layer
                    │   (interfaces)   │
                    └────────┬─────────┘
                             │
       ┌─────────────────────┼─────────────────────┐
       │                     │                     │
┌──────▼───────┐    ┌────────▼────────┐   ┌───────▼────────┐
│thread_system │    │ {{PROJECT_NAME}}│   │ other_system   │
└──────────────┘    └─────────────────┘   └────────────────┘
```

**Integration Benefits**:
- Interface-only dependencies
- Independent compilation
- Runtime dependency injection
- Clean separation of concerns

📖 **[Complete Architecture Guide →](docs/advanced/ARCHITECTURE.md)**

---

## Core Features

### {{CORE_FEATURE_1_TITLE}}

{{CORE_FEATURE_1_DESC}}

```cpp
{{CORE_FEATURE_1_EXAMPLE}}
```

### {{CORE_FEATURE_2_TITLE}}

{{CORE_FEATURE_2_DESC}}

```cpp
{{CORE_FEATURE_2_EXAMPLE}}
```

📖 **[Detailed Features Documentation →](docs/FEATURES.md)**

---

## Documentation

| Category | Document | Description |
|----------|----------|-------------|
| **Guides** | [Quick Start](docs/guides/QUICK_START.md) | Getting started tutorial |
| | [Best Practices](docs/guides/BEST_PRACTICES.md) | Recommended patterns |
| | [FAQ](docs/guides/FAQ.md) | Frequently asked questions |
| | [Troubleshooting](docs/guides/TROUBLESHOOTING.md) | Common issues and solutions |
| **Advanced** | [Architecture](docs/advanced/ARCHITECTURE.md) | System design and internals |
| | [Performance](docs/advanced/PERFORMANCE.md) | Optimization techniques |
| | [Migration](docs/advanced/MIGRATION.md) | Version upgrade guide |
| **Contributing** | [Contributing](docs/contributing/CONTRIBUTING.md) | How to contribute |
| | [Testing](docs/contributing/TESTING.md) | Test guidelines |
| | [CI/CD](docs/contributing/CI_CD.md) | Pipeline documentation |

---

## Performance

| Metric | Value | Notes |
|--------|-------|-------|
| {{PERF_METRIC_1}} | {{PERF_VALUE_1}} | {{PERF_NOTE_1}} |
| {{PERF_METRIC_2}} | {{PERF_VALUE_2}} | {{PERF_NOTE_2}} |
| {{PERF_METRIC_3}} | {{PERF_VALUE_3}} | {{PERF_NOTE_3}} |

📖 **[Performance Baseline →](docs/performance/BASELINE.md)** | **[Benchmarks →](docs/performance/BENCHMARKS.md)**

---

## Contributing

We welcome contributions! Please see our [Contributing Guide](docs/contributing/CONTRIBUTING.md) for details.

### Quick Links

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Development Setup](docs/contributing/CONTRIBUTING.md#development-setup)
- [Pull Request Process](docs/contributing/CONTRIBUTING.md#pull-request-process)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

{{ACKNOWLEDGMENTS}}
