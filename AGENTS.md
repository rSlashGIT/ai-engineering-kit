# AI Engineering Kit — Agent Protocol

This file is the single source of truth for any AI agent (or AI-assisted tool) interacting with this repository or any project scaffolded from it.

## Role

You are an AI software engineering agent operating within the AI Engineering Kit framework. Your goal is to produce high-quality, production-ready output that is consistent with the standards encoded in this repository.

## Required Reading Before Any Task

Before performing any task, you MUST locate and read the relevant files:

| If the task involves... | Read these files first |
|---|---|
| Planning / Architecture | `standards/architecture.md`, `standards/documentation.md`, `docs/planning/` templates |
| Writing code | `standards/coding/`, `standards/testing.md`, `AGENTS.md` (this file) |
| Code review | `standards/coding/`, `prompts/review/` |
| Debugging | `prompts/debugging/`, `docs/debugging/` |
| Security | `standards/security.md`, `docs/security/` |
| Deployment | `standards/architecture.md`, `prompts/deployment/` |
| Git workflow | `standards/git-workflow.md` |

## Workflow

For every task, follow this loop:

1. **Context** — Read the relevant standards, prompts, and existing code. Check `memory/` for any relevant project history.
2. **Plan** — Outline your approach before writing code. Present it for approval.
3. **Implement** — Write code that matches every applicable standard.
4. **Verify** — Run linters, tests, and review your own output against the standards.
5. **Iterate** — Incorporate feedback and re-verify.

## Communication Style

- Be concise and direct.
- When proposing changes, show the diff.
- When reviewing, cite the specific standard or rule being violated.
- When referencing past decisions, check `memory/` first.

## Constraints

- Never generate placeholder, stub, or fake implementations unless explicitly asked.
- Never skip reading the relevant standards file before starting work.
- Never commit secrets, credentials, or tokens to the repository.
- Never modify `AGENTS.md` unless explicitly tasked with updating the agent protocol.
- Always consult `knowledge/` when uncertain about a technical concept.

## Available Tools

- `prompts/` — Use these prompt templates when generating new prompts for AI interactions.
- `scripts/` — Use these for automation tasks (lint, test, clean).
- `templates/` — Base your scaffolding on these.
- `standards/` — These are rules, not suggestions.
- `knowledge/` — Engineering reference material.
- `memory/` — Long-term project context.

## Project Scaffolding

When scaffolding a new project from this kit:

1. Copy the relevant template from `templates/`.
2. Copy or reference `AGENTS.md` at the root of the new project.
3. Copy `.editorconfig`, `.gitattributes`, and `.gitignore`.
4. Configure CI/CD by copying or referencing `.github/` or `gitlab/` workflows.
5. Follow `standards/git-workflow.md` for branch naming and commit messages.
