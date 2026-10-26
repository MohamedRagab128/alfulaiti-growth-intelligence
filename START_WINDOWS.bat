@echo off
setlocal
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  py -3 -m venv .venv
  if errorlevel 1 py -3.12 -m venv .venv
  if errorlevel 1 (echo Python 3.11+ is required.& pause & exit /b 1)
)
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 (echo Package install failed. Check internet connection.& pause & exit /b 1)
for /f %%P in ('powershell -NoProfile -Command "$ports=8000..8010; foreach($p in $ports){$t=[System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback,$p);try{$t.Start();$t.Stop();Write-Output $p;break}catch{}}"') do set PORT=%%P
if not defined PORT (echo No free port found between 8000 and 8010.& pause & exit /b 1)
echo Starting Alfulaiti Growth Intelligence on port %PORT%...
start "Alfulaiti Growth Intelligence" http://127.0.0.1:%PORT%/
".venv\Scripts\python.exe" -m uvicorn main:app --host 127.0.0.1 --port %PORT%
pause
