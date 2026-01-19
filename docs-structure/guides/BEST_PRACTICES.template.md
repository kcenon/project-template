# Best Practices

> **Language:** **English** | [한국어](BEST_PRACTICES_KO.md)

This guide covers recommended patterns and practices for using {{PROJECT_NAME}} effectively.

## Table of Contents

- [General Guidelines](#general-guidelines)
- [Performance Best Practices](#performance-best-practices)
- [Error Handling](#error-handling)
- [Thread Safety](#thread-safety)
- [Resource Management](#resource-management)
- [Testing](#testing)
- [Anti-Patterns to Avoid](#anti-patterns-to-avoid)

---

## General Guidelines

### 1. Use the Builder Pattern

**Recommended:**
```cpp
auto instance = {{BUILDER_CLASS}}()
    .with_option_a(value_a)
    .with_option_b(value_b)
    .build();
```

**Avoid:**
```cpp
auto instance = std::make_shared<{{MAIN_CLASS}}>();
instance->set_option_a(value_a);
instance->set_option_b(value_b);
// Missing validation!
```

### 2. Prefer Result<T> Over Exceptions

**Recommended:**
```cpp
auto result = operation();
if (result.is_err()) {
    handle_error(result.error());
    return;
}
auto value = std::move(result.value());
```

**Avoid:**
```cpp
try {
    auto value = operation_that_throws();
} catch (const std::exception& e) {
    // Exception handling is expensive
}
```

### 3. Use RAII for Resource Management

**Recommended:**
```cpp
{
    auto guard = make_scope_guard([&]() { cleanup(); });
    // Operations...
} // Automatic cleanup
```

---

## Performance Best Practices

### 1. Batch Operations When Possible

```cpp
// Good: Single batch operation
{{BATCH_EXAMPLE_GOOD}}

// Avoid: Multiple individual operations
{{BATCH_EXAMPLE_BAD}}
```

### 2. Use Move Semantics

```cpp
// Good: Move large objects
auto result = process(std::move(large_data));

// Avoid: Unnecessary copies
auto result = process(large_data);  // Copies the data
```

### 3. Pre-allocate When Size is Known

```cpp
std::vector<Item> items;
items.reserve(expected_count);  // Avoid reallocations
```

---

## Error Handling

### Use Structured Error Types

```cpp
// Good: Structured error with context
if (result.is_err()) {
    const auto& err = result.error();
    log_error("Operation failed: {} (code: {}, source: {})",
              err.message, err.code, err.source);
}

// Avoid: Generic error messages
if (!success) {
    log_error("Something went wrong");
}
```

### Chain Result Operations

```cpp
auto final_result = step_one()
    .and_then([](auto value) { return step_two(value); })
    .and_then([](auto value) { return step_three(value); })
    .map_err([](auto err) { return enrich_error(err); });
```

---

## Thread Safety

### 1. Use Thread-Safe Components

```cpp
// Good: Use provided thread-safe types
auto safe_container = make_thread_safe<Container>();

// Avoid: Manual locking
std::mutex mtx;
Container unsafe_container;
{
    std::lock_guard lock(mtx);
    unsafe_container.add(item);
}
```

### 2. Prefer Immutable Data

```cpp
// Good: Immutable configuration
const auto config = ConfigBuilder()
    .with_setting(value)
    .build();

// Pass by const reference
process(config);
```

---

## Resource Management

### 1. Use Smart Pointers Appropriately

| Ownership | Smart Pointer | Use Case |
|-----------|---------------|----------|
| Unique | `std::unique_ptr` | Single owner, transfer ownership |
| Shared | `std::shared_ptr` | Multiple owners needed |
| Non-owning | Raw pointer or `std::reference_wrapper` | Observer pattern |

### 2. Clean Shutdown

```cpp
// Good: Proper shutdown sequence
void shutdown() {
    // 1. Stop accepting new work
    stop_accepting();

    // 2. Wait for pending operations
    wait_for_completion();

    // 3. Release resources
    release_resources();
}
```

---

## Testing

### 1. Use Dependency Injection

```cpp
// Good: Testable with mock
class Service {
public:
    explicit Service(std::shared_ptr<IDatabase> db) : db_(std::move(db)) {}
private:
    std::shared_ptr<IDatabase> db_;
};

// In tests
auto mock_db = std::make_shared<MockDatabase>();
Service service(mock_db);
```

### 2. Test Error Paths

```cpp
TEST(ServiceTest, HandlesConnectionFailure) {
    auto mock_db = std::make_shared<MockDatabase>();
    EXPECT_CALL(*mock_db, connect())
        .WillOnce(Return(Error::ConnectionFailed));

    Service service(mock_db);
    auto result = service.initialize();

    EXPECT_TRUE(result.is_err());
    EXPECT_EQ(result.error().code, ErrorCode::ConnectionFailed);
}
```

---

## Anti-Patterns to Avoid

### 1. Don't Ignore Errors

```cpp
// BAD: Ignoring Result
operation();  // Result discarded!

// GOOD: Always handle Result
auto result = operation();
if (result.is_err()) {
    // Handle or propagate
}
```

### 2. Don't Block in Async Contexts

```cpp
// BAD: Blocking in async callback
async_operation([](auto result) {
    std::this_thread::sleep_for(1s);  // Blocks thread pool!
});

// GOOD: Defer blocking work
async_operation([](auto result) {
    schedule_on_blocking_thread([=]() {
        // Blocking work here
    });
});
```

### 3. Don't Create Circular Dependencies

```cpp
// BAD: Circular shared_ptr
class A {
    std::shared_ptr<B> b_;
};
class B {
    std::shared_ptr<A> a_;  // Memory leak!
};

// GOOD: Break cycle with weak_ptr
class B {
    std::weak_ptr<A> a_;
};
```

---

## Summary Checklist

- [ ] Use builder pattern for complex object construction
- [ ] Handle all Result<T> return values
- [ ] Prefer move semantics for large objects
- [ ] Use thread-safe components from the library
- [ ] Implement proper shutdown sequences
- [ ] Write tests for error paths
- [ ] Avoid blocking in async contexts

---

## Further Reading

- [Architecture Overview](../advanced/ARCHITECTURE.md)
- [Performance Guide](../advanced/PERFORMANCE.md)
- [Testing Guide](../contributing/TESTING.md)
