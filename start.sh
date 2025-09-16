#!/bin/bash

echo "========================================"
echo "    DÉMARRAGE RAPIDE NINJALINKING"
echo "========================================"
echo

echo "Vérification des dépendances..."
if [ ! -d "server/node_modules" ]; then
    echo "Installation des dépendances du serveur..."
    cd server
    npm install
    cd ..
fi

if [ ! -d "client/node_modules" ]; then
    echo "Installation des dépendances du client..."
    cd client
    npm install
    cd ..
fi

echo
echo "Démarrage de l'application..."
echo "- Frontend: http://localhost:3000"
echo "- Backend:  http://localhost:5000"
echo
echo "Appuyez sur Ctrl+C pour arrêter"
echo

npm run dev







