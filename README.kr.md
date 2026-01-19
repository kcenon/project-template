# Project Template

> **Language:** [English](README.md) | **한국어**

kcenon C++ 생태계 프로젝트를 위한 표준화된 문서 템플릿 저장소입니다.

## 목적

이 저장소는 다음을 제공합니다:

- **일관된 문서화**: 모든 프로젝트에 걸쳐 통일된 README 및 docs 구조
- **빠른 프로젝트 설정**: 즉시 새 프로젝트 스캐폴딩을 위한 GitHub 템플릿 저장소
- **유지보수성**: 문서 표준에 대한 단일 진실 공급원

## 빠른 시작

### 옵션 1: GitHub 템플릿으로 사용 (새 프로젝트)

1. GitHub에서 **"Use this template"** 버튼 클릭
2. 새 저장소 생성
3. 초기화 스크립트 실행:
   ```bash
   ./scripts/init-project.sh your-project-name
   ```

### 옵션 2: 기존 프로젝트에 적용

```bash
# 이 템플릿 저장소 클론
git clone https://github.com/kcenon/project-template.git

# 적용 스크립트 실행
cd project-template
./scripts/apply-template.sh /path/to/your/existing-project
```

## 저장소 구조

```
project-template/
├── README.md                    # 이 파일 (사용 가이드)
├── README.kr.md                 # 한국어 사용 가이드
│
├── templates/                   # 문서 템플릿
│   ├── README.template.md       # 메인 README 템플릿
│   ├── README.kr.template.md    # 한국어 README 템플릿
│   └── CHANGELOG.template.md    # 변경 로그 템플릿
│
├── docs-structure/              # 표준 docs/ 구조
│   ├── guides/                  # 사용자 가이드
│   │   ├── QUICK_START.template.md
│   │   ├── BEST_PRACTICES.template.md
│   │   ├── FAQ.template.md
│   │   └── TROUBLESHOOTING.template.md
│   ├── advanced/                # 고급 주제
│   │   ├── ARCHITECTURE.template.md
│   │   ├── PERFORMANCE.template.md
│   │   ├── MIGRATION.template.md
│   │   └── STRUCTURE.template.md
│   ├── adr/                     # 아키텍처 결정 기록
│   │   └── ADR-000-template.md
│   ├── contributing/            # 기여 가이드
│   │   ├── CONTRIBUTING.template.md
│   │   ├── TESTING.template.md
│   │   └── CI_CD.template.md
│   ├── performance/             # 성능 문서
│   │   ├── BASELINE.template.md
│   │   └── BENCHMARKS.template.md
│   └── integration/             # 통합 가이드
│       └── WITH_SYSTEM.template.md
│
├── .github/                     # GitHub 템플릿
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── config.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/               # 재사용 가능한 CI/CD 워크플로우
│       ├── ci.yml
│       ├── docs.yml
│       └── release.yml
│
├── scripts/                     # 유틸리티 스크립트
│   ├── init-project.sh          # 새 프로젝트 초기화
│   ├── apply-template.sh        # 기존 프로젝트에 적용
│   └── validate-docs.sh         # 문서 구조 검증
│
└── examples/                    # 완전한 예제
    └── sample-project/          # 완전히 구성된 샘플
```

## 템플릿 변수

템플릿은 치환을 위해 `{{VARIABLE_NAME}}` 구문을 사용합니다:

| 변수 | 설명 | 예시 |
|------|------|------|
| `{{PROJECT_NAME}}` | 프로젝트 이름 | `thread_system` |
| `{{PROJECT_TITLE}}` | 표시 제목 | `Thread System` |
| `{{PROJECT_DESCRIPTION}}` | 짧은 설명 | `A modern C++20 multithreading framework` |
| `{{GITHUB_USER}}` | GitHub 사용자명/조직 | `kcenon` |
| `{{YEAR}}` | 현재 연도 | `2026` |
| `{{MONTH}}` | 현재 월 | `01` |

### 기능 변수

| 변수 | 설명 |
|------|------|
| `{{FEATURE_1}}` ~ `{{FEATURE_5}}` | 주요 기능 이름 |
| `{{FEATURE_1_DESC}}` ~ `{{FEATURE_5_DESC}}` | 기능 설명 |

### 의존성 변수

| 변수 | 설명 |
|------|------|
| `{{DEP_1_NAME}}` ~ `{{DEP_N_NAME}}` | 의존성 이름 |
| `{{DEP_1_VERSION}}` | 의존성 버전 |
| `{{DEP_1_REQUIRED}}` | Yes/Optional |

## 문서화 표준

