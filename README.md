# AI Engineering Kit

**A reusable, production-quality foundation for AI-first software projects.**

This repository standardises planning, architecture, coding, documentation, prompt engineering, testing, debugging, deployment, security, and Git workflow across every project you build. It is language-agnostic, framework-agnostic, and designed to be consumed by both humans and AI agents.

## Why This Exists

Every new project should not start from zero. This kit encodes battle-tested patterns, prompts, and standards into a single, versioned foundation. Whether you are building a microservice, a CLI tool, or a full-stack application, this kit gives you:

- **Consistency** — Every project follows the same conventions.
- **Speed** — Scaffold a new project in seconds.
- **Quality** — Automated gates for linting, testing, and security.
- **AI-readiness** — Pre-vetted prompts and agent configurations so AI tools produce reliable, predictable output from day one.

## Quick Start

```bash
# 1. Clone the kit
git clone https://github.com/<your-org>/ai-engineering-kit.git
cd ai-engineering-kit

# 2. Scaffold a new project
./scripts/init-project.sh

# 3. Run the generated project
cd my-project
make run
```

See [QUICKSTART.md](QUICKSTART.md) for a detailed walkthrough.

## Repository Structure

| Path | Purpose |
|---|---|
| `.github/` | CI/CD workflows, issue and PR templates |
| `.gitlab/` | GitLab Duo / Fable review workflows (GitLab mirror) |
| `.opencode/` | AI agent personas, skills, and rules |
| `docs/` | Architecture decisions, planning templates, deployment checklists |
| `knowledge/` | Curated engineering reference material |
| `memory/` | Long-term project context and session history |
| `prompts/` | Vetted prompts for planning, coding, review, testing, debugging, deployment, research |
| `standards/` | Conventions for coding, Git, architecture, testing, security, documentation |
| `templates/` | Project skeletons (generic, Python, TypeScript) |
| `scripts/` | Automation for init, lint, test, clean |
| `examples/` | Reference implementations showing standards end-to-end |

## How to Use This Kit

1. **Scaffold a project** — Run `./scripts/init-project.sh` and follow the prompts.
2. **Read `AGENTS.md`** — It defines how AI agents interact with this kit and any project scaffolded from it.
3. **Read `SPECIFICATION.md`** — It documents the full design intent of this repository.
4. **Use the prompts** — When working with an AI agent, pass the relevant prompt from `prompts/` as context.
5. **Follow the standards** — Each standard in `standards/` is a rule, not a suggestion.

## License

MIT — See [LICENSE](LICENSE) for details.
