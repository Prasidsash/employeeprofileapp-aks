@echo off
REM Define your project root once
set PROJECT_ROOT=D:\2026\Project-EmpProfApp\AzureDevops-AKS\employeeprofileapp-aks

REM Launch Windows Terminal with startup tabs using the variable
wt ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%\terraform\bootstrap\backend" --title "BACKEND" ; ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%\terraform\infra\dev" --title "INFRA" ; ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%" --title "PROJ-HOME" ; ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%\helm\employeeprofileapp" --title "HELM" ; ^
  new-tab -p "Windows PowerShell" -d "C:\Users\aixra" --title "OS HOME-DIR" ; ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%\azure-pipelines" --title "PIPELINES" ; ^
  new-tab -p "Windows PowerShell" -d "%PROJECT_ROOT%" --title "GIT"
  