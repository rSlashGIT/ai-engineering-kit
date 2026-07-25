# AI Engineering Kit — Specification

## Purpose

The AI Engineering Kit is a reusable, production-quality, open-source foundation for AI-first software projects. It standardises the full software development lifecycle — from planning through deployment — in a language-agnostic, framework-agnostic way. The kit is designed to be consumed by both human engineers and AI agents, ensuring consistency, speed, and quality across every project.

## Design Goals

| Goal | Description |
|---|---|
| **Reusable** | Every component (templates, prompts, standards) can be imported or referenced by new projects. |
| **Production-quality** | All standards and templates enforce industry best practices for security, testing, and maintainability. |
| **Open source** | MIT-licensed. Community contributions welcome. |
| **AI-first** | The repository is designed with AI agents as first-class consumers. Agent protocols, pre-vetted prompts, and automated quality gates are core features. |
| **Language-agnostic** | The core structure, prompts, and standards work for Python, TypeScript, Rust, Go, or any language. Language-specific guides sit alongside the generic ones. |
| **Framework-agnostic** | No hard dependency on any web framework, build tool, or runtime. Each project template may include framework defaults, but the kit itself does not mandate them. |

## Scope

The kit standardises these ten pillars:

1. **Planning** — Blueprint templates, spec templates, and architect prompts.
2. **Architecture** — Architecture Decision Record (ADR) templates and architecture standards.
3. **Coding standards** — Language-specific style guides and general best practices.
4. **Documentation** — Rules for what, when, and how to document.
5. **Prompt engineering** — A library of vetted prompts for every stage of the SDLC.
6. **Testing** — Standards for unit, integration, and end-to-end testing.
7. **Debugging** — A systematic debugging workflow and corresponding prompts.
8. **Deployment** — Checklists, CI/CD workflow templates, and deployment prompts.
9. **Security** — Review checklists and secure coding standards.
10. **Git workflow** — Branching strategy, commit conventions, and PR templates.

## Repository Architecture

The kit follows a layered design:

```
Standards Layer       — What is required (rules, conventions)
Prompts Layer         — How to instruct AI to produce compliant output
Knowledge Layer       — Engineering reference material
Memory Layer          — Long-term project context and session history
Templates Layer       — Reusable starting points for new projects
Docs Layer            — Supporting reference material and checklists
Examples Layer        — Concrete demonstrations of the above
```

Each layer is independent. A project may use the standards without the prompts, or the templates without the standards.

## Key Directories

| Directory | Purpose |
|---|---|
| `.github/` | GitHub CI/CD workflows, issue/PR templates |
| `gitlab/` | GitLab Duo / Fable review workflows (GitLab mirror) |
| `.opencode/` | OpenCode agent definitions, skills, and rules |
| `docs/` | ADR templates, planning templates, checklists |
| `knowledge/` | Curated engineering reference material |
| `memory/` | Long-term project context and session history |
| `prompts/` | Vetted prompts across 7 categories |
| `standards/` | Rules across 6 categories |
| `templates/` | Project skeletons |
| `scripts/` | Automation scripts |
| `examples/` | Reference implementations |

## Key Files

| File | Purpose |
|---|---|
| `AGENTS.md` | Agent protocol — the contract between AI agents and this kit. |
| `README.md` | Entry point for humans. |
| `SPECIFICATION.md` | This file — design intent and scope. |
| `LICENSE` | MIT license. |
| `.editorconfig` | Editor-agnostic formatting settings. |
| `.gitattributes` | Git attribute rules for diff and line endings. |
| `.gitignore` | Language-agnostic ignore patterns. |

## Versioning

This repository follows [Semantic Versioning](https://semver.org/) from the first stable release. The current version is `0.1.0` (pre-release).
