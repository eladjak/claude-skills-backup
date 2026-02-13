# GitHub Backup Script
# Backs up Claude skills to GitHub with multi-language documentation

param(
    [Parameter(Position=0)]
    [ValidateSet("full", "skills", "docs", "push", "auto")]
    [string]$Action = "full"
)

$ErrorActionPreference = "Stop"
$SkillsDir = "$HOME\.claude\skills"
$RepoDir = "$HOME\ai-agents-skills"
$UpstreamRepo = "hoodini/ai-agents-skills"
$ForkRepo = "eladjak/ai-agents-skills"
$LogFile = "$HOME\.claude\.github-backup.log"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -Append -FilePath $LogFile
    Write-Host $Message
}

function Ensure-Repo {
    if (-not (Test-Path $RepoDir)) {
        Write-Log "[CLONE] Cloning repository..."
        gh repo clone $UpstreamRepo $RepoDir
        Push-Location $RepoDir
        # Add fork as remote for pushing
        git remote add fork "https://github.com/$ForkRepo.git" 2>$null
        Pop-Location
    } else {
        Write-Log "[PULL] Updating repository..."
        Push-Location $RepoDir
        # Ensure fork remote exists
        $forkExists = git remote | Where-Object { $_ -eq "fork" }
        if (-not $forkExists) {
            git remote add fork "https://github.com/$ForkRepo.git" 2>$null
        }
        git pull --quiet origin master 2>$null
        Pop-Location
    }
}

function Get-LocalSkills {
    $skills = @()
    Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
        $skillPath = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillPath) {
            $content = Get-Content -Path $skillPath -Raw
            $name = $_.Name
            $description = ""

            # Extract description from frontmatter
            if ($content -match '(?s)---.*?description:\s*(.+?)(?:\n[a-z]|---)') {
                $description = $Matches[1].Trim()
                # Truncate if too long
                if ($description.Length -gt 100) {
                    $description = $description.Substring(0, 97) + "..."
                }
            }

            $skills += @{
                Name = $name
                Path = $_.FullName
                Description = $description
                SkillFile = $skillPath
            }
        }
    }
    return $skills
}

function Sync-Skills {
    Write-Log "[SYNC] Syncing skills to repository..."

    $localSkills = Get-LocalSkills
    $repoSkillsDir = Join-Path $RepoDir "skills"

    if (-not (Test-Path $repoSkillsDir)) {
        New-Item -ItemType Directory -Path $repoSkillsDir -Force | Out-Null
    }

    $results = @{
        Added = @()
        Updated = @()
        Unchanged = @()
    }

    foreach ($skill in $localSkills) {
        $targetDir = Join-Path $repoSkillsDir $skill.Name
        $targetFile = Join-Path $targetDir "SKILL.md"

        # Check if skill exists in repo
        if (-not (Test-Path $targetDir)) {
            # New skill
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            Copy-Item -Path $skill.SkillFile -Destination $targetFile -Force
            $results.Added += $skill.Name
            Write-Log "  [+] Added: $($skill.Name)"
        } else {
            # Compare hashes
            $localHash = (Get-FileHash -Path $skill.SkillFile -Algorithm SHA256).Hash
            $repoHash = ""
            if (Test-Path $targetFile) {
                $repoHash = (Get-FileHash -Path $targetFile -Algorithm SHA256).Hash
            }

            if ($localHash -ne $repoHash) {
                Copy-Item -Path $skill.SkillFile -Destination $targetFile -Force
                $results.Updated += $skill.Name
                Write-Log "  [~] Updated: $($skill.Name)"
            } else {
                $results.Unchanged += $skill.Name
            }
        }
    }

    return $results
}

