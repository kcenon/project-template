# Contributing Guide

> **Language:** **English** | [한국어](CONTRIBUTING_KO.md)

Thank you for your interest in contributing to sample_system!

## Getting Started

### Types of Contributions

We welcome:

- **Bug reports**: Found a bug? [Open an issue](https://github.com/kcenon/sample_system/issues/new?template=bug_report.md)
- **Feature requests**: Have an idea? [Open an issue](https://github.com/kcenon/sample_system/issues/new?template=feature_request.md)
- **Code contributions**: Fix bugs, add features, improve documentation
- **Documentation**: Improve guides, fix typos, add examples

### Development Setup

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/sample_system.git
cd sample_system

# Add upstream
git remote add upstream https://github.com/kcenon/sample_system.git

# Clone dependencies
git clone https://github.com/kcenon/common_system.git ../common_system
git clone https://github.com/kcenon/thread_system.git ../thread_system

# Build
cmake -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON
cmake --build build

# Test
ctest --test-dir build --output-on-failure
```

## Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```
feat(core): add retry mechanism with exponential backoff
fix(manager): resolve memory leak on shutdown
docs(readme): update installation instructions
```

## Pull Request Process

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make changes and commit following the conventions
3. Push and open a PR
4. Address review feedback
5. Merge after approval

## Coding Standards

- Follow existing code style
- Use meaningful variable/function names
- Add tests for new functionality
- Update documentation as needed

Thank you for contributing!
