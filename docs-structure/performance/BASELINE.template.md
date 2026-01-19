# Performance Baseline

> **Language:** **English** | [한국어](BASELINE_KO.md)

This document records the performance baseline measurements for {{PROJECT_NAME}}.

## Table of Contents

- [Overview](#overview)
- [Test Environment](#test-environment)
- [Benchmark Results](#benchmark-results)
- [Comparison with Alternatives](#comparison-with-alternatives)
- [Historical Trends](#historical-trends)
- [Methodology](#methodology)

---

## Overview

**Last Updated:** {{BASELINE_DATE}}
**Version:** {{PROJECT_VERSION}}

### Summary

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| {{METRIC_1}} | {{VALUE_1}} | {{TARGET_1}} | {{STATUS_1}} |
| {{METRIC_2}} | {{VALUE_2}} | {{TARGET_2}} | {{STATUS_2}} |
| {{METRIC_3}} | {{VALUE_3}} | {{TARGET_3}} | {{STATUS_3}} |
| {{METRIC_4}} | {{VALUE_4}} | {{TARGET_4}} | {{STATUS_4}} |

---

## Test Environment

### Hardware

| Component | Specification |
|-----------|---------------|
| CPU | {{CPU_MODEL}} |
| Cores | {{CPU_CORES}} |
| RAM | {{RAM_SIZE}} |
| Storage | {{STORAGE_TYPE}} |

### Software

| Component | Version |
|-----------|---------|
| OS | {{OS_VERSION}} |
| Compiler | {{COMPILER_VERSION}} |
| {{PROJECT_NAME}} | {{PROJECT_VERSION}} |
| common_system | {{COMMON_SYSTEM_VERSION}} |

### Build Configuration

```bash
cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-O3 -march=native" \
    -DBUILD_BENCHMARKS=ON
```

---

## Benchmark Results

### {{BENCHMARK_CATEGORY_1}}

#### {{BENCHMARK_1_NAME}}

**Description:** {{BENCHMARK_1_DESC}}

| Threads | Ops/sec | Latency (p50) | Latency (p99) |
|---------|---------|---------------|---------------|
| 1 | {{B1_1T_OPS}} | {{B1_1T_P50}} | {{B1_1T_P99}} |
| 4 | {{B1_4T_OPS}} | {{B1_4T_P50}} | {{B1_4T_P99}} |
| 8 | {{B1_8T_OPS}} | {{B1_8T_P50}} | {{B1_8T_P99}} |
| 16 | {{B1_16T_OPS}} | {{B1_16T_P50}} | {{B1_16T_P99}} |

**Scaling efficiency:** {{B1_SCALING}}

---

#### {{BENCHMARK_2_NAME}}

**Description:** {{BENCHMARK_2_DESC}}

| Payload Size | Throughput | CPU Usage | Memory |
|--------------|------------|-----------|--------|
| 1 KB | {{B2_1K_THROUGHPUT}} | {{B2_1K_CPU}} | {{B2_1K_MEM}} |
| 10 KB | {{B2_10K_THROUGHPUT}} | {{B2_10K_CPU}} | {{B2_10K_MEM}} |
| 100 KB | {{B2_100K_THROUGHPUT}} | {{B2_100K_CPU}} | {{B2_100K_MEM}} |
| 1 MB | {{B2_1M_THROUGHPUT}} | {{B2_1M_CPU}} | {{B2_1M_MEM}} |

---

### {{BENCHMARK_CATEGORY_2}}

#### Memory Usage

| Scenario | Peak Memory | Steady State | Allocations/sec |
|----------|-------------|--------------|-----------------|
| Idle | {{MEM_IDLE_PEAK}} | {{MEM_IDLE_STEADY}} | {{MEM_IDLE_ALLOC}} |
| Light load | {{MEM_LIGHT_PEAK}} | {{MEM_LIGHT_STEADY}} | {{MEM_LIGHT_ALLOC}} |
| Heavy load | {{MEM_HEAVY_PEAK}} | {{MEM_HEAVY_STEADY}} | {{MEM_HEAVY_ALLOC}} |

#### Latency Distribution

```
Latency Histogram ({{BENCHMARK_1_NAME}}, 8 threads)

     0-10μs   ████████████████████████████████████████ 45%
   10-50μs   ████████████████████████████ 32%
  50-100μs   ████████████ 15%
 100-500μs   ████ 5%
500μs-1ms   ██ 2%
     >1ms   █ 1%
```

---

## Comparison with Alternatives

### vs. {{ALTERNATIVE_1}}

| Metric | {{PROJECT_NAME}} | {{ALTERNATIVE_1}} | Difference |
|--------|------------------|-------------------|------------|
| {{CMP_METRIC_1}} | {{CMP_OURS_1}} | {{CMP_ALT_1}} | {{CMP_DIFF_1}} |
| {{CMP_METRIC_2}} | {{CMP_OURS_2}} | {{CMP_ALT_2}} | {{CMP_DIFF_2}} |
| {{CMP_METRIC_3}} | {{CMP_OURS_3}} | {{CMP_ALT_3}} | {{CMP_DIFF_3}} |

**Notes:** {{COMPARISON_NOTES}}

---

## Historical Trends

### Throughput Over Versions

| Version | {{METRIC_1}} | Change |
|---------|--------------|--------|
| v1.0.0 | {{V1_METRIC_1}} | baseline |
| v1.1.0 | {{V11_METRIC_1}} | {{V11_CHANGE}} |
| v1.2.0 | {{V12_METRIC_1}} | {{V12_CHANGE}} |
| v2.0.0 | {{V2_METRIC_1}} | {{V2_CHANGE}} |

### Latency Over Versions

| Version | p50 | p99 | Change |
|---------|-----|-----|--------|
| v1.0.0 | {{V1_P50}} | {{V1_P99}} | baseline |
| v2.0.0 | {{V2_P50}} | {{V2_P99}} | {{LATENCY_CHANGE}} |

---

## Methodology

### Benchmark Execution

```bash
# Build benchmarks
cmake -B build-bench -DCMAKE_BUILD_TYPE=Release -DBUILD_BENCHMARKS=ON
cmake --build build-bench

# Run benchmarks
./build-bench/benchmarks/{{PROJECT_NAME}}_bench \
    --benchmark_repetitions=10 \
    --benchmark_report_aggregates_only=true \
    --benchmark_out=results.json \
    --benchmark_out_format=json
```

### Warm-up

- 5 warm-up iterations before measurement
- System stabilization period: 10 seconds

### Statistical Analysis

- 10 repetitions per benchmark
- Report: mean, median, stddev, min, max
- Outlier detection: 3-sigma rule

### Reproducibility

To reproduce these results:

1. Use the same hardware configuration
2. Disable CPU frequency scaling: `cpupower frequency-set --governor performance`
3. Minimize background processes
4. Run benchmarks multiple times

---

## Performance Regression Detection

CI automatically detects performance regressions:

- **Threshold:** >5% degradation triggers warning
- **Threshold:** >10% degradation fails build
- **Comparison:** Against previous release baseline

---

## Related Documents

- [Performance Optimization Guide](../advanced/PERFORMANCE.md)
- [Benchmarks Details](BENCHMARKS.md)
- [Profiling Guide](PROFILING.md)
