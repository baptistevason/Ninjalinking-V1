#!/bin/bash

echo "========================================"
echo "    INSTALLATION RAPIDE NINJALINKING"
echo "========================================"
echo

echo "Cette installation va:"
echo "1. Vérifier les prérequis"
echo "2. Installer toutes les dépendances"
echo "3. Configurer l'environnement"
echo "4. Lancer l'application"
echo

read -p "Voulez-vous continuer? (O/N): " choice
if [[ ! "$choice" =~ ^[Oo]$ ]]; then
    echo "Installation annulée."
    exit 0
fi

echo
echo "Démarrage de l'installation..."
echo

# Rendre le script de déploiement exécutable
chmod +x deploy.sh

# Lancer l'installation
./deploy.sh

echo
echo "========================================"
echo "    INSTALLATION TERMINÉE"
echo "========================================"
echo
echo "L'application NinjaLinking est maintenant disponible:"
echo "- Frontend: http://localhost:3000"
echo "- Backend:  http://localhost:5000"
echo
echo "Pour relancer l'application plus tard:"
echo "1. Ouvrez un terminal dans ce dossier"
echo "2. Tapez: npm run dev"
echo
echo "Pour plus d'informations, consultez INSTALLATION.md"
echo

