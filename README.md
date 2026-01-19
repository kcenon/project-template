# Project Template

> **Language:** **English** | [한국어](README_KO.md)

A standardized documentation template repository for the kcenon C++ ecosystem projects.

## Purpose

This repository provides:

- **Consistent Documentation**: Unified README and docs structure across all projects
- **Quick Project Setup**: GitHub Template Repository for instant new project scaffolding
- **Maintainability**: Single source of truth for documentation standards

## Quick Start

### Option 1: Use as GitHub Template (New Projects)

1. Click **"Use this template"** button on GitHub
2. Create your new repository
3. Run the initialization script:
   ```bash
   ./scripts/init-project.sh your-project-name
   ```

### Option 2: Apply to Existing Project

```bash
# Clone this template repository
git clone https://github.com/kcenon/project-template.git

# Run the apply script
cd project-template
./scripts/apply-template.sh /path/to/your/existing-project
```

## Repository Structure

```
project-template/
├── README.md                    # This file (usage guide)
├── README_KO.md                 # Korean usage guide
│
├── templates/                   # Document templates
│   ├── README.template.md       # Main README template
│   ├── README_KO.template.md    # Korean README template
│   └── CHANGELOG.template.md    # Changelog template
│
├── docs-structure/              # Standard docs/ structure
│   ├── guides/                  # User guides
│   │   ├── QUICK_START.template.md
│   │   ├── BEST_PRACTICES.template.md
│   │   ├── FAQ.template.md
│   │   └── TROUBLESHOOTING.template.md
│   ├── advanced/                # Advanced topics
│   │   ├── ARCHITECTURE.template.md
│   │   ├── PERFORMANCE.template.md
│   │   ├── MIGRATION.template.md
│   │   └── STRUCTURE.template.md
│   ├── adr/                     # Architecture Decision Records
│   │   └── ADR-000-template.md
│   ├── contributing/            # Contribution guides
│   │   ├── CONTRIBUTING.template.md
│   │   ├── TESTING.template.md
│   │   └── CI_CD.template.md
│   ├── performance/             # Performance documentation
│   │   ├── BASELINE.template.md
│   │   └── BENCHMARKS.template.md
│   └── integration/             # Integration guides
│       └── WITH_SYSTEM.template.md
│
├── .github/                     # GitHub templates
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── config.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/               # Reusable CI/CD workflows
│       ├── ci.yml
│       ├── docs.yml
│       └── release.yml
│
├── scripts/                     # Utility scripts
│   ├── init-project.sh          # Initialize new project
│   ├── apply-template.sh        # Apply to existing project
│   └── validate-docs.sh         # Validate documentation structure
│
└── examples/                    # Complete examples
    └── sample-project/          # Fully configured sample
```

## Template Variables

Templates use `{{VARIABLE_NAME}}` syntax for substitution:

| Variable | Description | Example |
|----------|-------------|---------|
| `{{PROJECT_NAME}}` | Project name | `thread_system` |
| `{{PROJECT_TITLE}}` | Display title | `Thread System` |
| `{{PROJECT_DESCRIPTION}}` | Short description | `A modern C++20 multithreading framework` |
| `{{GITHUB_USER}}` | GitHub username/org | `kcenon` |
| `{{YEAR}}` | Current year | `2026` |
| `{{MONTH}}` | Current month | `01` |

### Feature Variables

| Variable | Description |
|----------|-------------|
| `{{FEATURE_1}}` ~ `{{FEATURE_5}}` | Key feature names |
| `{{FEATURE_1_DESC}}` ~ `{{FEATURE_5_DESC}}` | Feature descriptions |

### Dependency Variables

| Variable | Description |
|----------|-------------|
| `{{DEP_1_NAME}}` ~ `{{DEP_N_NAME}}` | Dependency names |
| `{{DEP_1_VERSION}}` | Dependency versions |
| `{{DEP_1_REQUIRED}}` | Yes/Optional |

## Documentation Standards

### README Section Order

1. **CI Badges** - Status indicators
2. **Title & Language Toggle** - Project name with language switch
3. **Overview** - Description + Key Value Propositions + Latest Updates
4. **Quick Start** - Basic example + link to full guide
5. **Requirements** - Dependency table + flow diagram
6. **Installation** - Build instructions
7. **Architecture** - Ecosystem integration
8. **Documentation** - Links table
9. **Performance** - Metrics summary (if applicable)
10. **Contributing** - Contribution link
11. **License** - License info

### Standard Emoji Set

| Emoji | Meaning | Usage |
|-------|---------|-------|
| 🚀 | Performance | High-speed, fast, efficient |
| 🔒 | Thread Safety | Thread-safe, secure, safe |
| 🏗️ | Architecture | Modular, structural, design |
| 🛡️ | Production Grade | Tested, reliable, stable |
| 🌐 | Cross-Platform | Multi-platform, universal |

### docs/ Directory Standard

```
docs/
├── guides/           # Getting started, best practices
├── advanced/         # Architecture, performance, migration
├── adr/              # Architecture Decision Records
├── contributing/     # How to contribute, testing
├── performance/      # Baselines, benchmarks
├── integration/      # Cross-project integration
└── archive/          # Deprecated documentation
    └── YYYY-MM/      # Versioned archives
```

## Validation

Run the validation script to check documentation compliance:

```bash
./scripts/validate-docs.sh /path/to/project
```

This checks:
- Required files exist
- Section order in README
- Template variable substitution
- Broken internal links

## Migration Checklist

When migrating an existing project:

- [ ] Backup existing documentation
- [ ] Run `apply-template.sh`
- [ ] Fill in template variables
- [ ] Review and merge custom content
- [ ] Run `validate-docs.sh`
- [ ] Update any project-specific sections

## Contributing

To improve these templates:

1. Fork this repository
2. Make changes to templates
3. Test with `validate-docs.sh`
4. Submit a Pull Request

## Related Projects

This template is designed for the kcenon C++ ecosystem:

- [common_system](https://github.com/kcenon/common_system) - Foundation layer
- [thread_system](https://github.com/kcenon/thread_system) - Threading framework
- [logger_system](https://github.com/kcenon/logger_system) - Logging framework
- [container_system](https://github.com/kcenon/container_system) - Data containers
- [monitoring_system](https://github.com/kcenon/monitoring_system) - Observability
- [database_system](https://github.com/kcenon/database_system) - Database abstraction
- [network_system](https://github.com/kcenon/network_system) - Networking library

## License

MIT License - see [LICENSE](LICENSE) for details.
