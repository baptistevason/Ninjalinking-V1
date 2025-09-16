#!/bin/bash

echo "========================================"
echo "    VÉRIFICATION DES PRÉREQUIS"
echo "========================================"
echo

all_good=1

echo "[1/4] Vérification de Node.js..."
if command -v node &> /dev/null; then
    node_version=$(node --version)
    echo "✓ Node.js $node_version est installé"
else
    echo "❌ Node.js n'est pas installé!"
    echo "   Téléchargez-le depuis: https://nodejs.org/"
    all_good=0
fi

echo
echo "[2/4] Vérification de npm..."
if command -v npm &> /dev/null; then
    npm_version=$(npm --version)
    echo "✓ npm $npm_version est installé"
else
    echo "❌ npm n'est pas installé!"
    all_good=0
fi

echo
echo "[3/4] Vérification des ports..."
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "⚠ Le port 3000 est déjà utilisé"
else
    echo "✓ Le port 3000 est disponible"
fi

if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "⚠ Le port 5000 est déjà utilisé"
else
    echo "✓ Le port 5000 est disponible"
fi

echo
echo "[4/4] Vérification de l'espace disque..."
free_space=$(df . | tail -1 | awk '{print $4}')
if [ "$free_space" -lt 1000000 ]; then
    echo "⚠ Espace disque faible: $free_space KB libres"
else
    echo "✓ Espace disque suffisant"
fi

echo
echo "========================================"
if [ $all_good -eq 1 ]; then
    echo "✓ TOUS LES PRÉREQUIS SONT SATISFAITS"
    echo "Vous pouvez procéder à l'installation!"
else
    echo "❌ CERTAINS PRÉREQUIS MANQUENT"
    echo "Veuillez installer les composants manquants avant de continuer."
fi
echo "========================================"
echo







