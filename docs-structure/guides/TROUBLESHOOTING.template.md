# Troubleshooting Guide

> **Language:** **English** | [한국어](TROUBLESHOOTING_KO.md)

This guide helps you diagnose and resolve common issues with {{PROJECT_NAME}}.

## Table of Contents

- [Build Issues](#build-issues)
- [Runtime Issues](#runtime-issues)
- [Performance Issues](#performance-issues)
- [Integration Issues](#integration-issues)
- [Getting Help](#getting-help)

---

## Build Issues

### Issue: CMake configuration fails

**Symptoms:**
```
CMake Error: Could not find a package configuration file provided by "{{CMAKE_PACKAGE_NAME}}"
```

**Solutions:**

1. **Check dependency locations:**
   ```bash
   ls -la ../common_system  # Should exist
   ```

2. **Specify paths explicitly:**
   ```bash
   cmake -B build \
     -Dcommon_system_DIR=../common_system/build \
     -DCMAKE_BUILD_TYPE=Release
   ```

3. **Build dependencies first:**
   ```bash
   cd ../common_system
   cmake -B build && cmake --build build
   cd ../{{PROJECT_NAME}}
   cmake -B build
   ```

---

### Issue: C++20 compilation errors

**Symptoms:**
```
error: 'concepts' is not a member of 'std'
error: expected unqualified-id before 'requires'
```

**Solutions:**

1. **Upgrade compiler:**
   ```bash
   # Ubuntu/Debian
   sudo apt install g++-11
   export CXX=g++-11

   # macOS
   brew install llvm
   export CXX=/opt/homebrew/opt/llvm/bin/clang++
   ```

2. **Set C++ standard explicitly:**
   ```cmake
   set(CMAKE_CXX_STANDARD 20)
   set(CMAKE_CXX_STANDARD_REQUIRED ON)
   ```

---

### Issue: Linker errors

**Symptoms:**
```
undefined reference to `kcenon::{{NAMESPACE}}::...'
```

**Solutions:**

1. **Check library linking:**
   ```cmake
   target_link_libraries(your_target
       PRIVATE
       {{CMAKE_TARGET_NAME}}
   )
   ```

2. **Verify build completed:**
   ```bash
   ls build/lib/  # Should contain lib{{PROJECT_NAME}}.*
   ```

---

## Runtime Issues

### Issue: Segmentation fault on startup

**Diagnosis:**
```bash
# Run with AddressSanitizer
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DENABLE_ASAN=ON
cmake --build build
./build/bin/your_app
```

**Common causes:**
1. Null pointer dereference
2. Use after free
3. Stack buffer overflow

**Solutions:**
- Check initialization order
- Verify all pointers before use
- Use `std::optional` for potentially null values

---

### Issue: Deadlock

**Diagnosis:**
```bash
# Run with ThreadSanitizer
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DENABLE_TSAN=ON
cmake --build build
./build/bin/your_app
```

**Common causes:**
1. Lock ordering violation
2. Recursive lock attempt on non-recursive mutex
3. Forgotten unlock

**Solutions:**
- Always acquire locks in consistent order
- Use `std::scoped_lock` for multiple locks
- Prefer lock-free alternatives when possible

---

### Issue: {{SPECIFIC_RUNTIME_ISSUE}}

**Symptoms:**
{{SPECIFIC_RUNTIME_SYMPTOMS}}

**Solutions:**
{{SPECIFIC_RUNTIME_SOLUTIONS}}

---

## Performance Issues

### Issue: High CPU usage

**Diagnosis:**
```bash
# Profile with perf (Linux)
perf record -g ./build/bin/your_app
perf report

# Profile with Instruments (macOS)
xcrun xctrace record --template "Time Profiler" --launch ./build/bin/your_app
```

**Common causes:**
1. Busy-wait loops
2. Excessive logging
3. Inefficient algorithms

**Solutions:**
- Use condition variables instead of polling
- Reduce log verbosity in production
- Profile and optimize hot paths

---

### Issue: High memory usage

**Diagnosis:**
```bash
# Run with Valgrind (Linux)
valgrind --tool=massif ./build/bin/your_app
ms_print massif.out.*

# Run with leaks (macOS)
leaks --atExit -- ./build/bin/your_app
```

**Common causes:**
1. Memory leaks
2. Unbounded caches
3. Large allocations

**Solutions:**
- Use smart pointers consistently
- Implement cache eviction policies
- Use memory pools for frequent allocations

---

## Integration Issues

### Issue: Logger integration not working

**Symptoms:**
- No log output
- Missing log entries

**Solutions:**

1. **Initialize logger first:**
   ```cpp
   // Logger must be initialized before {{PROJECT_NAME}}
   auto logger = create_logger();
   auto instance = {{BUILDER_CLASS}}()
       .with_logger(logger)
       .build();
   ```

2. **Check log level:**
   ```cpp
   logger->set_min_level(log_level::debug);
   ```

---

### Issue: Monitoring metrics not reported

**Symptoms:**
- Empty dashboards
- Missing metrics

**Solutions:**

1. **Enable monitoring:**
   ```cpp
   auto instance = {{BUILDER_CLASS}}()
       .with_monitoring(monitor)
       .build();
   ```

2. **Verify monitor is running:**
   ```cpp
   assert(monitor->is_running());
   ```

---

## Diagnostic Commands

### Quick Health Check

```bash
# Verify build
cmake --build build --target {{PROJECT_NAME}}_tests
ctest --test-dir build --output-on-failure

# Check for memory issues
cmake -B build-asan -DENABLE_ASAN=ON
cmake --build build-asan
./build-asan/bin/{{PROJECT_NAME}}_tests

# Check for thread issues
cmake -B build-tsan -DENABLE_TSAN=ON
cmake --build build-tsan
./build-tsan/bin/{{PROJECT_NAME}}_tests
```

### Collect Debug Information

When reporting issues, include:

```bash
# System info
uname -a
cat /etc/os-release  # Linux
sw_vers              # macOS

# Compiler version
${CXX} --version

# CMake version
cmake --version

# Build configuration
cat build/CMakeCache.txt | grep -E "(CMAKE_BUILD_TYPE|CMAKE_CXX)"
```

---

## Getting Help

If you can't resolve your issue:

1. **Search existing issues:**
   [GitHub Issues](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues)

2. **Check the FAQ:**
   [FAQ](FAQ.md)

3. **Open a new issue** with:
   - {{PROJECT_NAME}} version
   - Operating system and version
   - Compiler and version
   - Minimal reproduction code
   - Full error message/stack trace
   - Steps to reproduce

**Issue template:** [Bug Report](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues/new?template=bug_report.md)
