# Quick Start

Scaffold your first project in under 60 seconds.

## Prerequisites

- **Python 3** — to run the generated project (install from [python.org](https://python.org))
- **Git** — to initialise the repository (install from [git-scm.com](https://git-scm.com))
- **Bash or PowerShell 5.1+** — to run the scaffold script (Bash on macOS/Linux/WSL/Git Bash; PowerShell on Windows)

## 1. Clone the Kit

```bash
git clone https://github.com/<your-org>/ai-engineering-kit.git
cd ai-engineering-kit
```

## 2. Scaffold a Project

**macOS / Linux / WSL:**
```bash
./scripts/init-project.sh
```

**Windows (PowerShell):**
```powershell
.\scripts\init-project.ps1
```

The script will ask you:

| Prompt | Example |
|---|---|
| Project name | `my-service` |
| Description | `A user management microservice` |
| Target directory | `./my-service` (or press Enter to accept the default) |
| Initialise Git? | `Y` (press Enter for yes) |

## 3. Run the Project

```bash
cd my-service
make run
```

Expected output:

```
Hello from my-service!
```

## 4. Run the Tests

```bash
make test
```

Expected output:

```
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK
```

## 5. Explore the Structure

```
my-service/
├── src/
│   └── main.py          # entry point
├── tests/
│   └── test_main.py     # test suite
├── docs/
│   └── index.md         # project documentation
├── AGENTS.md            # AI agent protocol
├── Makefile             # run, test, lint, clean, build
├── Dockerfile           # container image
├── .editorconfig        # editor settings
├── .gitignore
└── .gitattributes
```

## 6. Next Steps

- Open `src/main.py` and start building your feature.
- Open `AGENTS.md` and give it to any AI agent you work with.
- Read the [standards](standards/) relevant to your project.
- Use the [prompts](prompts/) when working with AI agents.

## Troubleshooting

| Problem | Fix |
|---|---|
| `./scripts/init-project.sh: Permission denied` | Run `chmod +x scripts/init-project.sh` |
| `.\scripts\init-project.ps1` is blocked by execution policy | Run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` in an Admin PowerShell |
| `make: command not found` | Install make (on Windows: `choco install make`, on macOS: `xcode-select --install`) |
| `python: command not found` | Use `python3` instead, or install Python |