function Generate-READMEs {
    param($Skills)

    Write-Log "[DOCS] Generating multi-language documentation..."

    # Generate skills table (English)
    $tableEN = ""
    foreach ($skill in $Skills | Sort-Object Name) {
        $tableEN += "| $($skill.Name) | $($skill.Description) |`n"
    }

    # Generate skills table (Hebrew)
    $tableHE = ""
    foreach ($skill in $Skills | Sort-Object Name) {
        $tableHE += "| $($skill.Name) | $($skill.Description) |`n"
    }

    # English README
    $readmeEN = @"
<p align="center">
  <img src="https://img.shields.io/badge/AI-Agent%20Skills-blueviolet?style=for-the-badge&logo=robot&logoColor=white" alt="AI Agent Skills"/>
  <img src="https://img.shields.io/badge/Skills-$($Skills.Count)-green?style=for-the-badge" alt="Skills Count"/>
</p>

<p align="center">
  <img src="hero-skills.jpg" alt="AI Agent Skills Hero"/>
</p>

# AI Agent Skills Repository

A curated collection of specialized skills for AI coding agents (Claude Code, GitHub Copilot, Cursor, Windsurf).

## Quick Start

### Using skill-sync (Recommended)

``````powershell
# Check available skills
powershell -File ~/.claude/skills/skill-sync/sync.ps1 list

# Sync all skills
powershell -File ~/.claude/skills/skill-sync/sync.ps1 sync

# Check for updates
powershell -File ~/.claude/skills/skill-sync/sync.ps1 check
``````

### Manual Installation

1. Clone this repository: ``gh repo clone hoodini/ai-agents-skills``
2. Copy desired skills to ``~/.claude/skills/``

## Available Skills ($($Skills.Count) total)

| Skill | Description |
|-------|-------------|
$tableEN

## Skill Structure

Each skill follows this structure:

``````
skills/
  skill-name/
    SKILL.md      # Main skill definition
    *.ps1         # Optional automation scripts
    references/   # Optional reference materials
``````

## Creating New Skills

1. Create a folder in ``skills/`` with your skill name
2. Add a ``SKILL.md`` with frontmatter:

``````yaml
---
name: my-skill
description: What this skill does. Triggers on keyword1, keyword2.
---
``````

3. Add instructions for the AI agent

## Contributing

1. Fork this repository
2. Create your skill
3. Submit a pull request

## License

MIT - Created by Yuval Avidani

---

*Last updated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")*
"@

    # Hebrew README
    $readmeHE = @"
<div dir="rtl">

<p align="center">
  <img src="https://img.shields.io/badge/AI-Agent%20Skills-blueviolet?style=for-the-badge&logo=robot&logoColor=white" alt="AI Agent Skills"/>
  <img src="https://img.shields.io/badge/Skills-$($Skills.Count)-green?style=for-the-badge" alt="Skills Count"/>
</p>

<p align="center">
  <img src="hero-skills.jpg" alt="AI Agent Skills Hero"/>
</p>

# מאגר מיומנויות לסוכני AI

אוסף מיומנויות מתמחות לסוכני קידוד AI (Claude Code, GitHub Copilot, Cursor, Windsurf).

## התחלה מהירה

### באמצעות skill-sync (מומלץ)

``````powershell
# הצגת מיומנויות זמינות
powershell -File ~/.claude/skills/skill-sync/sync.ps1 list

# סנכרון כל המיומנויות
powershell -File ~/.claude/skills/skill-sync/sync.ps1 sync

# בדיקת עדכונים
powershell -File ~/.claude/skills/skill-sync/sync.ps1 check
``````

### התקנה ידנית

1. שכפל את המאגר: ``gh repo clone hoodini/ai-agents-skills``
2. העתק מיומנויות ל-``~/.claude/skills/``

## מיומנויות זמינות ($($Skills.Count) סה"כ)

| מיומנות | תיאור |
|---------|-------|
$tableHE

## מבנה מיומנות

כל מיומנות בנויה כך:

``````
skills/
  skill-name/
    SKILL.md      # הגדרת המיומנות
    *.ps1         # סקריפטים אופציונליים
    references/   # חומרי עזר
``````

## יצירת מיומנות חדשה

1. צור תיקייה ב-``skills/`` עם שם המיומנות
2. הוסף ``SKILL.md`` עם:

``````yaml
---
name: my-skill
description: מה המיומנות עושה. מופעלת על ידי מילה1, מילה2.
---
``````

3. הוסף הוראות לסוכן

## תרומה

1. צור Fork למאגר
2. צור מיומנות חדשה
3. שלח Pull Request

## רישיון

MIT - נוצר על ידי יובל אבידני

---

*עדכון אחרון: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")*

</div>
"@

    # Write files
    $readmeEN | Out-File -FilePath (Join-Path $RepoDir "README.md") -Encoding UTF8
    $readmeHE | Out-File -FilePath (Join-Path $RepoDir "README-HE.md") -Encoding UTF8

    Write-Log "  [+] README.md (English)"
    Write-Log "  [+] README-HE.md (Hebrew)"
}

