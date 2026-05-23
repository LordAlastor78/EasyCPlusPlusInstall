@echo off
setlocal enabledelayedexpansion

:: ==========================================
:: 1. Selección de idioma
:: ==========================================
set "LANG=es"
set /p "LANG=Seleccione idioma / Select language [es/en]: "
if /i not "!LANG!"=="en" set "LANG=es"

:: ==========================================
:: 2. Mapeo de mensajes según idioma
:: ==========================================
if /i "!LANG!"=="en" (
    set "L_TITLE= C++ Compiler Installer (GCC/MinGW)"
    set "L_LINE==========================================="
    set "L_ADMIN_REQ=[!] Error: Administrator privileges required."
    set "L_ADMIN_RUN=    Right-click script -> Run as administrator"
    set "L_WINGET_MISSING=[!] winget not found. Update Windows or install from Microsoft Store."
    set "L_INSTALL_MSYS2=[+] Downloading and installing MSYS2..."
    set "L_MSYS2_FAIL=[!] Failed to install MSYS2. Check connection or winget logs."
    set "L_SET_PATH=[+] Adding MinGW path to system PATH..."
    set "L_INSTALL_GCC=[+] Installing GCC and base C++ tools..."
    set "L_GCC_FAIL=[!] Error installing GCC via pacman."
    set "L_VERIFY=[+] Verifying installation..."
    set "L_OK=[OK] C++ compiler installed successfully."
    set "L_EXEC=    Executable:"
    set "L_VER=    Version:"
    set "L_RESTART=[!] IMPORTANT: Restart terminal/IDE for PATH changes to take effect."
    set "L_VERIFY_FAIL=[!] Verification failed. Ensure MSYS2 is installed in C:\msys64"
) else (
    set "L_TITLE= Instalador de Compilador C++ (GCC/MinGW)"
    set "L_LINE==========================================="
    set "L_ADMIN_REQ=[!] Error: Se requieren permisos de administrador."
    set "L_ADMIN_RUN=    Haz clic derecho en el script -> Ejecutar como administrador"
    set "L_WINGET_MISSING=[!] winget no detectado. Actualiza Windows o instala desde Microsoft Store."
    set "L_INSTALL_MSYS2=[+] Descargando e instalando MSYS2..."
    set "L_MSYS2_FAIL=[!] Fallo al instalar MSYS2. Revisa conexión o logs de winget."
    set "L_SET_PATH=[+] Agregando ruta de MinGW al PATH del sistema..."
    set "L_INSTALL_GCC=[+] Instalando GCC y herramientas base de C++..."
    set "L_GCC_FAIL=[!] Error instalando GCC vía pacman."
    set "L_VERIFY=[+] Verificando instalación..."
    set "L_OK=[OK] Compilador C++ instalado correctamente."
    set "L_EXEC=    Ejecutable:"
    set "L_VER=    Versión:"
    set "L_RESTART=[!] IMPORTANTE: Reinicia terminal/IDE para que el PATH surta efecto."
    set "L_VERIFY_FAIL=[!] Verificación fallida. Asegúrate que MSYS2 esté en C:\msys64"
)

echo !L_LINE!
echo !L_TITLE!
echo !L_LINE!
echo.

set "MINGW_BIN=C:\msys64\mingw64\bin"

:: 1. Verificar permisos de administrador
net session >nul 2>&1
if !errorlevel! neq 0 (
    echo !L_ADMIN_REQ!
    echo !L_ADMIN_RUN!
    pause & exit /b 1
)

:: 2. Verificar disponibilidad de winget
winget --version >nul 2>&1
if !errorlevel! neq 0 (
    echo !L_WINGET_MISSING!
    pause & exit /b 1
)

:: 3. Instalar MSYS2
echo !L_INSTALL_MSYS2!
winget install --id MSYS2.MSYS2 -e --accept-source-agreements --accept-package-agreements >nul 2>&1
if !errorlevel! neq 0 (
    echo !L_MSYS2_FAIL!
    pause & exit /b 1
)

:: 4. Configurar PATH (nivel sistema)
echo !L_SET_PATH!
setx PATH "!PATH!;!MINGW_BIN!" /M >nul 2>&1

:: 5. Instalar GCC vía pacman
echo !L_INSTALL_GCC!
timeout /t 3 /nobreak >nul
C:\msys64\usr\bin\bash.exe --login -c "pacman -Sy --noconfirm mingw-w64-x86_64-gcc" >nul 2>&1
if !errorlevel! neq 0 (
    echo !L_GCC_FAIL!
    pause & exit /b 1
)

:: 6. Verificación final
echo !L_VERIFY!
if exist "!MINGW_BIN!\g++.exe" (
    echo.
    echo !L_OK!
    echo !L_EXEC! !MINGW_BIN!\g++.exe
    echo !L_VER!
    "!MINGW_BIN!\g++.exe" --version | findstr /C:"g++"
    echo.
    echo !L_RESTART!
) else (
    echo !L_VERIFY_FAIL!
)

echo.
pause