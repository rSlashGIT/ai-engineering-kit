#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────
# AI Engineering Kit — Project Scaffold Script
# ──────────────────────────────────────────────

KIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$KIT_DIR/templates/generic"

YEAR=$(date +%Y)

print_banner() {
    echo ""
    echo "  ╔══════════════════════════════════════╗"
    echo "  ║   AI Engineering Kit — Scaffold     ║"
    echo "  ╚══════════════════════════════════════╝"
    echo ""
}

die() {
    echo "Error: $1" >&2
    exit 1
}

prompt_required() {
    local prompt="$1"
    local var_name="$2"
    local default="${3:-}"
    local value=""
    while [ -z "$value" ]; do
        if [ -n "$default" ]; then
            read -r -p "$prompt [$default]: " value
            value="${value:-$default}"
        else
            read -r -p "$prompt: " value
        fi
        if [ -z "$value" ]; then
            echo "This field is required." >&2
        fi
    done
    eval "$var_name=\"$value\""
}

check_dependencies() {
    if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
        echo "Warning: Python not found. Install Python to run the generated project." >&2
    fi
    if ! command -v git &>/dev/null; then
        echo "Warning: git not found. Install Git to initialise the repository." >&2
    fi
}

validate_project_name() {
    local name="$1"
    if echo "$name" | grep -qE '[^a-zA-Z0-9._-]'; then
        die "Project name contains invalid characters. Use letters, numbers, hyphens, underscores, and dots only."
    fi
    if [ "${#name}" -lt 2 ]; then
        die "Project name must be at least 2 characters."
    fi
}

slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr -s ' _' '-' | sed 's/[^a-z0-9.-]//g'
}

copy_template() {
    local src="$1"
    local dst="$2"
    local slug="$3"
    local name="$4"
    local desc="$5"

    echo "Copying template..."
    if [ -d "$dst" ]; then
        die "Directory '$dst' already exists."
    fi

    mkdir -p "$dst"
    cp -r "$src/"* "$dst/" 2>/dev/null || true
    cp "$src"/.editorconfig "$dst/" 2>/dev/null || true
    cp "$src"/.gitignore "$dst/" 2>/dev/null || true
    cp "$src"/.gitattributes "$dst/" 2>/dev/null || true

    echo "Applying substitutions..."
    find "$dst" -type f \( -name "*.md" -o -name "*.py" -o -name "Makefile" -o -name "Dockerfile" -o -name "*.yml" -o -name "*.yaml" \) | while read -r file; do
        sed -i \
            -e "s/__PROJECT_NAME__/$name/g" \
            -e "s/__PROJECT_SLUG__/$slug/g" \
            -e "s/__PROJECT_DESCRIPTION__/$desc/g" \
            -e "s/__PROJECT_YEAR__/$YEAR/g" \
            "$file" 2>/dev/null || true
    done

    echo "Done."
}

init_git() {
    local dst="$1"
    echo ""
    echo "Initialising Git repository..."
    (
        cd "$dst"
        git init -b main
        git add -A
        if git commit -m "Initial scaffold from AI Engineering Kit" &>/dev/null; then
            echo "Created initial commit."
        else
            echo "Git commit skipped (nothing to commit or git not configured)."
        fi
    )
}

print_success() {
    local dst="$1"
    local name="$2"

    echo ""
    echo "  ── Success ──────────────────────────────"
    echo "  Project: $name"
    echo "  Location: $(cd "$dst" && pwd)"
    echo "─────────────────────────────────────────"
    echo ""
    echo "  Next steps:"
    echo "    cd $(basename "$dst")"
    echo "    make run"
    echo "    make test"
    echo ""
}

# ── Main ──────────────────────────────────────

print_banner
check_dependencies

echo "This script scaffolds a new project from the generic template."
echo ""

prompt_required "Project name (e.g. my-project)" PROJECT_NAME
validate_project_name "$PROJECT_NAME"

PROJECT_SLUG=$(slugify "$PROJECT_NAME")

read -r -p "Description [A new project scaffolded from AI Engineering Kit]: " PROJECT_DESCRIPTION
PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-A new project scaffolded from AI Engineering Kit}"

read -r -p "Target directory [./$PROJECT_SLUG]: " TARGET_DIR
TARGET_DIR="${TARGET_DIR:-$PWD/$PROJECT_SLUG}"

echo ""
echo "Scaffolding '$PROJECT_NAME' into $TARGET_DIR..."
echo ""

copy_template "$TEMPLATE_DIR" "$TARGET_DIR" "$PROJECT_SLUG" "$PROJECT_NAME" "$PROJECT_DESCRIPTION"

echo ""
read -r -p "Initialise Git repository? [Y/n]: " INIT_GIT
INIT_GIT="${INIT_GIT:-Y}"
if [ "$INIT_GIT" = "Y" ] || [ "$INIT_GIT" = "y" ] || [ "$INIT_GIT" = "" ]; then
    init_git "$TARGET_DIR"
fi

print_success "$TARGET_DIR" "$PROJECT_NAME"
