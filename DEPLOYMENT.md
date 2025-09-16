# 🚀 Guide de déploiement - NinjaLinking SAAS

## 📋 Prérequis

### Sur l'ordinateur de destination :
- **Node.js** (version 16 ou supérieure)
- **npm** (généralement inclus avec Node.js)
- **Git** (optionnel, pour cloner le repository)

## 🔄 Méthode 1 : Transfert de fichiers (Recommandée)

### 1. Préparer les fichiers sur l'ordinateur actuel

```bash
# Créer une archive du projet (sans node_modules)
# Sur Windows PowerShell :
Compress-Archive -Path "C:\ninjalinking-saas" -DestinationPath "ninjalinking-saas.zip" -Exclude "**/node_modules/**"

# Ou copier le dossier entier (sans node_modules)
```

### 2. Transférer les fichiers

**Options de transfert :**
- **Clé USB** : Copier le dossier `ninjalinking-saas`
- **Cloud** : Uploader l'archive ZIP sur Google Drive, Dropbox, etc.
- **Réseau** : Partager le dossier via réseau local
- **Email** : Envoyer l'archive ZIP (si < 25MB)

### 3. Installation sur l'ordinateur de destination

```bash
# 1. Extraire/copier les fichiers dans un dossier
# Exemple : C:\ninjalinking-saas

# 2. Ouvrir un terminal dans le dossier du projet
cd C:\ninjalinking-saas

# 3. Installer les dépendances du serveur
cd server
npm install

# 4. Installer les dépendances du client
cd ../client
npm install

# 5. Retourner à la racine
cd ..
```

### 4. Configuration des variables d'environnement

#### Serveur (server/.env) :
```bash
# Créer le fichier server/.env
PORT=5000
NODE_ENV=development
JWT_SECRET=your-secret-key-here
DATABASE_URL=sqlite:./database.sqlite
```

#### Client (client/.env.local) :
```bash
# Créer le fichier client/.env.local
NEXT_PUBLIC_API_URL=http://localhost:5000
```

### 5. Démarrage de l'application

```bash
# Option A : Démarrer les deux serveurs séparément
# Terminal 1 - Serveur backend :
cd server
npm run dev

# Terminal 2 - Client frontend :
cd client
npm run dev
```

```bash
# Option B : Démarrer avec concurrently (depuis la racine)
npm run dev
```

### 6. Accès à l'application

- **Frontend** : http://localhost:3000
- **Backend API** : http://localhost:5000

## 🔄 Méthode 2 : Git Clone (Si repository disponible)

```bash
# 1. Cloner le repository
git clone [URL_DU_REPOSITORY]
cd ninjalinking-saas

# 2. Installer les dépendances
npm install
cd server && npm install
cd ../client && npm install

# 3. Configurer les variables d'environnement (voir section 4)

# 4. Démarrer l'application
npm run dev
```

## 🐳 Méthode 3 : Docker (Optionnel)

```bash
# 1. Installer Docker Desktop sur l'ordinateur de destination

# 2. Dans le dossier du projet
docker-compose up -d

# 3. Accéder à l'application
# Frontend : http://localhost:3000
# Backend : http://localhost:5000
```

## 🔧 Dépannage

### Problèmes courants :

#### 1. Erreur "Port already in use"
```bash
# Tuer les processus utilisant les ports
# Windows :
netstat -ano | findstr :3000
taskkill /PID [PID_NUMBER] /F

netstat -ano | findstr :5000
taskkill /PID [PID_NUMBER] /F
```

#### 2. Erreur "Module not found"
```bash
# Réinstaller les dépendances
cd server
rm -rf node_modules package-lock.json
npm install

cd ../client
rm -rf node_modules package-lock.json
npm install
```

#### 3. Erreur de permissions (Windows)
```bash
# Exécuter PowerShell en tant qu'administrateur
# Ou utiliser :
npm install --no-optional
```

#### 4. Problème de compilation TypeScript
```bash
# Vérifier la version de Node.js
node --version
# Doit être >= 16

# Réinstaller les types
cd client
npm install @types/react @types/node
```

## 📁 Structure des fichiers importants

```
ninjalinking-saas/
├── client/                 # Application Next.js (Frontend)
│   ├── pages/             # Pages de l'application
│   ├── components/        # Composants React
│   ├── data/             # Données TTF
│   └── package.json      # Dépendances frontend
├── server/               # API Express (Backend)
│   ├── routes/           # Routes API
│   ├── models/           # Modèles de données
│   └── package.json      # Dépendances backend
├── package.json          # Scripts principaux
└── docker-compose.yml    # Configuration Docker
```

## 🎯 Fonctionnalités disponibles

- ✅ **Authentification** : Inscription/Connexion
- ✅ **Dashboard** : Vue d'ensemble des projets
- ✅ **E-Réputation** : Footprints pour la réputation
- ✅ **Ninja Linking** : Footprints pour le netlinking
- ✅ **Catalogue** : Base de données des spots SEO
- ✅ **Projets** : Gestion des projets de netlinking
- ✅ **Sites** : Base de données des sites
- ✅ **TTF** : Topical Trust Flow avec couleurs

## 🔐 Sécurité

- Les données sont stockées en local (localStorage)
- Pas de base de données externe requise
- Variables d'environnement pour la configuration
- JWT pour l'authentification (simulée)

## 📞 Support

En cas de problème :
1. Vérifier les prérequis (Node.js, npm)
2. Consulter les logs d'erreur dans le terminal
3. Vérifier les ports (3000, 5000)
4. Réinstaller les dépendances si nécessaire

---

**Note** : Cette application fonctionne entièrement en local et ne nécessite pas de base de données externe. Toutes les données sont stockées dans le navigateur (localStorage).








