# Command Palette

param(
    [Parameter(Position=0)]
    [string]$Action = "all",

    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

$SkillsDir = "$HOME\.claude\skills"
$AgentsDir = "$HOME\.claude\agents"
$HistoryFile = "$HOME\.claude\data\command-history.json"
$DataDir = Split-Path $HistoryFile -Parent

if (-not (Test-Path $DataDir)) {
    New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
}

function Get-History {
    if (Test-Path $HistoryFile) {
        return Get-Content $HistoryFile -Raw -Encoding UTF8 | ConvertFrom-Json
    }
    return @{
        commands = @()
        counts = @{}
    }
}

function Save-History {
    param($data)
    $data | ConvertTo-Json -Depth 5 | Out-File $HistoryFile -Encoding UTF8 -Force
}

function Add-ToHistory {
    param([string]$Cmd)
    $history = Get-History

    # Add to recent
    $history.commands = @($Cmd) + ($history.commands | Where-Object { $_ -ne $Cmd } | Select-Object -First 19)

    # Increment count
    if (-not $history.counts) { $history.counts = @{} }
    if ($history.counts.ContainsKey($Cmd)) {
        $history.counts[$Cmd]++
    } else {
        $history.counts[$Cmd] = 1
    }

    Save-History $history
}

function Get-AllSkills {
    $skills = @()
    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Directory | ForEach-Object {
            $skillFile = Join-Path $_.FullName "SKILL.md"
            if (Test-Path $skillFile) {
                $content = Get-Content $skillFile -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
                $desc = ""
                if ($content -match '(?s)description:\s*(.+?)(?:\n---|$)') {
                    $desc = $Matches[1].Trim()
                    if ($desc.Length -gt 50) { $desc = $desc.Substring(0, 47) + "..." }
                }
                $skills += @{
                    Name = $_.Name
                    Type = "skill"
                    Desc = $desc
                }
            }
        }
    }
    return $skills
}

function Get-AllAgents {
    $agents = @()
    if (Test-Path $AgentsDir) {
        Get-ChildItem -Path $AgentsDir -Filter "*.ps1" | ForEach-Object {
            $agents += @{
                Name = $_.BaseName
                Type = "agent"
                Desc = "Agent script"
            }
        }
        Get-ChildItem -Path $AgentsDir -Filter "*.md" | ForEach-Object {
            if ($_.BaseName -notmatch '\.ps1$') {
                $agents += @{
                    Name = $_.BaseName
                    Type = "agent-doc"
                    Desc = "Agent documentation"
                }
            }
        }
    }
    return $agents | Sort-Object Name -Unique
}

function Show-All {
    Write-Host ""
    Write-Host "===========================================" -ForegroundColor Magenta
    Write-Host "           COMMAND PALETTE" -ForegroundColor Magenta
    Write-Host "===========================================" -ForegroundColor Magenta
    Write-Host ""

    # Quick actions
    Write-Host "QUICK ACTIONS" -ForegroundColor Cyan
    Write-Host "  sage status    - SAGE agent status" -ForegroundColor Gray
    Write-Host "  sage approve   - Approve progress" -ForegroundColor Gray
    Write-Host "  backup create  - Create backup" -ForegroundColor Gray
    Write-Host "  env-checker    - Check environment" -ForegroundColor Gray
    Write-Host ""

    # Skills count
    $skills = Get-AllSkills
    Write-Host "SKILLS ($($skills.Count) installed)" -ForegroundColor Cyan
    $topSkills = $skills | Select-Object -First 8
    foreach ($s in $topSkills) {
        Write-Host "  /$($s.Name)" -NoNewline -ForegroundColor Green
        if ($s.Desc) {
            Write-Host " - $($s.Desc)" -ForegroundColor Gray
        } else {
            Write-Host ""
        }
    }
    if ($skills.Count -gt 8) {
        Write-Host "  ... and $($skills.Count - 8) more (use 'skills' to see all)" -ForegroundColor DarkGray
    }
    Write-Host ""

    # Agents
    $agents = Get-AllAgents
    Write-Host "AGENTS ($($agents.Count) available)" -ForegroundColor Cyan
    foreach ($a in $agents | Where-Object { $_.Type -eq "agent" }) {
        Write-Host "  $($a.Name)" -ForegroundColor Yellow
    }
    Write-Host ""

    Write-Host "===========================================" -ForegroundColor Magenta
    Write-Host "Type 'palette <category>' for details" -ForegroundColor Gray
    Write-Host "Categories: skills, agents, recent" -ForegroundColor Gray
    Write-Host "===========================================" -ForegroundColor Magenta
    Write-Host ""
}

