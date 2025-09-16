@echo off
echo ========================================
echo    DEPLOIEMENT NINJALINKING SAAS
echo ========================================
echo.

echo [1/6] Verification des prerequis...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERREUR: Node.js n'est pas installe!
    echo Veuillez installer Node.js depuis https://nodejs.org/
    pause
    exit /b 1
)

npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERREUR: npm n'est pas installe!
    pause
    exit /b 1
)

echo ✓ Node.js et npm sont installes
echo.

echo [2/6] Installation des dependances du serveur...
cd server
if not exist package.json (
    echo ERREUR: Fichier package.json manquant dans le dossier server!
    pause
    exit /b 1
)

npm install
if %errorlevel% neq 0 (
    echo ERREUR: Echec de l'installation des dependances du serveur!
    pause
    exit /b 1
)
echo ✓ Dependances du serveur installees
echo.

echo [3/6] Installation des dependances du client...
cd ../client
if not exist package.json (
    echo ERREUR: Fichier package.json manquant dans le dossier client!
    pause
    exit /b 1
)

npm install
if %errorlevel% neq 0 (
    echo ERREUR: Echec de l'installation des dependances du client!
    pause
    exit /b 1
)
echo ✓ Dependances du client installees
echo.

echo [4/6] Configuration des variables d'environnement...
cd ../server
if not exist .env (
    echo Creation du fichier .env pour le serveur...
    echo PORT=5000 > .env
    echo NODE_ENV=development >> .env
    echo JWT_SECRET=ninjalinking-secret-key-2024 >> .env
    echo DATABASE_URL=sqlite:./database.sqlite >> .env
    echo ✓ Fichier .env du serveur cree
) else (
    echo ✓ Fichier .env du serveur existe deja
)

cd ../client
if not exist .env.local (
    echo Creation du fichier .env.local pour le client...
    echo NEXT_PUBLIC_API_URL=http://localhost:5000 > .env.local
    echo ✓ Fichier .env.local du client cree
) else (
    echo ✓ Fichier .env.local du client existe deja
)
echo.

echo [5/6] Verification des ports...
netstat -an | findstr :3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ATTENTION: Le port 3000 est deja utilise!
    echo Veuillez fermer l'application qui utilise ce port.
    pause
)

netstat -an | findstr :5000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ATTENTION: Le port 5000 est deja utilise!
    echo Veuillez fermer l'application qui utilise ce port.
    pause
)
echo.

echo [6/6] Demarrage de l'application...
cd ..
echo ✓ Installation terminee avec succes!
echo.
echo ========================================
echo    LANCEMENT DE NINJALINKING SAAS
echo ========================================
echo.
echo L'application va demarrer sur:
echo - Frontend: http://localhost:3000
echo - Backend:  http://localhost:5000
echo.
echo Appuyez sur Ctrl+C pour arreter l'application
echo.

echo Demarrage en cours...
timeout /t 3 /nobreak >nul

npm run dev

if %errorlevel% neq 0 (
    echo.
    echo ERREUR: Echec du demarrage de l'application!
    echo.
    echo Solutions possibles:
    echo 1. Verifiez que les ports 3000 et 5000 sont libres
    echo 2. Relancez le script en tant qu'administrateur
    echo 3. Consultez le guide INSTALLATION.md
    echo.
    pause
    exit /b 1
)

