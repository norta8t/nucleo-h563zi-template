# fix-paths.ps1 - Fix absolute paths in STM32CubeIDE project after clone/rename
# Usage: .\fix-paths.ps1 [NEW_PROJECT_NAME] [NEW_WORKSPACE_PATH]
# If args omitted, uses current dir for project name and auto-detects workspace.
# Run in PowerShell: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser (once, if blocked)

param(
    [string]$PROJECT_NAME = (Split-Path -Leaf $PWD),
    [string]$WORKSPACE_PATH = (Split-Path -Parent $PWD)  # Assumes workspace is parent of project dir
)

$OLD_PROJECT_NAME = "nucleo-h563zi-template"  # Change to match your template's original name
$OLD_WORKSPACE_PATH = "C:\path\to\original\workspace"  # Update with absolute path from your template (find via .cproject)

Write-Host "Fixing paths for project: $PROJECT_NAME"
Write-Host "New workspace: $WORKSPACE_PATH"
Write-Host "Old project: $OLD_PROJECT_NAME"
Write-Host "Old workspace: $OLD_WORKSPACE_PATH"

# Normalize paths to Windows style (backslashes) for consistency
function Normalize-Path {
    param([string]$Path)
    return $Path -replace '\\', '\ ' -replace '/', '\'
}

# Function to replace paths in a file
function Fix-File {
    param([string]$FilePath)
    if (Test-Path $FilePath) {
        Write-Host "Updating $FilePath..."
        $content = Get-Content $FilePath -Raw
        $oldWsProj = (Normalize-Path "$OLD_WORKSPACE_PATH/$OLD_PROJECT_NAME")
        $newWsProj = (Normalize-Path "$WORKSPACE_PATH/$PROJECT_NAME")
        $content = $content -replace [regex]::Escape($oldWsProj), $newWsProj
        $content = $content -replace [regex]::Escape($OLD_PROJECT_NAME), $PROJECT_NAME
        $content = $content -replace [regex]::Escape($OLD_WORKSPACE_PATH), $WORKSPACE_PATH
        # Handle backslash variants
        $content = $content -replace [regex]::Escape($oldWsProj -replace '/', '\\'), $newWsProj -replace '/', '\\'
        $content | Set-Content $FilePath -NoNewline
    }
}

# Target files to fix (add more as needed)
Fix-File ".cproject"
Fix-File "Debug\Makefile"
Fix-File "Release\Makefile"
Fix-File "STM32H563ZITX_FLASH.ld"  # Adjust for your MCU's linker script
Get-ChildItem -Recurse -Filter "*.mk" | ForEach-Object { Fix-File $_.FullName }
Get-ChildItem -Path ".settings" -Recurse -Filter "*.prefs" | ForEach-Object { Fix-File $_.FullName }

Write-Host "Paths fixed! Clean and rebuild in STM32CubeIDE."