function Show-Skills {
    $skills = Get-AllSkills

    Write-Host ""
    Write-Host "===== ALL SKILLS ($($skills.Count)) =====" -ForegroundColor Cyan
    Write-Host ""

    foreach ($s in ($skills | Sort-Object Name)) {
        Write-Host "  /$($s.Name)" -NoNewline -ForegroundColor Green
        if ($s.Desc) {
            Write-Host " - $($s.Desc)" -ForegroundColor Gray
        } else {
            Write-Host ""
        }
    }
    Write-Host ""
}

function Show-Agents {
    $agents = Get-AllAgents

    Write-Host ""
    Write-Host "===== AGENTS =====" -ForegroundColor Cyan
    Write-Host ""

    foreach ($a in $agents) {
        $color = if ($a.Type -eq "agent") { "Yellow" } else { "Gray" }
        Write-Host "  $($a.Name)" -NoNewline -ForegroundColor $color
        Write-Host " ($($a.Type))" -ForegroundColor DarkGray
    }
    Write-Host ""
}

function Show-Recent {
    $history = Get-History

    Write-Host ""
    Write-Host "===== RECENT COMMANDS =====" -ForegroundColor Cyan
    Write-Host ""

    if ($history.commands.Count -eq 0) {
        Write-Host "No command history yet." -ForegroundColor Yellow
    } else {
        $shown = 0
        foreach ($cmd in $history.commands) {
            if ($shown -ge 10) { break }
            $count = if ($history.counts -and $history.counts.$cmd) { $history.counts.$cmd } else { 1 }
            Write-Host "  $cmd" -NoNewline -ForegroundColor Green
            Write-Host " (used $count times)" -ForegroundColor Gray
            $shown++
        }
    }
    Write-Host ""
}

function Run-Command {
    param([string]$Cmd)

    if ([string]::IsNullOrWhiteSpace($Cmd)) {
        Write-Host "[ERROR] Please specify command to run" -ForegroundColor Red
        return
    }

    Add-ToHistory $Cmd

    # Check if it's a skill
    $skillPath = Join-Path $SkillsDir $Cmd
    $scriptFiles = @("$Cmd.ps1", "main.ps1", "run.ps1", "index.ps1")

    foreach ($scriptName in $scriptFiles) {
        $scriptPath = Join-Path $skillPath $scriptName
        if (Test-Path $scriptPath) {
            Write-Host "[RUNNING] $Cmd" -ForegroundColor Cyan
            & powershell -ExecutionPolicy Bypass -File $scriptPath
            return
        }
    }

    # Check if it's an agent
    $agentPath = Join-Path $AgentsDir "$Cmd.ps1"
    if (Test-Path $agentPath) {
        Write-Host "[RUNNING AGENT] $Cmd" -ForegroundColor Yellow
        & powershell -ExecutionPolicy Bypass -File $agentPath
        return
    }

    Write-Host "[NOT FOUND] Command '$Cmd' not found" -ForegroundColor Red
    Write-Host "Try 'palette skills' or 'palette agents' to see available commands" -ForegroundColor Gray
}

# Main
$argText = $Args -join " "

switch ($Action) {
    "all" { Show-All }
    "skills" { Show-Skills }
    "agents" { Show-Agents }
    "recent" { Show-Recent }
    "run" { Run-Command -Cmd $argText }
    default {
        # If action looks like a command name, try to run it
        if ($Action -and $Action -notmatch '^(all|skills|agents|recent|run)$') {
            Run-Command -Cmd $Action
        } else {
            Show-All
        }
    }
}
