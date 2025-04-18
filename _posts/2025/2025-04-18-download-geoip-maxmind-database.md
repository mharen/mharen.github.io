---
layout: post
date: "2025-03-11"
categories:
    - technology
    - code
title: Download GEO IP Maxmind Database with Powershell or Bash on Windows/Mac/Linux
---

Here's a tiny shell script for downloading a Maxmind database if you can use something scrappy:

```sh
LICENSE_KEY='YOUR_LICENSE_KEY'

# GeoLite2-City, GeoLite2-Country, GeoIP2-City, GeoIP2-Country"
DATABASE_TYPE='GeoIP2-Country'

MAXMIND_URL="https://download.maxmind.com/app/geoip_download?edition_id=$DATABASE_TYPE&license_key=$LICENSE_KEY&suffix=tar.gz"
CURL_OPTIONS="-Ls --fail"
TAR_OPTIONS="-Ozx --no-anchored $DATABASE_TYPE.mmdb"

curl $CURL_OPTIONS "$MAXMIND_URL" | tar $TAR_OPTIONS > "$DATABASE_TYPE.mmdb"
```

Here's a fuller version with more bells and whistles:

```sh
#!/bin/bash

# exit on error
set -eo pipefail

# Usage message
usage() {
  echo "Usage: $0 <license_key> <database_type> [output]"
  echo "  license_key: Your MaxMind license key"
  echo "  database_type: One of: GeoLite2-City, GeoLite2-Country, GeoIP2-City, GeoIP2-Country"
  echo "  output: Optional. Path to save the downloaded database file"
  exit 1
}

# Check for license_key argument
if [ -z "$1" ]; then
  echo >&2 "Error: MaxMind license key is required"
  usage
fi

license_key="$1"
database_type="$2"
output="$3"

# Validate database type if provided
if [ -n "$database_type" ]; then
  case "$database_type" in
    "GeoLite2-City"|"GeoLite2-Country"|"GeoIP2-City"|"GeoIP2-Country")
      # Valid option
      ;;
    *)
      echo >&2 "Error: Invalid database type '$database_type'"
      usage
      ;;
  esac
fi

# Set default output if not provided
if [ -z "$output" ]; then
  output="$database_type.mmdb"
fi

# check requirements
if ! type curl > /dev/null 2>&1; then
  echo >&2 "curl is required but was not found"
  exit 1
fi

echo "Downloading $database_type database..."

MAXMIND_URL="https://download.maxmind.com/app/geoip_download?edition_id=$database_type&license_key=$license_key&suffix=tar.gz"
CURL_OPTIONS="-Ls --fail"
TAR_OPTIONS="-Ozx --no-anchored $database_type.mmdb"

curl $CURL_OPTIONS "$MAXMIND_URL" | tar $TAR_OPTIONS > "$output"

echo "Saved to $output"
```

If you save that to `update-db.sh` (and run `chmod +x update-db.sh`), then you can invoke it like this:

```sh
./update-db.sh 'your-license-key' GeoIP2-Country bash-country.mmdb
```

--------------------

And here's a Powershell version, which works on Server 2019+ or Windows 10+ (earlier versions of Windows require you to install
`tar` yourself):

```powershell
function Get-MaxMindDatabase {
    <#
    .SYNOPSIS
        Downloads a MaxMind GeoIP database, extracts the .mmdb file, and saves it to the specified location.
    
    .DESCRIPTION
        This function downloads a MaxMind database using a license key, extracts the .mmdb file
        and saves it to the specified output file.
    
    .PARAMETER LicenseKey
        Your MaxMind license key.
    
    .PARAMETER DatabaseType
        The type of database to download. Must be one of: GeoLite2-City, GeoLite2-Country, GeoIP2-City, GeoIP2-Country.
    
    .PARAMETER OutputFile
        The path where the extracted .mmdb file should be saved.
    
    .EXAMPLE
        Get-MaxMindDatabase -LicenseKey "your_license_key" -DatabaseType "GeoLite2-City" -OutputFile "C:\GeoIP\GeoLite2-City.mmdb"
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$LicenseKey,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet("GeoLite2-City", "GeoLite2-Country", "GeoIP2-City", "GeoIP2-Country")]
        [string]$DatabaseType,
        
        [Parameter(Mandatory = $true)]
        [string]$OutputFile
    )
    
    try {
        # Create temporary files
        $tempArchiveFile = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "$([System.Guid]::NewGuid().ToString()).tar.gz")
        $tempDirectory = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.Guid]::NewGuid().ToString())
        
        # Create the download URL
        $downloadUrl = "https://download.maxmind.com/app/geoip_download?edition_id=$DatabaseType&license_key=$LicenseKey&suffix=tar.gz"
        
        Write-Host "Downloading from $downloadUrl to $tempArchiveFile"
        
        # Download the file
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($downloadUrl, $tempArchiveFile)
        
        # Create a temporary directory for extraction
        New-Item -Path $tempDirectory -ItemType Directory -Force | Out-Null
        Write-Host "Extracting tar.gz file to $tempDirectory"
        tar -xzf $tempArchiveFile -C $tempDirectory

        # Check if the extraction was successful
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to extract the downloaded archive."
        }

        # Find the .mmdb file
        $mmdbFile = Get-ChildItem -Path $tempDirectory -Recurse -Filter "*.mmdb" | Select-Object -First 1
        if ($null -eq $mmdbFile) {
            throw "No .mmdb file found in the downloaded archive."
        }
        
        Write-Host "Found .mmdb file: $($mmdbFile.FullName)"
        
        $outputDirectory = [System.IO.Path]::GetDirectoryName($OutputFile)
        if (-not [string]::IsNullOrEmpty($outputDirectory) -and -not (Test-Path -Path $outputDirectory)) {
            throw "Output directory '$outputDirectory' not found."
        }
        
        # Copy the file to the output location
        Copy-Item -Path $mmdbFile.FullName -Destination $OutputFile -Force
        
        Write-Host "Database saved to $OutputFile"
        
        # Return the path to the output file
        return $OutputFile
    }
    catch {
        Write-Error "Failed to download and extract MaxMind database: $_"
        throw
    }
    finally {
        # Clean up temporary files
        if (Test-Path -Path $tempArchiveFile) {
            Remove-Item -Path $tempArchiveFile -Force
        }
        
        if (Test-Path -Path $tempDirectory) {
            Remove-Item -Path $tempDirectory -Recurse -Force
        }
    }
}
```

You can dot-include it, and then run it, like this:

```powershell
# include the function
. ./Get-MaxmindDatabase.ps1

$licenseKey = 'your-license-key'

# download database
Get-MaxmindDatabase -LicenseKey $licenseKey -DatabaseType GeoIP2-Country -OutputFile ./country.mddb
```

**Note:** these `mddb` endpoints only support the suffix `.tar.gz`. There are also `csv` endpoints that support `zip`, but you can't uze `zip` here.

**Note:** at the time of this writing, those databases are approximately this big:

* `GeoIP2-City.mmdb`: 117 MB
* `GeoLite2-City.mmdb`: 58 MB

and: 

* `GeoIP2-Country.mmdb`: 8.6 MB
* `GeoLite2-Country.mmdb`: 8.7 MB (yes, bigger than the non-lite database!)
