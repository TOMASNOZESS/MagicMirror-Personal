@echo off
setlocal enabledelayedexpansion

:: Definição dos caminhos absolutos
set "TARGET_DIR=C:\Users\Utilizador\MagicMirror\photos"
set "DEST_DIR=C:\Users\Utilizador\MagicMirror\modules\fundo"
set "CSS_DIR=C:\Users\Utilizador\MagicMirror\config"

cd /d "%TARGET_DIR%"

:: Procura as imagens na pasta photos
set count=0
for %%f in (*.jpg *.jpeg *.png) do (
    set /a count+=1
    set "img[!count!]=%%f"
)

if %count%==0 (
    echo Nenhuma imagem encontrada em %TARGET_DIR%!
    exit /b
)

:: Seleção aleatória
set /a "rand=%RANDOM% %% count + 1"
set "SELECTED_IMG=!img[%rand%]!"

:: Copia a imagem selecionada
copy /Y "%TARGET_DIR%\!SELECTED_IMG!" "%DEST_DIR%\fundo-atual.jpg" >nul
echo Fundo definido: !SELECTED_IMG!

:: Cores padrão
set "MAIN_COLOR=#00ffff"
set "MAIN_SHADOW=rgba(0, 255, 255, 0.6)"

:: Deteta a cor pelo nome do ficheiro da imagem
echo !SELECTED_IMG! | findstr /i "azul" >nul
if !errorlevel!==0 (
    set "MAIN_COLOR=#00d4ff"
    set "MAIN_SHADOW=rgba(0, 212, 255, 0.7)"
)

echo !SELECTED_IMG! | findstr /i "vermelho" >nul
if !errorlevel!==0 (
    set "MAIN_COLOR=#ff2a36"
    set "MAIN_SHADOW=rgba(255, 42, 54, 0.7)"
)

echo !SELECTED_IMG! | findstr /i "amarelo" >nul
if !errorlevel!==0 (
    set "MAIN_COLOR=#ffe600"
    set "MAIN_SHADOW=rgba(255, 230, 0, 0.7)"
)

echo !SELECTED_IMG! | findstr /i "rosa" >nul
if !errorlevel!==0 (
    set "MAIN_COLOR=#ff1493"
    set "MAIN_SHADOW=rgba(255, 20, 147, 0.7)"
)

echo !SELECTED_IMG! | findstr /i "preto" >nul
if !errorlevel!==0 (
    set "MAIN_COLOR=#000000"
    set "MAIN_SHADOW=rgba(255, 255, 255, 0.4)"
)

:: Gera o ficheiro cores-atuais.css na pasta config do MagicMirror
(
echo :root {
echo   --main-color: !MAIN_COLOR!;
echo   --main-shadow: !MAIN_SHADOW!;
echo }
) > "%CSS_DIR%\cores-atuais.css"

echo Cores atualizadas em %CSS_DIR%\cores-atuais.css!