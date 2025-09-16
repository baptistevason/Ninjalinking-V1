@echo off
echo ========================================
echo    PREPARATION POUR INSTALLATION CURSOR
echo ========================================
echo.

echo Cette preparation va:
echo 1. Creer un dossier propre sans node_modules
echo 2. Copier tous les fichiers sources
echo 3. Preparer les fichiers de configuration
echo.

set /p choice="Voulez-vous continuer? (O/N): "
if /i "%choice%" neq "O" (
    echo Preparation annulee.
    pause
    exit /b 0
)

echo.
echo Creation du dossier de distribution...
if exist "ninjalinking-saas-clean" rmdir /s /q "ninjalinking-saas-clean"
mkdir "ninjalinking-saas-clean"

echo.
echo Copie des fichiers sources...
xcopy /E /I /H /Y "client" "ninjalinking-saas-clean\client"
xcopy /E /I /H /Y "server" "ninjalinking-saas-clean\server"
xcopy /E /I /H /Y "scripts" "ninjalinking-saas-clean\scripts"

echo.
echo Copie des fichiers de configuration...
copy "package.json" "ninjalinking-saas-clean\"
copy "package-lock.json" "ninjalinking-saas-clean\"
copy "config.example.env" "ninjalinking-saas-clean\"
copy "docker-compose.yml" "ninjalinking-saas-clean\"
copy "Dockerfile" "ninjalinking-saas-clean\"
copy "nginx.conf" "ninjalinking-saas-clean\"
copy "README.md" "ninjalinking-saas-clean\"
copy "DEPLOYMENT.md" "ninjalinking-saas-clean\"
copy "DEPLOYMENT-GUIDE.md" "ninjalinking-saas-clean\"
copy "INSTALLATION.md" "ninjalinking-saas-clean\"
copy "LICENSE" "ninjalinking-saas-clean\"
copy "CONTRIBUTING.md" "ninjalinking-saas-clean\"
copy "*.bat" "ninjalinking-saas-clean\"
copy "*.sh" "ninjalinking-saas-clean\"

echo.
echo Suppression des dossiers node_modules...
if exist "ninjalinking-saas-clean\client\node_modules" rmdir /s /q "ninjalinking-saas-clean\client\node_modules"
if exist "ninjalinking-saas-clean\server\node_modules" rmdir /s /q "ninjalinking-saas-clean\server\node_modules"

echo.
echo Creation des fichiers de configuration par defaut...
echo PORT=5000 > "ninjalinking-saas-clean\server\.env"
echo NODE_ENV=development >> "ninjalinking-saas-clean\server\.env"
echo JWT_SECRET=ninjalinking-secret-key-2024 >> "ninjalinking-saas-clean\server\.env"
echo DATABASE_URL=sqlite:./database.sqlite >> "ninjalinking-saas-clean\server\.env"
echo CORS_ORIGIN=http://localhost:3000 >> "ninjalinking-saas-clean\server\.env"

echo NEXT_PUBLIC_API_URL=http://localhost:5000 > "ninjalinking-saas-clean\client\.env.local"
echo NEXT_PUBLIC_APP_NAME=NinjaLinking >> "ninjalinking-saas-clean\client\.env.local"

echo.
echo ========================================
echo    PREPARATION TERMINEE
echo ========================================
echo.
echo Le dossier 'ninjalinking-saas-clean' est pret pour l'installation avec Cursor.
echo.
echo Instructions pour l'installation sur le nouvel ordinateur:
echo 1. Copiez le dossier 'ninjalinking-saas-clean' sur le nouvel ordinateur
echo 2. Ouvrez Cursor
echo 3. File > Open Folder > Selectionnez le dossier ninjalinking-saas-clean
echo 4. Ouvrez le terminal dans Cursor (Ctrl+`)
echo 5. Executez: npm run install-all
echo 6. Executez: npm run dev
echo.
pause





