# Migration Guide

> **Language:** **English** | [한국어](MIGRATION_KO.md)

This guide helps you migrate between major versions of {{PROJECT_NAME}}.

## Table of Contents

- [Migration Overview](#migration-overview)
- [Version Compatibility Matrix](#version-compatibility-matrix)
- [Migration: v1.x to v2.x](#migration-v1x-to-v2x)
- [Breaking Changes Summary](#breaking-changes-summary)
- [Deprecation Notices](#deprecation-notices)
- [Migration Tools](#migration-tools)

---

## Migration Overview

### Before You Begin

1. **Backup your code** - Create a branch for migration
2. **Review changelog** - Understand all changes in the target version
3. **Run tests** - Ensure current version works correctly
4. **Plan rollback** - Know how to revert if needed

### Migration Process

```
1. Update dependencies
        │
        ▼
2. Fix compilation errors
        │
        ▼
3. Address deprecation warnings
        │
        ▼
4. Update API usage
        │
        ▼
5. Run tests
        │
        ▼
6. Performance validation
```

---

## Version Compatibility Matrix

| {{PROJECT_NAME}} | common_system | thread_system | C++ Standard |
|------------------|---------------|---------------|--------------|
| 2.x | 2.x | 2.x | C++20 |
| 1.x | 1.x | 1.x | C++17/20 |

---

## Migration: v1.x to v2.x

### Overview

Version 2.0 introduces significant improvements:

- **New**: {{V2_NEW_FEATURE_1}}
- **New**: {{V2_NEW_FEATURE_2}}
- **Breaking**: {{V2_BREAKING_1}}
- **Breaking**: {{V2_BREAKING_2}}
- **Deprecated**: {{V2_DEPRECATED_1}}

### Step 1: Update Dependencies

```bash
# Update to latest v2.x
cd common_system && git checkout v2.0.0
cd ../thread_system && git checkout v2.0.0
cd ../{{PROJECT_NAME}} && git checkout v2.0.0
```

### Step 2: Namespace Changes

**v1.x:**
```cpp
using namespace {{OLD_NAMESPACE}};
```

**v2.x:**
```cpp
using namespace kcenon::{{NAMESPACE}};
```

**Migration script:**
```bash
# Find and replace namespace
find . -name "*.cpp" -o -name "*.h" | xargs sed -i 's/{{OLD_NAMESPACE}}/kcenon::{{NAMESPACE}}/g'
```

### Step 3: API Changes

#### Change 1: {{API_CHANGE_1_TITLE}}

**v1.x (deprecated):**
```cpp
{{API_CHANGE_1_OLD}}
```

**v2.x:**
```cpp
{{API_CHANGE_1_NEW}}
```

**Rationale:** {{API_CHANGE_1_RATIONALE}}

---

#### Change 2: {{API_CHANGE_2_TITLE}}

**v1.x (deprecated):**
```cpp
{{API_CHANGE_2_OLD}}
```

**v2.x:**
```cpp
{{API_CHANGE_2_NEW}}
```

**Rationale:** {{API_CHANGE_2_RATIONALE}}

---

### Step 4: Configuration Changes

**v1.x config:**
```yaml
{{CONFIG_V1}}
```

**v2.x config:**
```yaml
{{CONFIG_V2}}
```

### Step 5: Build System Updates

**CMakeLists.txt changes:**

```cmake
# v1.x
find_package({{OLD_CMAKE_PACKAGE}} REQUIRED)
target_link_libraries(app PRIVATE {{OLD_CMAKE_TARGET}})

# v2.x
find_package({{CMAKE_PACKAGE_NAME}} REQUIRED)
target_link_libraries(app PRIVATE {{CMAKE_TARGET_NAME}})
```

---

## Breaking Changes Summary

### v2.0.0

| Change | Impact | Migration |
|--------|--------|-----------|
| {{BREAKING_1}} | {{BREAKING_1_IMPACT}} | {{BREAKING_1_MIGRATION}} |
| {{BREAKING_2}} | {{BREAKING_2_IMPACT}} | {{BREAKING_2_MIGRATION}} |
| {{BREAKING_3}} | {{BREAKING_3_IMPACT}} | {{BREAKING_3_MIGRATION}} |

---

## Deprecation Notices

### Deprecated in v2.0 (Removal in v3.0)

| Item | Replacement | Notes |
|------|-------------|-------|
| `{{DEPRECATED_1}}` | `{{REPLACEMENT_1}}` | {{DEPRECATED_1_NOTES}} |
| `{{DEPRECATED_2}}` | `{{REPLACEMENT_2}}` | {{DEPRECATED_2_NOTES}} |

### How to Handle Deprecation Warnings

```cpp
// Suppress specific warning (temporary)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
legacy_function();  // Will be removed in v3.0
#pragma GCC diagnostic pop

// Better: Update to new API
new_function();
```

---

## Migration Tools

### Automated Migration Script

```bash
#!/bin/bash
# migrate-v1-to-v2.sh

echo "Starting migration from v1.x to v2.x..."

# Step 1: Namespace migration
echo "Migrating namespaces..."
find . -name "*.cpp" -o -name "*.h" | \
    xargs sed -i 's/{{OLD_NAMESPACE}}/kcenon::{{NAMESPACE}}/g'

# Step 2: API renames
echo "Updating API calls..."
find . -name "*.cpp" -o -name "*.h" | \
    xargs sed -i 's/{{OLD_API_1}}/{{NEW_API_1}}/g'

# Step 3: Include path updates
echo "Updating include paths..."
find . -name "*.cpp" -o -name "*.h" | \
    xargs sed -i 's|{{OLD_INCLUDE}}|{{NEW_INCLUDE}}|g'

echo "Migration complete. Please review changes and run tests."
```

### Validation Checklist

After migration, verify:

- [ ] Project compiles without errors
- [ ] No deprecation warnings (or documented exceptions)
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Performance benchmarks meet baseline
- [ ] Documentation updated

---

## Troubleshooting Migration Issues

### Common Issue 1: {{MIGRATION_ISSUE_1}}

**Symptom:**
```
{{MIGRATION_ISSUE_1_SYMPTOM}}
```

**Solution:**
{{MIGRATION_ISSUE_1_SOLUTION}}

### Common Issue 2: {{MIGRATION_ISSUE_2}}

**Symptom:**
```
{{MIGRATION_ISSUE_2_SYMPTOM}}
```

**Solution:**
{{MIGRATION_ISSUE_2_SOLUTION}}

---

## Getting Help

If you encounter issues during migration:

1. Check [FAQ](../guides/FAQ.md) for common questions
2. Search [GitHub Issues](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/issues)
3. Open a new issue with the `migration` label

---

## Related Documents

- [Changelog](../../CHANGELOG.md)
- [Architecture](ARCHITECTURE.md)
- [Breaking Changes Policy](../contributing/BREAKING_CHANGES.md)
