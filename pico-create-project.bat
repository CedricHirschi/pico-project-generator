@echo off

rem Check if the PICO_SDK_PATH environment variable is set
if "%PICO_SDK_PATH%"=="" (
    rem Include and run contents of pico-env.cmd
    call "C:\Program Files\Raspberry Pi\Pico SDK v1.5.0\pico-env.cmd"
    rem Run this script again with the arguments
    %0 %1 %2
)

rem First argument is the project name, if not specified, use my-project
if "%1"=="" (
    set PROJECT_NAME=my-project
) else (
    set PROJECT_NAME=%1
)
echo using project name: %PROJECT_NAME%

rem Second argument is the path to the Projects folder, if not specified, use Desktop
if "%2"=="" (
    set PROJECT_PATH=%USERPROFILE%\Desktop
) else (
    set PROJECT_PATH=%2
)
echo using project path: %PROJECT_PATH%

echo PICO_SDK_PATH: %PICO_SDK_PATH%
echo PICO_EXAMPLES_PATH: %PICO_EXAMPLES_PATH%

rem Create the project folder
echo Creating project "%PROJECT_PATH%\%PROJECT_NAME%"
mkdir "%PROJECT_PATH%\%PROJECT_NAME%"

rem Change to the project folder
echo Changing to "%PROJECT_PATH%\%PROJECT_NAME%"
cd /d "%PROJECT_PATH%\%PROJECT_NAME%"

echo Current directory: %CD%

rem Copy the pico SDK files
echo Copying pico SDK files
copy %PICO_EXAMPLES_PATH%\pico_sdk_import.cmake .
copy %PICO_EXAMPLES_PATH%\pico_extras_import_optional.cmake .

rem Copy the VSCODE folder
mkdir .vscode
copy %PICO_EXAMPLES_PATH%\.vscode .vscode

rem Create CMakelists.txt
echo Creating CMakelists.txt
echo cmake_minimum_required(VERSION 3.13) > CMakeLists.txt
echo. >> CMakeLists.txt
echo include(pico_sdk_import.cmake) >> CMakeLists.txt
echo include(pico_extras_import_optional.cmake) >> CMakeLists.txt
echo. >> CMakeLists.txt
echo project(%PROJECT_NAME%) >> CMakeLists.txt
echo. >> CMakeLists.txt
echo pico_sdk_init() >> CMakeLists.txt
echo. >> CMakeLists.txt
echo add_executable(%PROJECT_NAME% main.c) >> CMakeLists.txt
echo target_link_libraries(%PROJECT_NAME% pico_stdlib) >> CMakeLists.txt
echo. >> CMakeLists.txt
echo pico_enable_stdio_usb(%PROJECT_NAME% 0) >> CMakeLists.txt
echo pico_enable_stdio_uart(%PROJECT_NAME% 1) >> CMakeLists.txt

rem Create the blink.c file (copy from the example)
echo Creating main.c
copy %PICO_EXAMPLES_PATH%\blink\blink.c main.c

rem Create open-project.bat
echo Creating open-project.bat
echo @echo off > open-project.bat
echo echo Opening the pico developer command prompt >> open-project.bat
echo call "C:\Program Files\Raspberry Pi\Pico SDK v1.5.0\pico-env.cmd" >> open-project.bat
echo. >> open-project.bat
echo where code-insiders >nul 2>nul >> open-project.bat
echo if %%ERRORLEVEL%% EQU 0 ( >> open-project.bat
echo     echo VSCode insiders is available. Use it instead of VSCode? (y/n) >> open-project.bat
echo     set /p use_code_insiders= >> open-project.bat
echo     if /i {%%use_code_insiders%%}=={y} (set code_command=code-insiders) else (set code_command=code) >> open-project.bat
echo ) else (set code_command=code) >> open-project.bat
echo. >> open-project.bat
echo echo Starting %%code_command%% >> open-project.bat
echo %%code_command%% . >> open-project.bat

rem Start VSCODE with the blink example
echo Starting VSCODE
.\open-project.bat