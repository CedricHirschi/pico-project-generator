@echo off

set startdir=%cd%

rem Ask user to enter project name
set /p projectname=Enter project name:

rem Download create project script
rem curl -o pico-create-project.bat https://gist.githubusercontent.com/CedricHirschi/fe132e3bcdf37761436970c218209880/raw/f3208275074288b590e21d623ce3f86b6ef65f51/pico-create-project.bat

rem Run pico-create-project.bat
call pico-create-project.bat %projectname% %cd%

rem Delete pico-create-project.bat
cd %startdir%
rem del pico-create-project.bat
rem del pico-create-project-here.bat
