---
layout: post
date: "2026-02-27"
categories:
    - technology
    - code
    - windows
title: Crudely capture working files
---
We recently had a situation where a tool was:

1. Creating a work directory, e.g. `job-1234` (randomly generated)
2. Doing some stuff there
3. Deleting the work directory

That middle step wasn't working quite right so we wanted to inspect it before it vanished. For complicated reasons, it was tricky to pause the tool before step 3 so here's what we did:

Watch for the working folder and just clone it every 1 second:

```ps
# PowerShell script to backup directories with timestamp extensions
# Usage: 
#   cd C:\path\to\directory
#   .\monitor-folder.ps1

# Use current working directory where the script is run from
$TargetDirectory = Get-Location

Write-Host "Monitoring directory: $TargetDirectory" -ForegroundColor Green
Write-Host "Backing up directories every 1 second..." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop..." -ForegroundColor Yellow
Write-Host ""

while ($true) {
    $timestamp = Get-Date -Format "HH.mm.ss"
    
    # Get all directories directly in the target directory (not recursive)
    $directories = Get-ChildItem -Path $TargetDirectory -Directory
    
    foreach ($dir in $directories) {
        # Skip directories that are already backups
        if ($dir.Name -like "*.bak") {
            continue
        }
        
        $backupName = "$($dir.Name).$timestamp.bak"
        $backupPath = Join-Path $TargetDirectory $backupName
        
        try {
            # Copy directory recursively - continue even if some files are in use
            Copy-Item -Path $dir.FullName -Destination $backupPath -Recurse -Force -ErrorAction Continue
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Backed up: $($dir.Name) -> $backupName" -ForegroundColor Cyan
        }
        catch {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] WARNING: Partial backup of $($dir.Name) (some files may be skipped)" -ForegroundColor Yellow
        }
    }
    
    Start-Sleep -Seconds 1
}

```

With that running, the job came and went, and left behind what we needed:

```
- job-1234-10.57.12.bak
- job-1234-10.57.13.bak
- job-1234-10.57.14.bak
- job-1234-10.57.15.bak
- job-1234-10.57.16.bak
- job-1234-10.57.17.bak
```

There are lots of ways to solve this problem, but this one was good enough for what we needed and extremely simple to generate and execute.