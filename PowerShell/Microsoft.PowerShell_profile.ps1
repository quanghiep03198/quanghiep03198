# --- Module: Git prompt ---
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
}

# --- Module: Docker auto-completion ---
if (Get-Module -ListAvailable -Name DockerCompletion) {
    Import-Module DockerCompletion
}

# --- Oh My Posh Theme ---
if ($env:POSH_THEMES_PATH) {
    $theme = Join-Path $env:POSH_THEMES_PATH "agnoster.omp.json"
    if (Test-Path $theme) {
        oh-my-posh init pwsh --config $theme | Invoke-Expression
    } else {
        Write-Host "Theme file not found: $theme"
    }
} else {
    Write-Host "POSH_THEMES_PATH environment variable is not set."
}

# --- PSReadLine Enhancements ---
if (Get-Module -ListAvailable -Name PSReadLine) {
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}

# --- Git status context alias ---
if (Get-Command Set-PoshGitStatus -ErrorAction SilentlyContinue) {
    New-Alias -Name 'Set-PoshContext' -Value 'Set-PoshGitStatus' -Scope Global -Force
}

# --- Alias: pn → pnpm ---
if (Get-Command pnpm -ErrorAction SilentlyContinue) {
    Set-Alias -Name pn -Value pnpm -Scope Global -Force
}
