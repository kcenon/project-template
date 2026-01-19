[![CI](https://github.com/kcenon/sample_system/actions/workflows/ci.yml/badge.svg)](https://github.com/kcenon/sample_system/actions/workflows/ci.yml)
[![Code Coverage](https://github.com/kcenon/sample_system/actions/workflows/coverage.yml/badge.svg)](https://github.com/kcenon/sample_system/actions/workflows/coverage.yml)
[![Static Analysis](https://github.com/kcenon/sample_system/actions/workflows/static-analysis.yml/badge.svg)](https://github.com/kcenon/sample_system/actions/workflows/static-analysis.yml)
[![Documentation](https://github.com/kcenon/sample_system/actions/workflows/build-Doxygen.yaml/badge.svg)](https://github.com/kcenon/sample_system/actions/workflows/build-Doxygen.yaml)
[![License](https://img.shields.io/github/license/kcenon/sample_system)](https://github.com/kcenon/sample_system/blob/main/LICENSE)

# Sample System

> **Language:** **English** | [한국어](README_KO.md)

## Overview

A modern C++20 sample system demonstrating the project template structure. This project serves as a reference implementation showing how to use the documentation templates.

**Key Value Propositions**:
- 🚀 **High Performance**: Optimized for speed with zero-overhead abstractions
- 🔒 **Thread Safety**: Designed for concurrent access from the ground up
- 🏗️ **Modular Architecture**: Clean separation of concerns with interface-based design
- 🛡️ **Production Grade**: Comprehensive testing with sanitizers and CI/CD
- 🌐 **Cross-Platform**: Full support for Linux, macOS, and Windows

**Latest Updates** (2026-01):
- ✅ Initial release with core functionality
- ✅ Full documentation structure
- ✅ CI/CD pipeline configured

---

## Quick Start

### Basic Example

```cpp
#include <kcenon/sample/core/sample_manager.h>

using namespace kcenon::sample;

int main() {
    // Create sample manager using builder pattern
    auto result = sample_builder()
        .with_option("example")
        .with_threads(4)
        .build();

    if (result.is_err()) {
        std::cerr << "Error: " << result.error().message << "\n";
        return -1;
    }

    auto manager = std::move(result.value());
    manager->start();

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
| [thread_system](https://github.com/kcenon/thread_system) | latest | Yes | Thread pool and async operations |

### Dependency Flow

```
sample_system
├── common_system (required)
└── thread_system (required)
    └── common_system
```

---

## Installation

### Option 1: CMake Integration (Recommended)

```bash
# Clone dependencies
git clone https://github.com/kcenon/common_system.git
git clone https://github.com/kcenon/thread_system.git
git clone https://github.com/kcenon/sample_system.git

# Build
cd sample_system
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### Using in Your Project

```cmake
find_package(SampleSystem REQUIRED)
target_link_libraries(your_app PRIVATE sample_system)
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
│thread_system │    │  sample_system  │   │ other_system   │
└──────────────┘    └─────────────────┘   └────────────────┘
```

📖 **[Complete Architecture Guide →](docs/advanced/ARCHITECTURE.md)**

---

## Documentation

| Category | Document | Description |
|----------|----------|-------------|
| **Guides** | [Quick Start](docs/guides/QUICK_START.md) | Getting started tutorial |
| | [Best Practices](docs/guides/BEST_PRACTICES.md) | Recommended patterns |
| | [FAQ](docs/guides/FAQ.md) | Frequently asked questions |
| **Advanced** | [Architecture](docs/advanced/ARCHITECTURE.md) | System design and internals |
| | [Migration](docs/advanced/MIGRATION.md) | Version upgrade guide |
| **Contributing** | [Contributing](docs/contributing/CONTRIBUTING.md) | How to contribute |

---

## Performance

| Metric | Value | Notes |
|--------|-------|-------|
| Throughput | 1.5M ops/sec | 8 threads, 1KB payload |
| Latency (p50) | 45μs | Single operation |
| Latency (p99) | 120μs | Under load |

📖 **[Performance Baseline →](docs/performance/BASELINE.md)**

---

## Contributing

We welcome contributions! Please see our [Contributing Guide](docs/contributing/CONTRIBUTING.md).

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
