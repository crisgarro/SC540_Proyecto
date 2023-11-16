@echo off

set SCRIPTS_FOLDER=.
set USERNAME=CravyDev
set PASSWORD=abcd1234
set SID=ORCLCDB
set SQLPLUS_PATH=C:\git\Oracle\sqldeveloper-23.1.0.097.1607-x64\sqldeveloper\sqldeveloper\bin\sql.exe
set EXCLUDED_SCRIPT=01-Script_Inicial.sql FullScript.sql
REM Para no correr los script sin recrear las tablas
REM EXCLUDED_SCRIPT=01-Script_Inicial.sql 02-Script_Creacion_DB.sql

REM Ensure previous ScriptOutput.txt is deleted
del ScriptOutput.txt > nul 2>&1

for %%i in (%SCRIPTS_FOLDER%\*.sql) do (
    set "excludeScript="
    for %%x in (%EXCLUDED_SCRIPT%) do (
        if /i "%%~nxi" equ "%%x" set excludeScript=true
    )
    
    if not defined excludeScript (
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
