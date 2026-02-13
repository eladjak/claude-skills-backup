# Alert System

param(
    [Parameter(Position=0)]
    [string]$Action = "list",

    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

$DataFile = "$HOME\.claude\data\alerts.json"
$DataDir = Split-Path $DataFile -Parent

if (-not (Test-Path $DataDir)) {
    New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
}

function Get-Data {
    if (Test-Path $DataFile) {
        return Get-Content $DataFile -Raw -Encoding UTF8 | ConvertFrom-Json
    }
    return @{
        alerts = @()
        nextId = 1
    }
}

function Save-Data {
    param($data)
    $data | ConvertTo-Json -Depth 5 | Out-File $DataFile -Encoding UTF8 -Force
}

function Get-Priority {
    param([string]$Msg)
    if ($Msg.StartsWith("!!")) {
        return @{ level = "critical"; display = "[!!]"; color = "Red"; msg = $Msg.Substring(2).Trim() }
    } elseif ($Msg.StartsWith("!")) {
        return @{ level = "high"; display = "[!]"; color = "Yellow"; msg = $Msg.Substring(1).Trim() }
    }
    return @{ level = "normal"; display = "[ ]"; color = "White"; msg = $Msg }
}

function Add-Alert {
    param([string]$Message)

    if ([string]::IsNullOrWhiteSpace($Message)) {
        Write-Host "[ERROR] Please provide alert message" -ForegroundColor Red
        return
    }

    $data = Get-Data
    $priority = Get-Priority $Message

    $alert = @{
        id = $data.nextId
        message = $priority.msg
        priority = $priority.level
        created = Get-Date -Format "yyyy-MM-dd HH:mm"
        done = $false
    }

    $data.alerts += $alert
    $data.nextId++
    Save-Data $data

    Write-Host ""
    Write-Host "[ALERT ADDED] #$($alert.id)" -ForegroundColor Green
    Write-Host "  $($priority.display) $($priority.msg)" -ForegroundColor $priority.color
    Write-Host "  Priority: $($priority.level)" -ForegroundColor Gray
    Write-Host ""
}

function Show-List {
    $data = Get-Data
    $pending = @($data.alerts | Where-Object { -not $_.done })

    Write-Host ""
    Write-Host "===== PENDING ALERTS ($($pending.Count)) =====" -ForegroundColor Cyan
    Write-Host ""

    if ($pending.Count -eq 0) {
        Write-Host "No pending alerts." -ForegroundColor Green
        Write-Host ""
        return
    }

    # Sort by priority
    $critical = @($pending | Where-Object { $_.priority -eq "critical" })
    $high = @($pending | Where-Object { $_.priority -eq "high" })
    $normal = @($pending | Where-Object { $_.priority -eq "normal" })

    if ($critical.Count -gt 0) {
        Write-Host "CRITICAL:" -ForegroundColor Red
        foreach ($a in $critical) {
            Write-Host "  #$($a.id) [!!] $($a.message)" -ForegroundColor Red
        }
        Write-Host ""
    }

    if ($high.Count -gt 0) {
        Write-Host "HIGH PRIORITY:" -ForegroundColor Yellow
        foreach ($a in $high) {
            Write-Host "  #$($a.id) [!] $($a.message)" -ForegroundColor Yellow
        }
        Write-Host ""
    }

    if ($normal.Count -gt 0) {
        Write-Host "NORMAL:" -ForegroundColor White
        foreach ($a in $normal) {
            Write-Host "  #$($a.id) [ ] $($a.message)" -ForegroundColor White
        }
        Write-Host ""
    }
}

function Mark-Done {
    param([string]$IdStr)

    $id = 0
    if (-not [int]::TryParse($IdStr, [ref]$id)) {
        Write-Host "[ERROR] Please provide valid alert ID" -ForegroundColor Red
        return
    }

    $data = Get-Data
    $found = $false

    for ($i = 0; $i -lt $data.alerts.Count; $i++) {
        if ($data.alerts[$i].id -eq $id) {
            $data.alerts[$i].done = $true
            $data.alerts[$i].doneAt = Get-Date -Format "yyyy-MM-dd HH:mm"
            $found = $true
            break
        }
    }

    if ($found) {
        Save-Data $data
        Write-Host ""
        Write-Host "[DONE] Alert #$id marked as complete" -ForegroundColor Green
        Write-Host ""
    } else {
        Write-Host "[ERROR] Alert #$id not found" -ForegroundColor Red
    }
}

function Clear-All {
    $data = Get-Data
    $pending = @($data.alerts | Where-Object { -not $_.done })

    if ($pending.Count -eq 0) {
        Write-Host "[INFO] No pending alerts to clear" -ForegroundColor Gray
        return
    }

    # Mark all as done
    for ($i = 0; $i -lt $data.alerts.Count; $i++) {
        if (-not $data.alerts[$i].done) {
            $data.alerts[$i].done = $true
            $data.alerts[$i].doneAt = Get-Date -Format "yyyy-MM-dd HH:mm"
        }
    }

    Save-Data $data

    Write-Host ""
    Write-Host "[CLEARED] $($pending.Count) alert(s) marked as done" -ForegroundColor Green
    Write-Host ""
}

function Show-Summary {
    $data = Get-Data
    $pending = @($data.alerts | Where-Object { -not $_.done })
    $critical = @($pending | Where-Object { $_.priority -eq "critical" })

    if ($critical.Count -gt 0) {
        Write-Host "[!!] $($critical.Count) CRITICAL alert(s)!" -ForegroundColor Red
    } elseif ($pending.Count -gt 0) {
        Write-Host "[$($pending.Count)] Pending alert(s)" -ForegroundColor Yellow
    } else {
        Write-Host "[OK] No pending alerts" -ForegroundColor Green
    }
}

# Main
$argText = $Args -join " "

switch ($Action) {
    "add" { Add-Alert -Message $argText }
    "list" { Show-List }
    "done" { Mark-Done -IdStr $argText }
    "clear" { Clear-All }
    "summary" { Show-Summary }
    default {
        if ($Action -and $Action -notmatch '^(add|list|done|clear|summary)$') {
            Add-Alert -Message "$Action $argText".Trim()
        } else {
            Show-List
        }
    }
}
