#Requires -Version 5.1

# ──────────────────────────────────────────────
# AI Engineering Kit — Project Scaffold Script
# ──────────────────────────────────────────────

$ErrorActionPreference = 'Stop'

$KIT_DIR = Split-Path -Parent $PSScriptRoot
$TEMPLATE_DIR = Join-Path (Join-Path $KIT_DIR 'templates') 'generic'
$YEAR = Get-Date -Format 'yyyy'

function Print-Banner {
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════╗"
    Write-Host "  ║   AI Engineering Kit — Scaffold     ║"
    Write-Host "  ╚══════════════════════════════════════╝"
    Write-Host ""
}

function Die {
    param([string]$Message)
    Write-Host "Error: $Message" -ForegroundColor Red
    exit 1
}

function Read-RequiredValue {
    param(
        [string]$Prompt,
        [string]$Default
    )
    $value = ''
    while ([string]::IsNullOrWhiteSpace($value)) {
        if ([string]::IsNullOrWhiteSpace($Default)) {
            $value = Read-Host $Prompt
        } else {
            $input = Read-Host "${Prompt} [$Default]"
            if ([string]::IsNullOrWhiteSpace($input)) {
                $value = $Default
            } else {
                $value = $input
            }
        }
        if ([string]::IsNullOrWhiteSpace($value)) {
            Write-Host "This field is required." -ForegroundColor Yellow
        }
    }
    return $value
}

function Test-ProjectName {
    param([string]$Name)
    if ($Name -match '[^a-zA-Z0-9._-]') {
        Die "Project name contains invalid characters. Use letters, numbers, hyphens, underscores, and dots only."
    }
    if ($Name.Length -lt 2) {
        Die "Project name must be at least 2 characters."
    }
}

function ConvertTo-Slug {
    param([string]$Name)
    return ($Name.ToLower() -replace '[ _]+', '-' -replace '[^a-z0-9.-]', '')
}

function Copy-Template {
    param(
        [string]$SourceDir,
        [string]$DestDir,
        [string]$Slug,
        [string]$Name,
        [string]$Description
    )

    if (Test-Path -LiteralPath $DestDir) {
        Die "Directory '$DestDir' already exists."
    }

    Write-Host "Copying template..."
    $null = New-Item -ItemType Directory -Path $DestDir -Force
    Get-ChildItem -Path $SourceDir -Force | Copy-Item -Destination $DestDir -Recurse -Force

    Write-Host "Applying substitutions..."
    $includePatterns = @('*.md', '*.py', 'Makefile', 'Dockerfile', '*.yml', '*.yaml')
    $files = Get-ChildItem -Path $DestDir -Recurse -File | Where-Object {
        $fileName = $_.Name
        $matched = $false
        foreach ($pattern in $includePatterns) {
            if ($fileName -like $pattern) {
                $matched = $true
                break
            }
        }
        $matched
    }

    foreach ($file in $files) {
        try {
            $content = Get-Content -LiteralPath $file.FullName -Raw
            $content = $content -replace '__PROJECT_NAME__', $Name
            $content = $content -replace '__PROJECT_SLUG__', $Slug
            $content = $content -replace '__PROJECT_DESCRIPTION__', $Description
            $content = $content -replace '__PROJECT_YEAR__', $YEAR
            Set-Content -LiteralPath $file.FullName -Value $content -Encoding UTF8 -NoNewline
        } catch {
            Write-Host "Warning: Could not process $($file.FullName): $_" -ForegroundColor Yellow
        }
    }

    Write-Host "Done."
}

function Initialize-GitRepository {
    param([string]$DestDir)

    $gitPath = Get-Command 'git' -ErrorAction SilentlyContinue
    if (-not $gitPath) {
        Write-Host "Git not found. Skipping repository initialisation." -ForegroundColor Yellow
        return
    }

    Write-Host ""
    Write-Host "Initialising Git repository..."

    $originalDir = Get-Location
    try {
        Set-Location -LiteralPath $DestDir
        $null = & git init -b main 2>$null
        $null = & git add -A 2>$null
        $null = & git commit -m "Initial scaffold from AI Engineering Kit" 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host 'Created initial commit.'
        } else {
            Write-Host 'Git commit skipped -- commit could not be created.'
        }
    } catch {
        Write-Host "Git initialisation failed: $_" -ForegroundColor Yellow
    } finally {
        Set-Location -LiteralPath $originalDir
    }
}

function Print-Success {
    param(
        [string]$DestDir,
        [string]$Name
    )

    $resolved = Resolve-Path -LiteralPath $DestDir -ErrorAction SilentlyContinue
    $location = if ($resolved) { $resolved.Path } else { $DestDir }
    $folderName = Split-Path -Leaf $location

    Write-Host ""
    Write-Host "  ── Success ──────────────────────────────"
    Write-Host "  Project: $Name"
    Write-Host "  Location: $location"
    Write-Host "─────────────────────────────────────────"
    Write-Host ""
    Write-Host "  Next steps:"
    Write-Host "    cd $folderName"
    Write-Host "    make run"
    Write-Host "    make test"
    Write-Host ""
}

function Check-Dependencies {
    $python = Get-Command 'python', 'python3' -ErrorAction SilentlyContinue
    if (-not $python) {
        Write-Host "Warning: Python not found. Install Python to run the generated project." -ForegroundColor Yellow
    }

    $git = Get-Command 'git' -ErrorAction SilentlyContinue
    if (-not $git) {
        Write-Host "Warning: git not found. Install Git to initialise the repository." -ForegroundColor Yellow
    }
}

# ── Main ──────────────────────────────────────

Print-Banner
Check-Dependencies

Write-Host "This script scaffolds a new project from the generic template."
Write-Host ""

$PROJECT_NAME = Read-RequiredValue -Prompt "Project name (e.g. my-project)"
Test-ProjectName -Name $PROJECT_NAME

$PROJECT_SLUG = ConvertTo-Slug -Name $PROJECT_NAME

$descDefault = "A new project scaffolded from AI Engineering Kit"
$PROJECT_DESCRIPTION = Read-Host "Description [$descDefault]"
if ([string]::IsNullOrWhiteSpace($PROJECT_DESCRIPTION)) {
    $PROJECT_DESCRIPTION = $descDefault
}

$targetDefault = Join-Path (Get-Location).Path $PROJECT_SLUG
$TARGET_DIR = Read-Host "Target directory [$targetDefault]"
if ([string]::IsNullOrWhiteSpace($TARGET_DIR)) {
    $TARGET_DIR = $targetDefault
}

Write-Host ""
Write-Host "Scaffolding '$PROJECT_NAME' into $TARGET_DIR..."
Write-Host ""

Copy-Template -SourceDir $TEMPLATE_DIR -DestDir $TARGET_DIR -Slug $PROJECT_SLUG -Name $PROJECT_NAME -Description $PROJECT_DESCRIPTION

Write-Host ""
$INIT_GIT = Read-Host "Initialise Git repository? [Y/n]"
if ([string]::IsNullOrWhiteSpace($INIT_GIT) -or $INIT_GIT -eq 'Y' -or $INIT_GIT -eq 'y') {
    Initialize-GitRepository -DestDir $TARGET_DIR
}

Print-Success -DestDir $TARGET_DIR -Name $PROJECT_NAME
