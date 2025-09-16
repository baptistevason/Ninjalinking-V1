#!/bin/bash

echo "========================================"
echo "    DEPLOIEMENT NINJALINKING SAAS"
echo "========================================"
echo

echo "[1/6] Verification des prerequis..."

# Vérifier Node.js
if ! command -v node &> /dev/null; then
    echo "ERREUR: Node.js n'est pas installé!"
    echo "Veuillez installer Node.js depuis https://nodejs.org/"
    exit 1
fi

# Vérifier npm
if ! command -v npm &> /dev/null; then
    echo "ERREUR: npm n'est pas installé!"
    exit 1
fi

echo "✓ Node.js et npm sont installés"
echo

echo "[2/6] Installation des dépendances du serveur..."
cd server
if [ ! -f "package.json" ]; then
    echo "ERREUR: Fichier package.json manquant dans le dossier server!"
    exit 1
fi

npm install
if [ $? -ne 0 ]; then
    echo "ERREUR: Échec de l'installation des dépendances du serveur!"
    exit 1
fi
echo "✓ Dépendances du serveur installées"
echo

echo "[3/6] Installation des dépendances du client..."
cd ../client
if [ ! -f "package.json" ]; then
    echo "ERREUR: Fichier package.json manquant dans le dossier client!"
    exit 1
fi

npm install
if [ $? -ne 0 ]; then
    echo "ERREUR: Échec de l'installation des dépendances du client!"
    exit 1
fi
echo "✓ Dépendances du client installées"
echo

echo "[4/6] Configuration des variables d'environnement..."
cd ../server
if [ ! -f ".env" ]; then
    echo "Création du fichier .env pour le serveur..."
    cat > .env << EOF
PORT=5000
NODE_ENV=development
JWT_SECRET=ninjalinking-secret-key-2024
DATABASE_URL=sqlite:./database.sqlite
EOF
    echo "✓ Fichier .env du serveur créé"
else
    echo "✓ Fichier .env du serveur existe déjà"
fi

cd ../client
if [ ! -f ".env.local" ]; then
    echo "Création du fichier .env.local pour le client..."
    echo "NEXT_PUBLIC_API_URL=http://localhost:5000" > .env.local
    echo "✓ Fichier .env.local du client créé"
else
    echo "✓ Fichier .env.local du client existe déjà"
fi
echo

echo "[5/6] Vérification des ports..."
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "ATTENTION: Le port 3000 est déjà utilisé!"
    echo "Veuillez fermer l'application qui utilise ce port."
    read -p "Appuyez sur Entrée pour continuer..."
fi

if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "ATTENTION: Le port 5000 est déjà utilisé!"
    echo "Veuillez fermer l'application qui utilise ce port."
    read -p "Appuyez sur Entrée pour continuer..."
fi
echo

echo "[6/6] Démarrage de l'application..."
cd ..
echo "✓ Installation terminée avec succès!"
echo
echo "========================================"
echo "    LANCEMENT DE NINJALINKING SAAS"
echo "========================================"
echo
echo "L'application va démarrer sur:"
echo "- Frontend: http://localhost:3000"
echo "- Backend:  http://localhost:5000"
echo
echo "Appuyez sur Ctrl+C pour arrêter l'application"
echo

npm run dev








