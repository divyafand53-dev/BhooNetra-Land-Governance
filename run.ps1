# Run Land Stack India from anywhere
Set-Location -Path $PSScriptRoot
Write-Host "========================================================" -ForegroundColor Green
Write-Host "Starting LAND STACK INDIA Backend & Frontend Application" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host "Interactive UI: http://localhost:8000" -ForegroundColor Cyan
Write-Host "Swagger Docs:   http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host ""
py -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
