# Config Manager

param(
    [Parameter(Position=0)]
    [string]$Action = "status",

    [Parameter(Position=1)]
    [string]$Target = ""
)

$ClaudeDir = "$HOME\.claude"
$ConfigFiles = @(
    @{ Name = "settings.json"; Path = "$ClaudeDir\settings.json"; Type = "json" },
    @{ Name = "CLAUDE.md"; Path = "$ClaudeDir\CLAUDE.md"; Type = "md" },
    @{ Name = "DEVELOPMENT_LOG.md"; Path = "$ClaudeDir\DEVELOPMENT_LOG.md"; Type = "md" }
)
$ConfigDirs = @(
    @{ Name = "rules"; Path = "$ClaudeDir\rules" },
    @{ Name = "agents"; Path = "$ClaudeDir\agents" },
    @{ Name = "skills"; Path = "$ClaudeDir\skills" }
)

function Show-Status {
    Write-Host ""
    Write-Host "===== CONFIG STATUS =====" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Configuration Files:" -ForegroundColor Yellow
    foreach ($cfg in $ConfigFiles) {
        if (Test-Path $cfg.Path) {
            $size = (Get-Item $cfg.Path).Length
            $sizeStr = if ($size -gt 1024) { "{0:N1} KB" -f ($size/1024) } else { "$size bytes" }
            Write-Host "  [OK] $($cfg.Name)" -NoNewline -ForegroundColor Green
            Write-Host " ($sizeStr)" -ForegroundColor Gray
        } else {
            Write-Host "  [MISSING] $($cfg.Name)" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "Configuration Directories:" -ForegroundColor Yellow
    foreach ($dir in $ConfigDirs) {
        if (Test-Path $dir.Path) {
            $count = (Get-ChildItem $dir.Path -ErrorAction SilentlyContinue).Count
            Write-Host "  [OK] $($dir.Name)/" -NoNewline -ForegroundColor Green
            Write-Host " ($count items)" -ForegroundColor Gray
        } else {
            Write-Host "  [MISSING] $($dir.Name)/" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "Base Path: $ClaudeDir" -ForegroundColor Gray
    Write-Host ""
}

function View-Config {
    param([string]$Name)

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "[ERROR] Please specify config file to view" -ForegroundColor Red
        Write-Host "Available: settings.json, CLAUDE.md, rules/<file>" -ForegroundColor Gray
        return
    }

    # Try direct match first
    $file = $ConfigFiles | Where-Object { $_.Name -eq $Name }
    if ($file) {
        if (Test-Path $file.Path) {
            Write-Host ""
            Write-Host "===== $Name =====" -ForegroundColor Cyan
            Write-Host ""
            Get-Content $file.Path -Encoding UTF8 | Select-Object -First 50
            $totalLines = (Get-Content $file.Path).Count
            if ($totalLines -gt 50) {
                Write-Host ""
                Write-Host "... ($($totalLines - 50) more lines)" -ForegroundColor Gray
            }
            Write-Host ""
        } else {
            Write-Host "[NOT FOUND] $Name" -ForegroundColor Red
        }
        return
    }

    # Try rules directory
    $rulesPath = "$ClaudeDir\rules\$Name"
    if (-not $rulesPath.EndsWith(".md")) { $rulesPath += ".md" }

    if (Test-Path $rulesPath) {
        Write-Host ""
        Write-Host "===== rules/$Name =====" -ForegroundColor Cyan
        Write-Host ""
        Get-Content $rulesPath -Encoding UTF8 | Select-Object -First 50
        Write-Host ""
        return
    }

    Write-Host "[NOT FOUND] Config '$Name'" -ForegroundColor Red
}

function Backup-Configs {
    $backupDir = "$ClaudeDir\backups\config-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

    Write-Host ""
    Write-Host "===== BACKING UP CONFIGS =====" -ForegroundColor Cyan
    Write-Host ""

    $count = 0

    # Backup files
    foreach ($cfg in $ConfigFiles) {
        if (Test-Path $cfg.Path) {
            Copy-Item $cfg.Path -Destination $backupDir -Force
            Write-Host "  [OK] $($cfg.Name)" -ForegroundColor Green
            $count++
        }
    }

    # Backup rules
    $rulesDir = "$ClaudeDir\rules"
    if (Test-Path $rulesDir) {
        $rulesBackup = Join-Path $backupDir "rules"
        Copy-Item $rulesDir -Destination $rulesBackup -Recurse -Force
        $rulesCount = (Get-ChildItem "$rulesDir\*.md" -ErrorAction SilentlyContinue).Count
        Write-Host "  [OK] rules/ ($rulesCount files)" -ForegroundColor Green
        $count += $rulesCount
    }

    Write-Host ""
    Write-Host "[BACKUP COMPLETE]" -ForegroundColor Green
    Write-Host "  Location: $backupDir" -ForegroundColor Gray
    Write-Host "  Files: $count" -ForegroundColor Gray
    Write-Host ""
}

function Validate-Configs {
    Write-Host ""
    Write-Host "===== VALIDATING CONFIGS =====" -ForegroundColor Cyan
    Write-Host ""

    $errors = 0
    $warnings = 0

    # Check settings.json
    $settingsPath = "$ClaudeDir\settings.json"
    if (Test-Path $settingsPath) {
        try {
            $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
            Write-Host "[OK] settings.json - Valid JSON" -ForegroundColor Green
        } catch {
            Write-Host "[ERROR] settings.json - Invalid JSON" -ForegroundColor Red
            $errors++
        }
    } else {
        Write-Host "[WARN] settings.json - Not found" -ForegroundColor Yellow
        $warnings++
    }

    # Check CLAUDE.md
    $claudeMdPath = "$ClaudeDir\CLAUDE.md"
    if (Test-Path $claudeMdPath) {
        $content = Get-Content $claudeMdPath -Raw
        if ($content.Length -gt 100) {
            Write-Host "[OK] CLAUDE.md - Has content ($($content.Length) chars)" -ForegroundColor Green
        } else {
            Write-Host "[WARN] CLAUDE.md - Very short content" -ForegroundColor Yellow
            $warnings++
        }
    } else {
        Write-Host "[WARN] CLAUDE.md - Not found" -ForegroundColor Yellow
        $warnings++
    }

    # Check rules
    $rulesDir = "$ClaudeDir\rules"
    if (Test-Path $rulesDir) {
        $ruleFiles = Get-ChildItem "$rulesDir\*.md" -ErrorAction SilentlyContinue
        if ($ruleFiles.Count -gt 0) {
            Write-Host "[OK] rules/ - $($ruleFiles.Count) rule file(s)" -ForegroundColor Green
        } else {
            Write-Host "[WARN] rules/ - No rule files" -ForegroundColor Yellow
            $warnings++
        }
    }

    # Check agents
    $agentsDir = "$ClaudeDir\agents"
    if (Test-Path $agentsDir) {
        $agentFiles = Get-ChildItem "$agentsDir\*.ps1" -ErrorAction SilentlyContinue
        if ($agentFiles.Count -gt 0) {
            Write-Host "[OK] agents/ - $($agentFiles.Count) agent(s)" -ForegroundColor Green
        }
    }

    Write-Host ""
    if ($errors -eq 0 -and $warnings -eq 0) {
        Write-Host "[VALID] All configurations OK" -ForegroundColor Green
    } elseif ($errors -eq 0) {
        Write-Host "[WARN] $warnings warning(s), no errors" -ForegroundColor Yellow
    } else {
        Write-Host "[ERROR] $errors error(s), $warnings warning(s)" -ForegroundColor Red
    }
    Write-Host ""
}

function List-Rules {
    $rulesDir = "$ClaudeDir\rules"

    Write-Host ""
    Write-Host "===== RULE FILES =====" -ForegroundColor Cyan
    Write-Host ""

    if (-not (Test-Path $rulesDir)) {
        Write-Host "No rules directory found." -ForegroundColor Yellow
        return
    }

    $rules = Get-ChildItem "$rulesDir\*.md" -ErrorAction SilentlyContinue

    if ($rules.Count -eq 0) {
        Write-Host "No rule files found." -ForegroundColor Yellow
    } else {
        foreach ($rule in $rules) {
            $size = "{0:N1} KB" -f ($rule.Length/1024)
            Write-Host "  $($rule.Name)" -NoNewline -ForegroundColor Green
            Write-Host " ($size)" -ForegroundColor Gray
        }
    }
    Write-Host ""
}

# Main
switch ($Action) {
    "status" { Show-Status }
    "view" { View-Config -Name $Target }
    "backup" { Backup-Configs }
    "validate" { Validate-Configs }
    "rules" { List-Rules }
    default {
        Write-Host ""
        Write-Host "Config Manager" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Commands:" -ForegroundColor Yellow
        Write-Host "  status   - Show config status (default)"
        Write-Host "  view     - View specific config"
        Write-Host "  backup   - Backup all configs"
        Write-Host "  validate - Validate configurations"
        Write-Host "  rules    - List rule files"
        Write-Host ""
    }
}
