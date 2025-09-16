# NinjaLinking SAAS

Un outil complet pour le ninjalinking et la gestion de projets SEO. Développé pour aider les consultants SEO à optimiser leurs campagnes de netlinking avec des outils automatisés et intelligents.

## 🚀 Fonctionnalités principales

### 🔍 Détection de liens cassés
- Scan automatique des sites web
- Identification des pages 404
- Analyse des liens externes cassés
- Détection des opportunités de netlinking

### 🎯 Prospection de sites partenaires
- Recherche de sites dans votre niche
- Analyse de l'autorité des domaines (DA/PA)
- Identification des opportunités de netlinking
- Analyse concurrentielle

### 📝 Génération de propositions
- Templates personnalisables pour les emails de prospection
- Suggestions de contenu basées sur l'analyse des sites
- Suivi des réponses et négociations
- Gestion des contacts

### 📊 Tableau de bord et reporting
- Vue d'ensemble des projets
- Métriques de performance en temps réel
- Rapports détaillés pour les clients
- Export en PDF, Excel, CSV

### 🔄 Automatisation
- Scans programmés
- Notifications automatiques
- Suivi des backlinks
- Rapports automatiques

## 🛠️ Technologies utilisées

### Frontend
- **React 18** avec Next.js 14
- **TypeScript** pour la sécurité des types
- **Tailwind CSS** pour le design
- **Heroicons** pour les icônes
- **React Hook Form** pour les formulaires
- **React Query** pour la gestion des données
- **Recharts** pour les graphiques

### Backend
- **Node.js** avec Express
- **TypeScript** pour la sécurité des types
- **PostgreSQL** avec Sequelize ORM
- **JWT** pour l'authentification
- **Puppeteer** pour le scraping
- **Cheerio** pour l'analyse HTML
- **Node-cron** pour les tâches programmées

### APIs externes
- **Ahrefs API** pour les métriques SEO
- **SEMrush API** pour l'analyse concurrentielle
- **Moz API** pour l'autorité des domaines

## 📦 Installation

### 🚀 Installation Rapide (Recommandée)

#### Windows
```bash
# Double-cliquez sur install.bat ou exécutez:
.\install.bat
```

#### Linux/Mac
```bash
# Rendre le script exécutable et lancer
chmod +x install.sh
./install.sh
```

