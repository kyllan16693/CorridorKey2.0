@echo off
rem CorridorKey 2.0 desktop UI. Double-click it, or drag clips or folders onto it.
cd /d "%~dp0.."

rem uv sync creates .venv; a manual setup may have made venv.
set "VENV=venv"
if exist ".venv\Scripts\pythonw.exe" set "VENV=.venv"
if not exist "%VENV%\Scripts\pythonw.exe" (
    echo No .venv or venv found. Set up the environment as described in README.md first.
    pause
    exit /b 1
)

"%VENV%\Scripts\python.exe" -c "import PySide6" 2>nul && goto run
echo Installing the UI toolkit ^(PySide6^)...
rem uv environments have no pip, so install through uv when it is available.
where uv >nul 2>nul
if not errorlevel 1 (
    uv pip install --python "%VENV%\Scripts\python.exe" PySide6-Essentials || (pause & exit /b 1)
) else (
    "%VENV%\Scripts\python.exe" -m pip install PySide6-Essentials || (pause & exit /b 1)
)

:run
start "" "%VENV%\Scripts\pythonw.exe" -m gui %*
