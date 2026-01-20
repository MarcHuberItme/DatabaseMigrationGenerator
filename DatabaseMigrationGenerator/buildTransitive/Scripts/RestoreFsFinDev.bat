@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0RestoreFsFinDev.ps1"
powershell.exe -ExecutionPolicy Bypass -File "%~dp0SetRegistryItemsForDataAccess.ps1"
powershell.exe -ExecutionPolicy Bypass -File "%~dp0SetZzParameter.ps1"
pause