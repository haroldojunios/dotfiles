Set-ExecutionPolicy RemoteSigned

if (!(Get-Command choco -errorAction SilentlyContinue))
{
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

  # add choco to path
  $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
  Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  refreshenv
}

if (!(Get-Command age -errorAction SilentlyContinue))
{
  choco install age.portable -y
}

if (!(Get-Command gsudo -errorAction SilentlyContinue))
{
  choco install gsudo -y
}

if (!(Get-Command chezmoi -errorAction SilentlyContinue))
{
  choco install chezmoi -y
}


if (gsudo config | Select-String -Pattern "Explicit") {
  gsudo config CacheMode Auto
  gsudo config CacheDuration "00:20:00"
}

chezmoi init --apply haroldojunios
