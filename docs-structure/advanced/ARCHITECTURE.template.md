# Architecture Guide

> **Language:** **English** | [한국어](ARCHITECTURE_KO.md)

This document describes the architectural design and principles of {{PROJECT_NAME}}.

## Table of Contents

- [Overview](#overview)
- [Design Principles](#design-principles)
- [System Architecture](#system-architecture)
- [Component Design](#component-design)
- [Interface Definitions](#interface-definitions)
- [Data Flow](#data-flow)
- [Extension Points](#extension-points)

---

## Overview

{{PROJECT_NAME}} is designed with the following goals:

1. **Modularity**: Clean separation of concerns with well-defined interfaces
2. **Performance**: Zero-overhead abstractions where possible
3. **Testability**: Dependency injection and mockable interfaces
4. **Maintainability**: Clear ownership and minimal coupling

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Application Layer                        │
├─────────────────────────────────────────────────────────────┤
│                    {{PROJECT_NAME}}                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Core      │  │  {{MOD_1}}  │  │  {{MOD_2}}  │         │
│  │  Components │  │   Module    │  │   Module    │         │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘         │
│         │                │                │                  │
│  ┌──────▼────────────────▼────────────────▼──────┐         │
│  │              Internal Interfaces               │         │
│  └───────────────────────┬───────────────────────┘         │
├──────────────────────────┼──────────────────────────────────┤
│                          │                                   │
│  ┌───────────────────────▼───────────────────────┐         │
│  │            common_system Interfaces            │         │
│  │  (IExecutor, Result<T>, ILogger, IMonitor)    │         │
│  └───────────────────────────────────────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

---

## Design Principles

### 1. Interface-Based Design

All major components implement interfaces from `common_system`:

```cpp
// Dependency on interface, not implementation
class {{MAIN_CLASS}} {
public:
    explicit {{MAIN_CLASS}}(std::shared_ptr<IExecutor> executor)
        : executor_(std::move(executor)) {}

private:
    std::shared_ptr<IExecutor> executor_;
};
```

### 2. Result<T> Pattern

All fallible operations return `Result<T>` instead of throwing exceptions:

```cpp
Result<Data> load_data(const std::string& path) {
    if (!fs::exists(path)) {
        return Error{ErrorCode::FileNotFound, "File not found: " + path};
    }
    // ... load data
    return data;
}
```

### 3. RAII Resource Management

Resources are managed through RAII wrappers:

```cpp
class ResourceGuard {
public:
    explicit ResourceGuard(Resource* res) : resource_(res) {}
    ~ResourceGuard() { if (resource_) resource_->release(); }

    ResourceGuard(ResourceGuard&& other) noexcept
        : resource_(std::exchange(other.resource_, nullptr)) {}

private:
    Resource* resource_;
};
```

### 4. Compile-Time Validation

C++20 concepts validate types at compile time:

```cpp
template<typename T>
concept Serializable = requires(T t, Serializer& s) {
    { t.serialize(s) } -> std::same_as<void>;
    { T::deserialize(s) } -> std::same_as<Result<T>>;
};
```

---

## System Architecture

### Layer Diagram

```
┌────────────────────────────────────────────┐
│              Public API Layer              │  ← User-facing interfaces
├────────────────────────────────────────────┤
│           Business Logic Layer             │  ← Core functionality
├────────────────────────────────────────────┤
│            Infrastructure Layer            │  ← Cross-cutting concerns
├────────────────────────────────────────────┤
│             Foundation Layer               │  ← common_system interfaces
└────────────────────────────────────────────┘
```

### Module Dependencies

```
{{PROJECT_NAME}}
│
├── core/                 # Core components
│   ├── {{CORE_1}}.h
│   └── {{CORE_2}}.h
│
├── {{MODULE_1}}/         # {{MODULE_1_DESC}}
│   ├── interface.h       # Public interface
│   └── impl/             # Implementation details
│
├── {{MODULE_2}}/         # {{MODULE_2_DESC}}
│   ├── interface.h
│   └── impl/
│
└── internal/             # Internal utilities
    ├── utils.h
    └── types.h
```

---

## Component Design

### {{COMPONENT_1_NAME}}

**Purpose:** {{COMPONENT_1_PURPOSE}}

**Responsibilities:**
- {{COMPONENT_1_RESP_1}}
- {{COMPONENT_1_RESP_2}}
- {{COMPONENT_1_RESP_3}}

**Class Diagram:**

```
┌─────────────────────────────┐
│     I{{COMPONENT_1}}        │  ← Interface
├─────────────────────────────┤
│ + method1(): Result<T>      │
│ + method2(): void           │
└──────────────┬──────────────┘
               │ implements
               │
┌──────────────▼──────────────┐
│   {{COMPONENT_1}}Impl       │  ← Implementation
├─────────────────────────────┤
│ - dependency_: shared_ptr   │
│ - state_: atomic<State>     │
├─────────────────────────────┤
│ + method1(): Result<T>      │
│ + method2(): void           │
└─────────────────────────────┘
```

### {{COMPONENT_2_NAME}}

**Purpose:** {{COMPONENT_2_PURPOSE}}

**State Machine:**

```
     ┌─────────┐
     │  Init   │
     └────┬────┘
          │ start()
          ▼
     ┌─────────┐    error()    ┌─────────┐
     │ Running │──────────────►│  Error  │
     └────┬────┘               └────┬────┘
          │ stop()                  │ reset()
          ▼                         │
     ┌─────────┐◄───────────────────┘
     │ Stopped │
     └─────────┘
```

---

## Interface Definitions

### Core Interfaces

| Interface | Purpose | Defined In |
|-----------|---------|------------|
| `I{{INTERFACE_1}}` | {{INTERFACE_1_PURPOSE}} | `{{PROJECT_NAME}}/interfaces/` |
| `I{{INTERFACE_2}}` | {{INTERFACE_2_PURPOSE}} | `{{PROJECT_NAME}}/interfaces/` |
| `IExecutor` | Task execution | `common_system` |
| `ILogger` | Logging | `common_system` |

### Interface Contract Example

```cpp
class I{{INTERFACE_1}} {
public:
    virtual ~I{{INTERFACE_1}}() = default;

    /// @brief {{METHOD_1_BRIEF}}
    /// @param input {{METHOD_1_PARAM}}
    /// @return Result containing {{METHOD_1_RETURN}} or Error
    /// @thread_safety Thread-safe
    /// @complexity O(n)
    [[nodiscard]] virtual Result<{{RETURN_TYPE}}> method1(
        const Input& input) = 0;
};
```

---

## Data Flow

### Request Processing Flow

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│  Client  │────►│  Router  │────►│ Handler  │────►│ Backend  │
└──────────┘     └──────────┘     └──────────┘     └──────────┘
     │                                                   │
     │              Response                             │
     │◄──────────────────────────────────────────────────│
```

### Async Operation Flow

```
1. Client submits task
2. Task queued in executor
3. Worker thread picks up task
4. Task executed
5. Result delivered via callback/future
```

---

## Extension Points

### Custom {{EXTENSION_1}}

```cpp
class Custom{{EXTENSION_1}} : public I{{EXTENSION_1}} {
public:
    Result<Output> process(const Input& input) override {
        // Custom implementation
    }
};

// Register
auto builder = {{BUILDER_CLASS}}()
    .with_custom_{{EXTENSION_1}}(std::make_unique<Custom{{EXTENSION_1}}>());
```

### Plugin System

{{PROJECT_NAME}} supports plugins through:

1. **Interface implementation**: Implement `IPlugin` interface
2. **Registration**: Register via `PluginRegistry`
3. **Discovery**: Automatic discovery from plugin directory

---

## Threading Model

### Thread Ownership

| Component | Thread | Notes |
|-----------|--------|-------|
| {{THREAD_COMP_1}} | Dedicated | Single-threaded event loop |
| {{THREAD_COMP_2}} | Thread pool | Parallel processing |
| {{THREAD_COMP_3}} | Caller's thread | Synchronous operations |

### Synchronization

- **Prefer lock-free**: Use atomics where possible
- **Short critical sections**: Minimize lock hold time
- **Consistent ordering**: Document and enforce lock ordering

---

## Performance Considerations

### Memory Layout

```cpp
// Cache-friendly layout
struct alignas(64) CacheAlignedData {
    std::atomic<uint64_t> counter;  // Hot data
    char padding[56];                // Prevent false sharing
};
```

### Allocation Strategy

- Pool allocators for frequent small objects
- Pre-allocation where size is known
- Move semantics to avoid copies

---

## Related Documents

- [Performance Guide](PERFORMANCE.md)
- [API Reference](../api/README.md)
- [Migration Guide](MIGRATION.md)
- [ADR Index](../adr/)
