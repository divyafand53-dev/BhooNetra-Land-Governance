@echo off
cd /d "%~dp0"
echo ========================================================
echo Starting LAND STACK INDIA Backend & Frontend Application
echo ========================================================
echo.
py -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
pause
