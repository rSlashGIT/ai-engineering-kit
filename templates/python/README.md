# __PROJECT_NAME__

Production-ready Python project scaffolded from the [AI Engineering Kit](https://github.com/your-org/ai-engineering-kit).

## Quick Start

```bash
# Create virtual environment
python -m venv .venv && .venv\Scripts\activate  # Windows
python -m venv .venv && source .venv/bin/activate  # macOS / Linux

# Install with dev dependencies
pip install -e ".[dev]"

# Run tests
make test

# Lint and format
make lint
make format
```

## Project Structure

```
src/          # Application source code
tests/        # Unit tests (pytest)
```

## Tooling

| Tool     | Purpose                |
|----------|------------------------|
| Ruff     | Linter + formatter     |
| MyPy     | Static type checking   |
| Pytest   | Test runner            |
| Pre-commit | Git hook automation  |

## Commands

- `make test` — run all tests
- `make lint` — ruff check + mypy
- `make format` — auto-format with ruff
- `make clean` — remove caches and build artifacts
- `make all` — format → lint → test (CI pipeline)
