# Backup Scheduler

param(
    [Parameter(Position=0)]
    [string]$Action = "status",

    [Parameter(Position=1)]
    [string]$Name = ""
)

$BackupDir = "$HOME\.claude\backups"
$SourceDirs = @(
    "$HOME\.claude\skills",
    "$HOME\.claude\agents"
)
$SourceFiles = @(
    "$HOME\.claude\CLAUDE.md",
    "$HOME\.claude\settings.json",
    "$HOME\.claude\DEVELOPMENT_LOG.md"
)
$MaxBackups = 10

# Ensure backup directory exists
if (-not (Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
}

function Get-BackupList {
    $backups = @()
    Get-ChildItem -Path $BackupDir -Directory | Sort-Object Name -Descending | ForEach-Object {
        $metaFile = Join-Path $_.FullName "backup.json"
        if (Test-Path $metaFile) {
            $meta = Get-Content $metaFile -Raw | ConvertFrom-Json
            $backups += @{
                Name = $_.Name
                Path = $_.FullName
                Date = $meta.date
                Files = $meta.fileCount
                Size = $meta.size
            }
        } else {
            $backups += @{
                Name = $_.Name
                Path = $_.FullName
                Date = $_.CreationTime.ToString("yyyy-MM-dd HH:mm")
                Files = (Get-ChildItem $_.FullName -Recurse -File).Count
                Size = "Unknown"
            }
        }
    }
    return $backups
}

function Show-Status {
    Write-Host ""
    Write-Host "===== BACKUP STATUS =====" -ForegroundColor Cyan
    Write-Host ""

    $backups = Get-BackupList

    if ($backups.Count -eq 0) {
        Write-Host "No backups found." -ForegroundColor Yellow
        Write-Host "Run 'backup create <name>' to create first backup." -ForegroundColor Gray
    } else {
        Write-Host "Total backups: $($backups.Count)" -ForegroundColor Green
        Write-Host ""
        Write-Host "Latest backup:" -ForegroundColor Yellow
        $latest = $backups[0]
        Write-Host "  Name: $($latest.Name)" -ForegroundColor White
        Write-Host "  Date: $($latest.Date)" -ForegroundColor Gray
        Write-Host "  Files: $($latest.Files)" -ForegroundColor Gray
    }

    Write-Host ""
    Write-Host "Backup location: $BackupDir" -ForegroundColor Gray
    Write-Host ""
}

function Show-List {
    Write-Host ""
    Write-Host "===== ALL BACKUPS =====" -ForegroundColor Cyan
    Write-Host ""

    $backups = Get-BackupList

    if ($backups.Count -eq 0) {
        Write-Host "No backups found." -ForegroundColor Yellow
    } else {
        foreach ($backup in $backups) {
            Write-Host "  $($backup.Name)" -NoNewline -ForegroundColor Green
            Write-Host " - $($backup.Date)" -NoNewline -ForegroundColor Gray
            Write-Host " ($($backup.Files) files)" -ForegroundColor DarkGray
        }
    }
    Write-Host ""
}

function Create-Backup {
    param([string]$BackupName)

    if ([string]::IsNullOrWhiteSpace($BackupName)) {
        $BackupName = "backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    }

    $targetDir = Join-Path $BackupDir $BackupName

    if (Test-Path $targetDir) {
        Write-Host "[ERROR] Backup '$BackupName' already exists" -ForegroundColor Red
        return
    }

    Write-Host ""
    Write-Host "===== CREATING BACKUP: $BackupName =====" -ForegroundColor Cyan
    Write-Host ""

    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    $fileCount = 0

    # Copy directories
    foreach ($dir in $SourceDirs) {
        if (Test-Path $dir) {
            $dirName = Split-Path $dir -Leaf
            $destDir = Join-Path $targetDir $dirName
            Write-Host "Backing up $dirName..." -ForegroundColor Gray
            Copy-Item -Path $dir -Destination $destDir -Recurse -Force
            $fileCount += (Get-ChildItem $destDir -Recurse -File).Count
        }
    }

    # Copy individual files
    $configDir = Join-Path $targetDir "config"
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null

    foreach ($file in $SourceFiles) {
        if (Test-Path $file) {
            $fileName = Split-Path $file -Leaf
            Write-Host "Backing up $fileName..." -ForegroundColor Gray
            Copy-Item -Path $file -Destination (Join-Path $configDir $fileName) -Force
            $fileCount++
        }
    }

    # Calculate size
    $size = (Get-ChildItem $targetDir -Recurse -File | Measure-Object -Property Length -Sum).Sum
    $sizeStr = if ($size -gt 1MB) { "{0:N2} MB" -f ($size / 1MB) } else { "{0:N2} KB" -f ($size / 1KB) }

    # Save metadata
    $meta = @{
        name = $BackupName
        date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        fileCount = $fileCount
        size = $sizeStr
        sources = @{
            directories = $SourceDirs
            files = $SourceFiles
        }
    }
    $meta | ConvertTo-Json -Depth 3 | Out-File (Join-Path $targetDir "backup.json") -Encoding UTF8

    Write-Host ""
    Write-Host "[OK] Backup created successfully!" -ForegroundColor Green
    Write-Host "  Location: $targetDir" -ForegroundColor Gray
    Write-Host "  Files: $fileCount" -ForegroundColor Gray
    Write-Host "  Size: $sizeStr" -ForegroundColor Gray
    Write-Host ""

    # Clean old backups
    Clean-OldBackups
}

function Restore-Backup {
    param([string]$BackupName)

    if ([string]::IsNullOrWhiteSpace($BackupName)) {
        Write-Host "[ERROR] Please specify backup name to restore" -ForegroundColor Red
        Write-Host "Usage: backup restore <name>" -ForegroundColor Gray
        return
    }

    $sourceDir = Join-Path $BackupDir $BackupName

    if (-not (Test-Path $sourceDir)) {
        Write-Host "[ERROR] Backup '$BackupName' not found" -ForegroundColor Red
        return
    }

    Write-Host ""
    Write-Host "===== RESTORING: $BackupName =====" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[WARNING] This will overwrite current files!" -ForegroundColor Yellow
    Write-Host ""

    # Restore directories
    $skillsBackup = Join-Path $sourceDir "skills"
    $agentsBackup = Join-Path $sourceDir "agents"

    if (Test-Path $skillsBackup) {
        Write-Host "Restoring skills..." -ForegroundColor Gray
        Copy-Item -Path "$skillsBackup\*" -Destination "$HOME\.claude\skills\" -Recurse -Force
    }

    if (Test-Path $agentsBackup) {
        Write-Host "Restoring agents..." -ForegroundColor Gray
        Copy-Item -Path "$agentsBackup\*" -Destination "$HOME\.claude\agents\" -Recurse -Force
    }

    # Restore config files
    $configDir = Join-Path $sourceDir "config"
    if (Test-Path $configDir) {
        Write-Host "Restoring config files..." -ForegroundColor Gray
        Get-ChildItem $configDir -File | ForEach-Object {
            Copy-Item $_.FullName -Destination "$HOME\.claude\$($_.Name)" -Force
        }
    }

    Write-Host ""
    Write-Host "[OK] Restore completed!" -ForegroundColor Green
    Write-Host ""
}

function Clean-OldBackups {
    $backups = Get-ChildItem -Path $BackupDir -Directory | Sort-Object Name -Descending

    if ($backups.Count -gt $MaxBackups) {
        Write-Host "Cleaning old backups (keeping last $MaxBackups)..." -ForegroundColor Gray
        $toDelete = $backups | Select-Object -Skip $MaxBackups
        foreach ($old in $toDelete) {
            Remove-Item $old.FullName -Recurse -Force
            Write-Host "  Removed: $($old.Name)" -ForegroundColor DarkGray
        }
    }
}

function Clean-AllOld {
    Write-Host ""
    Write-Host "===== CLEANING OLD BACKUPS =====" -ForegroundColor Cyan
    Write-Host ""

    $backups = Get-ChildItem -Path $BackupDir -Directory | Sort-Object Name -Descending

    if ($backups.Count -le $MaxBackups) {
        Write-Host "No cleanup needed. Have $($backups.Count) backups (max: $MaxBackups)" -ForegroundColor Green
    } else {
        $toDelete = $backups | Select-Object -Skip $MaxBackups
        Write-Host "Removing $($toDelete.Count) old backup(s)..." -ForegroundColor Yellow
        foreach ($old in $toDelete) {
            Remove-Item $old.FullName -Recurse -Force
            Write-Host "  [REMOVED] $($old.Name)" -ForegroundColor Gray
        }
        Write-Host ""
        Write-Host "[OK] Cleanup complete!" -ForegroundColor Green
    }
    Write-Host ""
}

# Main
switch ($Action) {
    "status" { Show-Status }
    "list" { Show-List }
    "create" { Create-Backup -BackupName $Name }
    "restore" { Restore-Backup -BackupName $Name }
    "clean" { Clean-AllOld }
    default {
        Write-Host ""
        Write-Host "Backup Scheduler" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Commands:" -ForegroundColor Yellow
        Write-Host "  status  - Show backup status (default)"
        Write-Host "  list    - List all backups"
        Write-Host "  create  - Create new backup"
        Write-Host "  restore - Restore from backup"
        Write-Host "  clean   - Remove old backups"
        Write-Host ""
    }
}
