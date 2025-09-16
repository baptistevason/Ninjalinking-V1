@echo off
echo ========================================
echo    PACKAGING POUR DISTRIBUTION
echo ========================================
echo.

set "package_name=ninjalinking-saas-v1.0.0"
set "package_dir=%package_name%"

echo Creation du package de distribution...
echo Nom du package: %package_name%
echo.

echo [1/4] Nettoyage des fichiers temporaires...
if exist "%package_dir%" rmdir /s /q "%package_dir%"
if exist "%package_name%.zip" del "%package_name%.zip"

echo [2/4] Creation du dossier de distribution...
mkdir "%package_dir%"

echo [3/4] Copie des fichiers essentiels...
xcopy /E /I /Y "client" "%package_dir%\client"
xcopy /E /I /Y "server" "%package_dir%\server"
xcopy /E /I /Y "scripts" "%package_dir%\scripts"

copy "package.json" "%package_dir%\"
copy "package-lock.json" "%package_dir%\"
copy "README.md" "%package_dir%\"
copy "INSTALLATION.md" "%package_dir%\"
copy "config.example.env" "%package_dir%\"
copy "docker-compose.yml" "%package_dir%\"
copy "Dockerfile" "%package_dir%\"

copy "*.bat" "%package_dir%\"
copy "*.sh" "%package_dir%\"

echo [4/4] Suppression des node_modules pour reduire la taille...
if exist "%package_dir%\client\node_modules" rmdir /s /q "%package_dir%\client\node_modules"
if exist "%package_dir%\server\node_modules" rmdir /s /q "%package_dir%\server\node_modules"
if exist "%package_dir%\node_modules" rmdir /s /q "%package_dir%\node_modules"

echo.
echo ✓ Package cree avec succes!
echo.
echo Dossier: %package_dir%
echo.
echo Pour distribuer:
echo 1. Compressez le dossier %package_dir%
echo 2. Envoyez-le a l'utilisateur
echo 3. L'utilisateur doit executer install.bat
echo.
echo Fichiers inclus:
echo - Scripts d'installation automatique
echo - Documentation complete
echo - Configuration d'exemple
echo - Code source complet
echo.
pause