### 📋 Prérequis
- **Node.js 18+** (téléchargez depuis [nodejs.org](https://nodejs.org/))
- **npm** (inclus avec Node.js)
- **Git** (optionnel, pour cloner depuis un dépôt)

### 🔧 Installation Manuelle

#### 1. Vérification des prérequis
```bash
# Windows
.\check-requirements.bat

# Linux/Mac
chmod +x check-requirements.sh
./check-requirements.sh
```

#### 2. Installation complète
```bash
# Windows
.\deploy.bat

# Linux/Mac
chmod +x deploy.sh
./deploy.sh
```

#### 3. Démarrage rapide (si déjà installé)
```bash
# Windows
.\start.bat

# Linux/Mac
chmod +x start.sh
./start.sh
```

### Installation manuelle

```bash
# 1. Cloner le projet
git clone <repository-url>
cd ninjalinking-saas

# 2. Installer les dépendances du projet principal
npm install

# 3. Installer les dépendances du serveur
cd server
npm install
cd ..

# 4. Installer les dépendances du client
cd client
npm install
cd ..
```

## ⚙️ Configuration

### 1. Base de données PostgreSQL

```sql
-- Créer la base de données
CREATE DATABASE ninjalinking_db;

-- Créer un utilisateur (optionnel)
CREATE USER ninjalinking_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE ninjalinking_db TO ninjalinking_user;
```

### 2. Variables d'environnement

#### Serveur (`server/.env`)
```env
# Base de données
DATABASE_URL=postgresql://username:password@localhost:5432/ninjalinking_db
DB_HOST=localhost
DB_PORT=5432
DB_NAME=ninjalinking_db
DB_USER=username
DB_PASSWORD=password

# JWT
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRES_IN=7d

# Serveur
PORT=5000
NODE_ENV=development

# APIs externes (optionnel)
AHREFS_API_KEY=your-ahrefs-api-key
SEMRUSH_API_KEY=your-semrush-api-key
MOZ_API_KEY=your-moz-api-key

# Email (optionnel)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password

# Sécurité
CORS_ORIGIN=http://localhost:3000
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
```

#### Client (`client/.env.local`)
```env
# API
NEXT_PUBLIC_API_URL=http://localhost:5000/api

# Application
NEXT_PUBLIC_APP_NAME=NinjaLinking
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

## 🚀 Démarrage

### Mode développement
```bash
# Lancer le serveur et le client en parallèle
npm run dev
```

### Mode production
```bash
# Construire le client
npm run build

# Lancer le serveur
npm start
```

### Commandes individuelles
```bash
# Serveur uniquement
npm run server

# Client uniquement
npm run client

# Installation de toutes les dépendances
npm run install-all
```

## 📁 Structure du projet

```
ninjalinking-saas/
├── client/                 # Frontend Next.js
│   ├── components/         # Composants React
│   ├── hooks/             # Hooks personnalisés
│   ├── lib/               # Utilitaires et API client
│   ├── pages/             # Pages Next.js
│   ├── styles/            # Styles CSS
│   ├── types/             # Types TypeScript
│   └── utils/             # Fonctions utilitaires
├── server/                # Backend Express
│   ├── config/            # Configuration
│   ├── middleware/        # Middlewares Express
│   ├── models/            # Modèles Sequelize
│   ├── routes/            # Routes API
│   ├── services/          # Logique métier
│   └── utils/             # Utilitaires serveur
├── scripts/               # Scripts de configuration
├── docs/                  # Documentation
└── README.md
```

## 🔧 API Endpoints

### Authentification
- `POST /api/auth/register` - Inscription
- `POST /api/auth/login` - Connexion
- `GET /api/auth/me` - Profil utilisateur
- `PUT /api/auth/profile` - Mise à jour du profil

### Projets
- `GET /api/projects` - Liste des projets
- `POST /api/projects` - Créer un projet
- `GET /api/projects/:id` - Détails d'un projet
- `PUT /api/projects/:id` - Modifier un projet
- `DELETE /api/projects/:id` - Supprimer un projet
- `POST /api/projects/:id/scan` - Lancer un scan

### Sites web
- `GET /api/websites` - Liste des sites
- `POST /api/websites` - Ajouter un site
- `GET /api/websites/:id` - Détails d'un site
- `PUT /api/websites/:id` - Modifier un site
- `DELETE /api/websites/:id` - Supprimer un site
- `POST /api/websites/:id/scan` - Scanner un site

### Backlinks
- `GET /api/backlinks` - Liste des backlinks
- `POST /api/backlinks` - Créer un backlink
- `PUT /api/backlinks/:id` - Modifier un backlink
- `DELETE /api/backlinks/:id` - Supprimer un backlink
- `POST /api/backlinks/generate-proposal` - Générer une proposition

### Rapports
- `GET /api/reports/dashboard` - Données du tableau de bord
- `GET /api/reports/projects/:id` - Rapport de projet
- `POST /api/reports/export` - Exporter un rapport

## 🧪 Tests

```bash
# Tests du serveur
cd server
npm test

# Tests du client
cd client
npm test
```

## 📈 Déploiement

### Docker (recommandé)
```bash
# Construire l'image
docker build -t ninjalinking-saas .

# Lancer le conteneur
docker run -p 3000:3000 -p 5000:5000 ninjalinking-saas
```

### Vercel (Frontend)
```bash
# Installer Vercel CLI
npm i -g vercel

# Déployer
cd client
vercel
```

### Heroku (Backend)
```bash
# Installer Heroku CLI
# Créer une app Heroku
heroku create ninjalinking-api

# Déployer
git subtree push --prefix server heroku main
```

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🆘 Support

- 📧 Email: support@ninjalinking.com
- 💬 Discord: [Serveur Discord](https://discord.gg/ninjalinking)
- 📖 Documentation: [docs.ninjalinking.com](https://docs.ninjalinking.com)
- 🐛 Issues: [GitHub Issues](https://github.com/ninjalinking/saas/issues)

## 🙏 Remerciements

- [Next.js](https://nextjs.org/) pour le framework React
- [Tailwind CSS](https://tailwindcss.com/) pour le design
- [Sequelize](https://sequelize.org/) pour l'ORM
- [Heroicons](https://heroicons.com/) pour les icônes
