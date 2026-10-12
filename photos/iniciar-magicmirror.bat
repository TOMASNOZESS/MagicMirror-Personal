@echo off
cd /d "C:\Users\Utilizador\MagicMirror"

:: Fecha instancias anteriores do Electron
taskkill /F /IM electron.exe >nul 2>&1

:: Sorteia a foto de fundo
call "C:\Users\Utilizador\MagicMirror\photos\escolhe_fundo.bat"

:: Toca o som de alarme ate ao fim
powershell -c "(New-Object System.Media.SoundPlayer 'C:\Windows\Media\Alarm01.wav').PlaySync()"

:: Arranca o MagicMirror
cd /d "C:\Users\Utilizador\MagicMirror"
call npm run start:windows