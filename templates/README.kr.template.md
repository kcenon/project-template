[![CI](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml)
[![Code Coverage](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/coverage.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/coverage.yml)
[![Static Analysis](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/static-analysis.yml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/static-analysis.yml)
[![Documentation](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/build-Doxygen.yaml/badge.svg)](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/actions/workflows/build-Doxygen.yaml)
[![License](https://img.shields.io/github/license/{{GITHUB_USER}}/{{PROJECT_NAME}})](https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}/blob/main/LICENSE)

# {{PROJECT_TITLE}}

> **Language:** [English](README.md) | **한국어**

## 개요

{{PROJECT_DESCRIPTION_KO}}

**핵심 가치**:
- 🚀 **{{FEATURE_1_KO}}**: {{FEATURE_1_DESC_KO}}
- 🔒 **{{FEATURE_2_KO}}**: {{FEATURE_2_DESC_KO}}
- 🏗️ **{{FEATURE_3_KO}}**: {{FEATURE_3_DESC_KO}}
- 🛡️ **{{FEATURE_4_KO}}**: {{FEATURE_4_DESC_KO}}
- 🌐 **{{FEATURE_5_KO}}**: {{FEATURE_5_DESC_KO}}

**최근 업데이트** ({{YEAR}}-{{MONTH}}):
- ✅ {{UPDATE_1_KO}}
- ✅ {{UPDATE_2_KO}}
- ✅ {{UPDATE_3_KO}}

---

## 빠른 시작

### 기본 예제

```cpp
#include <kcenon/{{PROJECT_NAME}}/core/{{MAIN_HEADER}}.h>

using namespace kcenon::{{NAMESPACE}};

int main() {
    // {{EXAMPLE_COMMENT_KO}}
    {{EXAMPLE_CODE}}

    return 0;
}
```

📖 **[전체 시작 가이드 →](docs/guides/QUICK_START_KO.md)**

---

## 요구사항

| 의존성 | 버전 | 필수 | 설명 |
|--------|------|------|------|
| C++20 컴파일러 | GCC 11+ / Clang 14+ / MSVC 2022+ / Apple Clang 14+ | 예 | C++20 기능 필요 |
| CMake | 3.20+ | 예 | 빌드 시스템 |
| [common_system](https://github.com/kcenon/common_system) | latest | 예 | 공통 인터페이스 및 Result<T> |
{{ADDITIONAL_DEPENDENCIES_KO}}

### 의존성 구조

```
{{PROJECT_NAME}}
├── common_system (필수)
{{DEPENDENCY_TREE_KO}}
```

---

## 설치

### 옵션 1: CMake 통합 (권장)

```bash
# 의존성 클론
git clone https://github.com/kcenon/common_system.git
{{CLONE_COMMANDS}}
git clone https://github.com/{{GITHUB_USER}}/{{PROJECT_NAME}}.git

# 빌드
cd {{PROJECT_NAME}}
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### 옵션 2: vcpkg (가능한 경우)

```bash
vcpkg install kcenon-{{PROJECT_NAME}}
```

### 프로젝트에서 사용하기

```cmake
find_package({{CMAKE_PACKAGE_NAME}} REQUIRED)
target_link_libraries(your_app PRIVATE {{CMAKE_TARGET_NAME}})
```

---

## 아키텍처

### 에코시스템 통합

깔끔한 인터페이스 경계를 가진 모듈형 C++ 에코시스템의 일부:

```
                    ┌──────────────────┐
                    │  common_system   │  기반 레이어
                    │   (인터페이스)    │
                    └────────┬─────────┘
                             │
       ┌─────────────────────┼─────────────────────┐
       │                     │                     │
┌──────▼───────┐    ┌────────▼────────┐   ┌───────▼────────┐
│thread_system │    │ {{PROJECT_NAME}}│   │ other_system   │
└──────────────┘    └─────────────────┘   └────────────────┘
```

**통합 장점**:
- 인터페이스 전용 의존성
- 독립적 컴파일
- 런타임 의존성 주입
- 깔끔한 관심사 분리

📖 **[전체 아키텍처 가이드 →](docs/advanced/ARCHITECTURE_KO.md)**

---

## 핵심 기능

### {{CORE_FEATURE_1_TITLE_KO}}

{{CORE_FEATURE_1_DESC_KO}}

```cpp
{{CORE_FEATURE_1_EXAMPLE}}
```

### {{CORE_FEATURE_2_TITLE_KO}}

{{CORE_FEATURE_2_DESC_KO}}

```cpp
{{CORE_FEATURE_2_EXAMPLE}}
```

📖 **[상세 기능 문서 →](docs/FEATURES_KO.md)**

---

## 문서

| 카테고리 | 문서 | 설명 |
|----------|------|------|
| **가이드** | [빠른 시작](docs/guides/QUICK_START_KO.md) | 시작 튜토리얼 |
| | [모범 사례](docs/guides/BEST_PRACTICES_KO.md) | 권장 패턴 |
| | [FAQ](docs/guides/FAQ_KO.md) | 자주 묻는 질문 |
| | [문제 해결](docs/guides/TROUBLESHOOTING_KO.md) | 일반적인 문제와 해결책 |
| **고급** | [아키텍처](docs/advanced/ARCHITECTURE_KO.md) | 시스템 설계 및 내부 구조 |
| | [성능](docs/advanced/PERFORMANCE_KO.md) | 최적화 기법 |
| | [마이그레이션](docs/advanced/MIGRATION_KO.md) | 버전 업그레이드 가이드 |
| **기여** | [기여 가이드](docs/contributing/CONTRIBUTING_KO.md) | 기여 방법 |
| | [테스팅](docs/contributing/TESTING_KO.md) | 테스트 가이드라인 |
| | [CI/CD](docs/contributing/CI_CD_KO.md) | 파이프라인 문서 |

---

## 성능

| 지표 | 값 | 비고 |
|------|-----|------|
| {{PERF_METRIC_1_KO}} | {{PERF_VALUE_1}} | {{PERF_NOTE_1_KO}} |
| {{PERF_METRIC_2_KO}} | {{PERF_VALUE_2}} | {{PERF_NOTE_2_KO}} |
| {{PERF_METRIC_3_KO}} | {{PERF_VALUE_3}} | {{PERF_NOTE_3_KO}} |

📖 **[성능 베이스라인 →](docs/performance/BASELINE_KO.md)** | **[벤치마크 →](docs/performance/BENCHMARKS_KO.md)**

---

## 기여하기

기여를 환영합니다! 자세한 내용은 [기여 가이드](docs/contributing/CONTRIBUTING_KO.md)를 참조해 주세요.

### 빠른 링크

- [행동 강령](CODE_OF_CONDUCT.md)
- [개발 환경 설정](docs/contributing/CONTRIBUTING_KO.md#개발-환경-설정)
- [풀 리퀘스트 프로세스](docs/contributing/CONTRIBUTING_KO.md#풀-리퀘스트-프로세스)

---

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다 - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

## 감사의 글

{{ACKNOWLEDGMENTS_KO}}
