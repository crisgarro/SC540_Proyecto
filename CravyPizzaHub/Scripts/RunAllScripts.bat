@echo off

set SCRIPTS_FOLDER=.
set USERNAME=CravyDev
set PASSWORD=abcd1234
set SID=ORCLCDB
set SQLPLUS_PATH=C:\git\Oracle\sqldeveloper-23.1.0.097.1607-x64\sqldeveloper\sqldeveloper\bin\sql.exe
set EXCLUDED_SCRIPT=01-Script_Inicial.sql

REM Ensure previous ScriptOutput.txt is deleted
del ScriptOutput.txt > nul 2>&1

for %%i in (%SCRIPTS_FOLDER%\*.sql) do (
    if /i "%%~nxi" neq "%EXCLUDED_SCRIPT%" (
        echo Running script: %%i
        echo exit | %SQLPLUS_PATH% %USERNAME%/%PASSWORD%@//localhost:1521/%SID% @"%%i" >> ScriptOutput.txt 2>&1
        if %errorlevel% neq 0 (
            echo Error executing script: %%i >> ScriptOutput.txt
        ) else (
            echo Script executed successfully: %%i >> ScriptOutput.txt
        )
    ) else (
        echo Skipping script: %%i
    )
)

echo All scripts processed. Output saved to ScriptOutput.txt.
