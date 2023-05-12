@echo off

set startdir=%cd%

rem Ask user to enter project name
set /p projectname=Enter project name:

rem Download create project script
curl -o pico-create-project.bat https://raw.githubusercontent.com/CedricHirschi/pico-project-generator/main/pico-create-project.bat

rem Run pico-create-project.bat
call pico-create-project.bat %projectname% %cd%

rem Delete pico-create-project.bat
cd %startdir%
del pico-create-project.bat
rem del pico-create-project-here.bat
