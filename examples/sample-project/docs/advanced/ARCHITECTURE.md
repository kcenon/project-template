# Architecture Guide

> **Language:** **English** | [한국어](ARCHITECTURE_KO.md)

This document describes the architectural design and principles of sample_system.

## Overview

sample_system is designed with the following goals:

1. **Modularity**: Clean separation of concerns with well-defined interfaces
2. **Performance**: Zero-overhead abstractions where possible
3. **Testability**: Dependency injection and mockable interfaces
4. **Maintainability**: Clear ownership and minimal coupling

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Application Layer                        │
├─────────────────────────────────────────────────────────────┤
│                      sample_system                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Core      │  │  Processing │  │  Utilities  │         │
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

## Design Principles

### 1. Interface-Based Design

All major components implement interfaces from `common_system`:

```cpp
class sample_manager {
public:
    explicit sample_manager(std::shared_ptr<IExecutor> executor)
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

Resources are managed through RAII wrappers ensuring proper cleanup.

## Component Design

### Sample Manager

**Purpose:** Central coordination component for sample_system

**Responsibilities:**
- Task scheduling and execution
- Resource lifecycle management
- Error propagation and handling

**Class Diagram:**

```
┌─────────────────────────────┐
│     ISampleManager          │  ← Interface
├─────────────────────────────┤
│ + submit(task): Result<Id>  │
│ + shutdown(): void          │
│ + status(): Status          │
└──────────────┬──────────────┘
               │ implements
               │
┌──────────────▼──────────────┐
│   sample_manager            │  ← Implementation
├─────────────────────────────┤
│ - executor_: shared_ptr     │
│ - state_: atomic<State>     │
├─────────────────────────────┤
│ + submit(task): Result<Id>  │
│ + shutdown(): void          │
│ + status(): Status          │
└─────────────────────────────┘
```

## Related Documents

- [Performance Guide](PERFORMANCE.md)
- [Migration Guide](MIGRATION.md)
- [Contributing Guide](../contributing/CONTRIBUTING.md)