function Push-Changes {
    param($Results)

    Write-Log "[PUSH] Pushing changes to GitHub..."

    Push-Location $RepoDir

    git add .

    $message = "chore: sync skills and update documentation`n`n"
    if ($Results.Added.Count -gt 0) {
        $message += "Added: $($Results.Added -join ', ')`n"
    }
    if ($Results.Updated.Count -gt 0) {
        $message += "Updated: $($Results.Updated -join ', ')`n"
    }
    $message += "`nTotal skills: $($Results.Added.Count + $Results.Updated.Count + $Results.Unchanged.Count)"

    git commit -m $message 2>$null

    if ($LASTEXITCODE -eq 0) {
        $branch = git branch --show-current
        if (-not $branch) { $branch = "master" }

        # Push to fork (user's repo), not origin (upstream)
        git push fork $branch 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Log "[DONE] Changes pushed to fork/$branch successfully!"
        } else {
            # Fallback to origin if fork doesn't exist
            git push origin $branch
            Write-Log "[DONE] Changes pushed to origin/$branch!"
        }
    } else {
        Write-Log "[INFO] No changes to commit"
    }

    Pop-Location
}

function Show-Summary {
    param($Results, $Skills)

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "       GitHub Backup Complete!         " -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Skills:" -ForegroundColor White
    Write-Host "  + $($Results.Added.Count) new skills added" -ForegroundColor Green
    Write-Host "  ~ $($Results.Updated.Count) skills updated" -ForegroundColor Yellow
    Write-Host "  = $($Results.Unchanged.Count) skills unchanged" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Documentation:" -ForegroundColor White
    Write-Host "  + README.md (English)" -ForegroundColor Green
    Write-Host "  + README-HE.md (Hebrew)" -ForegroundColor Green
    Write-Host ""
    Write-Host "Repository: https://github.com/$ForkRepo" -ForegroundColor Blue
    Write-Host "Upstream:   https://github.com/$UpstreamRepo" -ForegroundColor Gray
    Write-Host ""
}

# Main
Write-Log ""
Write-Log "========================================"
Write-Log "GitHub Backup - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Write-Log "========================================"

switch ($Action) {
    "skills" {
        Ensure-Repo
        $results = Sync-Skills
        Show-Summary -Results $results -Skills (Get-LocalSkills)
    }
    "docs" {
        Ensure-Repo
        $skills = Get-LocalSkills
        Generate-READMEs -Skills $skills
        Write-Host "[DONE] Documentation updated!" -ForegroundColor Green
    }
    "push" {
        Push-Location $RepoDir
        git add .
        git commit -m "chore: manual update" 2>$null
        $branch = git branch --show-current
        if (-not $branch) { $branch = "master" }
        # Push to fork first, fallback to origin
        git push fork $branch 2>$null
        if ($LASTEXITCODE -ne 0) {
            git push origin $branch
        }
        Pop-Location
        Write-Host "[DONE] Changes pushed to $branch!" -ForegroundColor Green
    }
    "auto" {
        # Silent mode for hooks
        try {
            Ensure-Repo
            $skills = Get-LocalSkills
            $results = Sync-Skills
            Generate-READMEs -Skills $skills
            Push-Changes -Results $results
        } catch {
            Write-Log "[ERROR] Auto backup failed: $_"
        }
    }
    default {
        Ensure-Repo
        $skills = Get-LocalSkills
        $results = Sync-Skills
        Generate-READMEs -Skills $skills
        Push-Changes -Results $results
        Show-Summary -Results $results -Skills $skills
    }
}
