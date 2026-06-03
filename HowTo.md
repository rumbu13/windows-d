# How to generate metadata (Windows.Win32.winmd)

## Get the code

```
git clone https://github.com/microsoft/win32metadata
```

## Build

Open PowerShell console (PowerShell 7+ required).

```PowerShell
cd win32metadata
DoAll.ps1
```

Metadata files will be created at

```
bin\Windows.Win32.winmd
bin\Microsoft.Dia.winmd
```

## Possible errors

### Running scripts is disabled

Error message:

> DoAll.ps1 cannot be loaded because running scripts is disabled on this system

Solution:

```PowerShell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### PowerShell version issue

Error message:

> The script 'DoAll.ps1' cannot be run because it contained a "#requires" statement for Windows PowerShell 7.0

Solution: install PowerShell 7.

```PowerShell
winget search --id Microsoft.PowerShell --exact
winget install --id Microsoft.PowerShell --source winget
```

### Required components missing

Install required components.

```
.\scripts\Install-VS.ps1
winget install Microsoft.DotNet.SDK.8
```

# windows-d

git config --global core.longpaths true
git submodule update --init --recursive