### README 섹션 순서

1. **CI 배지** - 상태 표시기
2. **제목 & 언어 토글** - 언어 전환이 있는 프로젝트 이름
3. **개요** - 설명 + 핵심 가치 제안 + 최신 업데이트
4. **빠른 시작** - 기본 예제 + 전체 가이드 링크
5. **요구사항** - 의존성 테이블 + 플로우 다이어그램
6. **설치** - 빌드 지침
7. **아키텍처** - 생태계 통합
8. **문서** - 링크 테이블
9. **성능** - 메트릭 요약 (해당하는 경우)
10. **기여** - 기여 링크
11. **라이선스** - 라이선스 정보

### 표준 이모지 세트

| 이모지 | 의미 | 사용 |
|--------|------|------|
| 🚀 | 성능 | 고속, 빠름, 효율적 |
| 🔒 | 스레드 안전성 | 스레드 세이프, 보안, 안전 |
| 🏗️ | 아키텍처 | 모듈식, 구조적, 설계 |
| 🛡️ | 프로덕션 등급 | 테스트됨, 신뢰성, 안정성 |
| 🌐 | 크로스 플랫폼 | 멀티 플랫폼, 범용 |

### 로컬라이제이션 파일 명명 규칙

한국어 번역에는 `_KO.md` 대신 `.kr.md` 접미사를 사용합니다:

| 패턴 | 예시 | 설명 |
|------|------|------|
| `*.kr.md` | `README.kr.md` | `README.md`의 한국어 번역 |
| `*.kr.md` | `QUICK_START.kr.md` | `QUICK_START.md`의 한국어 번역 |

**이유**:
- **일관성**: 일반적인 로컬라이제이션 패턴을 따름 (예: `.en.md`, `.ja.md`)
- **명확성**: 파일명과 언어 접미사 사이의 명확한 분리
- **정렬**: 파일이 알파벳순으로 함께 정렬됨 (`README.kr.md`가 `README.md` 근처에)

**마이그레이션**: 프로젝트에서 `_KO.md` 접미사를 사용하는 경우 파일 이름 변경:
```bash
# 모든 _KO.md 파일을 .kr.md로 이름 변경
find ./docs -name "*_KO.md" | while read f; do
  mv "$f" "${f/_KO.md/.kr.md}"
done

# 모든 참조 업데이트
find . -name "*.md" -exec sed -i '' 's/_KO\.md/.kr.md/g' {} \;
```

### docs/ 디렉토리 표준

```
docs/
├── guides/           # 시작하기, 모범 사례
├── advanced/         # 아키텍처, 성능, 마이그레이션
├── adr/              # 아키텍처 결정 기록
├── contributing/     # 기여 방법, 테스트
├── performance/      # 기준선, 벤치마크
├── integration/      # 크로스 프로젝트 통합
└── archive/          # 폐기된 문서
    └── YYYY-MM/      # 버전별 아카이브
```

## 검증

문서 준수 여부를 확인하려면 검증 스크립트를 실행하세요:

```bash
./scripts/validate-docs.sh /path/to/project
```

확인 항목:
- 필수 파일 존재 여부
- README의 섹션 순서
- 템플릿 변수 치환
- 깨진 내부 링크

## 마이그레이션 체크리스트

기존 프로젝트를 마이그레이션할 때:

- [ ] 기존 문서 백업
- [ ] `apply-template.sh` 실행
- [ ] 템플릿 변수 채우기
- [ ] 커스텀 콘텐츠 검토 및 병합
- [ ] `validate-docs.sh` 실행
- [ ] 프로젝트별 섹션 업데이트

## 기여

이 템플릿을 개선하려면:

1. 이 저장소 포크
2. 템플릿 변경
3. `validate-docs.sh`로 테스트
4. Pull Request 제출

## 관련 프로젝트

이 템플릿은 kcenon C++ 생태계를 위해 설계되었습니다:

- [common_system](https://github.com/kcenon/common_system) - 기반 레이어
- [thread_system](https://github.com/kcenon/thread_system) - 스레딩 프레임워크
- [logger_system](https://github.com/kcenon/logger_system) - 로깅 프레임워크
- [container_system](https://github.com/kcenon/container_system) - 데이터 컨테이너
- [monitoring_system](https://github.com/kcenon/monitoring_system) - 관측성
- [database_system](https://github.com/kcenon/database_system) - 데이터베이스 추상화
- [network_system](https://github.com/kcenon/network_system) - 네트워킹 라이브러리

## 라이선스

MIT License - 자세한 내용은 [LICENSE](LICENSE)를 참조하세요.
