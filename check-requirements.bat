@echo off
echo ========================================
echo    VERIFICATION DES PREREQUIS
echo ========================================
echo.

set "all_good=1"

echo [1/4] Verification de Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js n'est pas installe!
    echo    Telechargez-le depuis: https://nodejs.org/
    set "all_good=0"
) else (
    for /f "tokens=*" %%i in ('node --version') do set "node_version=%%i"
    echo ✓ Node.js %node_version% est installe
)

echo.
echo [2/4] Verification de npm...
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm n'est pas installe!
    set "all_good=0"
) else (
    for /f "tokens=*" %%i in ('npm --version') do set "npm_version=%%i"
    echo ✓ npm %npm_version% est installe
)

echo.
echo [3/4] Verification des ports...
netstat -an | findstr :3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ⚠ Le port 3000 est deja utilise
) else (
    echo ✓ Le port 3000 est disponible
)

netstat -an | findstr :5000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ⚠ Le port 5000 est deja utilise
) else (
    echo ✓ Le port 5000 est disponible
)

echo.
echo [4/4] Verification de l'espace disque...
for /f "tokens=3" %%a in ('dir /-c ^| find "bytes free"') do set "free_space=%%a"
if %free_space% lss 1000000000 (
    echo ⚠ Espace disque faible: %free_space% bytes libres
) else (
    echo ✓ Espace disque suffisant
)

echo.
echo ========================================
if %all_good% equ 1 (
    echo ✓ TOUS LES PREREQUIS SONT SATISFAITS
    echo Vous pouvez proceder a l'installation!
) else (
    echo ❌ CERTAINS PREREQUIS MANQUENT
    echo Veuillez installer les composants manquants avant de continuer.
)
echo ========================================
echo.
pause

