# SAGE - Smart Autonomous Growth Engine

param(
    [Parameter(Position=0)]
    [ValidateSet("status", "sync", "backup", "improve", "report", "approve", "auto-start", "auto-end")]
    [string]$Action = "status"
)

$ErrorActionPreference = "SilentlyContinue"
$AgentDir = "$HOME\.claude\agents"
$SkillsDir = "$HOME\.claude\skills"
$LogFile = "$HOME\.claude\.sage.log"
$StateFile = "$HOME\.claude\.sage-state.json"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp [$Level] $Message" | Out-File -Append -FilePath $LogFile -Encoding UTF8
    if ($Level -eq "APPROVE") {
        Write-Host "[SAGE APPROVED] $Message" -ForegroundColor Green
    } elseif ($Level -eq "WARN") {
        Write-Host "[SAGE] $Message" -ForegroundColor Yellow
    } else {
        Write-Host "[SAGE] $Message" -ForegroundColor Cyan
    }
}

function Get-State {
    if (Test-Path $StateFile) {
        return Get-Content $StateFile -Encoding UTF8 | ConvertFrom-Json
    }
    return @{
        lastSync = $null
        lastBackup = $null
        sessionsCount = 0
        approvedTasks = 0
    }
}

function Save-State {
    param($State)
    $State | ConvertTo-Json | Out-File -FilePath $StateFile -Encoding UTF8
}

function Show-Status {
    $state = Get-State
    $skillCount = (Get-ChildItem -Path $SkillsDir -Directory | Where-Object {
        Test-Path (Join-Path $_.FullName "SKILL.md")
    }).Count

    Write-Host ""
    Write-Host "   _____ ___   _____ ______ " -ForegroundColor Magenta
    Write-Host "  / ___//   | / ___// ____/ " -ForegroundColor Magenta
    Write-Host "  \__ \/ /| |/ /__ / __/    " -ForegroundColor Magenta
    Write-Host " ___/ / ___ / /_/ / /___    " -ForegroundColor Magenta
    Write-Host "/____/_/  |_\____/_____/    " -ForegroundColor Magenta
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Shalom Elad! Ani SAGE, haSochen shelcha." -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Skills: $skillCount mutkanot" -ForegroundColor Green
    $syncText = if ($state.lastSync) { $state.lastSync } else { "Lo butzah" }
    Write-Host "Sync acharon: $syncText" -ForegroundColor Gray
    $backupText = if ($state.lastBackup) { $state.lastBackup } else { "Lo butzah" }
    Write-Host "Backup acharon: $backupText" -ForegroundColor Gray
    Write-Host "Sessions: $($state.sessionsCount)" -ForegroundColor Gray
    $approved = if ($state.approvedTasks) { $state.approvedTasks } else { 0 }
    Write-Host "Misimot meusharot: $approved" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Ani muchan laavod! Ma laasot?" -ForegroundColor Yellow
    Write-Host ""
}

function Run-Sync {
    Write-Log "Matchil syncron..."
    $syncScript = Join-Path $SkillsDir "skill-sync\sync.ps1"
    if (Test-Path $syncScript) {
        & powershell -ExecutionPolicy Bypass -File $syncScript sync
        $state = Get-State
        $state.lastSync = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Save-State $state
        Write-Log "Syncron hushlam!" "APPROVE"
    }
}

function Run-Backup {
    Write-Log "Matchil backup..."
    $backupScript = Join-Path $SkillsDir "github-backup\backup.ps1"
    if (Test-Path $backupScript) {
        & powershell -ExecutionPolicy Bypass -File $backupScript full
        $state = Get-State
        $state.lastBackup = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Save-State $state
        Write-Log "Backup hushlam!" "APPROVE"
    }
}

function Approve-Progress {
    $state = Get-State
    $state.approvedTasks++
    Save-State $state

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "[SAGE] MEUSHAR! Hitkadmut meusheret!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Total approved: $($state.approvedTasks)" -ForegroundColor White
    Write-Host "  Kol hakavod! Mamshichim!" -ForegroundColor Cyan
    Write-Host ""

    Write-Log "Hitkadmut meusheret #$($state.approvedTasks)" "APPROVE"
}

function Generate-Report {
    $state = Get-State
    $skills = Get-ChildItem -Path $SkillsDir -Directory | Where-Object {
        Test-Path (Join-Path $_.FullName "SKILL.md")
    }

    Write-Host ""
    Write-Host "===== SAGE REPORT =====" -ForegroundColor Cyan
    Write-Host "Skills: $($skills.Count)"
    Write-Host "Sessions: $($state.sessionsCount)"
    Write-Host "Approved: $(if ($state.approvedTasks) { $state.approvedTasks } else { 0 })"
    Write-Host "Last sync: $(if ($state.lastSync) { $state.lastSync } else { 'Never' })"
    Write-Host "Last backup: $(if ($state.lastBackup) { $state.lastBackup } else { 'Never' })"
    Write-Host ""
}

function Run-AutoStart {
    Write-Log "Session hitchil - SAGE muchan!"
    $state = Get-State
    $state.sessionsCount++
    Save-State $state
}

function Run-AutoEnd {
    Write-Log "Session mistayem - Lehitraot!"
}

switch ($Action) {
    "status" { Show-Status }
    "sync" { Run-Sync }
    "backup" { Run-Backup }
    "improve" { Generate-Report }
    "report" { Generate-Report }
    "approve" { Approve-Progress }
    "auto-start" { Run-AutoStart }
    "auto-end" { Run-AutoEnd }
}
