@echo off
echo ========================================
echo    INSTALLATION RAPIDE NINJALINKING
echo ========================================
echo.

echo Cette installation va:
echo 1. Verifier les prerequis
echo 2. Installer toutes les dependances
echo 3. Configurer l'environnement
echo 4. Lancer l'application
echo.

set /p choice="Voulez-vous continuer? (O/N): "
if /i "%choice%" neq "O" (
    echo Installation annulee.
    pause
    exit /b 0
)

echo.
echo Demarrage de l'installation...
echo.

call deploy.bat

echo.
echo ========================================
echo    INSTALLATION TERMINEE
echo ========================================
echo.
echo L'application NinjaLinking est maintenant disponible:
echo - Frontend: http://localhost:3000
echo - Backend:  http://localhost:5000
echo.
echo Pour relancer l'application plus tard:
echo 1. Ouvrez un terminal dans ce dossier
echo 2. Tapez: npm run dev
echo.
echo Pour plus d'informations, consultez INSTALLATION.md
echo.
pause

