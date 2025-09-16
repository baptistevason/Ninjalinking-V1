# Guide de Déploiement - NinjaLinking SaaS

## 🎯 Vue d'ensemble

Ce guide s'adresse aux administrateurs système et développeurs qui souhaitent déployer NinjaLinking SaaS en production ou sur un autre ordinateur.

## 📋 Prérequis Système

### Minimum Requis
- **OS** : Windows 10+, Ubuntu 18.04+, macOS 10.15+
- **RAM** : 4 GB minimum, 8 GB recommandé
- **Stockage** : 2 GB d'espace libre
- **Réseau** : Connexion Internet pour les dépendances

### Logiciels Requis
- **Node.js** 18.0.0+ ([télécharger](https://nodejs.org/))
- **npm** 8.0.0+ (inclus avec Node.js)
- **Git** (optionnel, pour les mises à jour)

## 🚀 Méthodes de Déploiement

### 1. Déploiement Automatique (Recommandé)

#### Windows
```cmd
# Téléchargez et extrayez le package
# Double-cliquez sur install.bat
# Ou exécutez en ligne de commande:
install.bat
```

#### Linux/macOS
```bash
# Téléchargez et extrayez le package
chmod +x install.sh
./install.sh
```

### 2. Déploiement Manuel

#### Étape 1 : Préparation
```bash
# Vérifiez les prérequis
./check-requirements.bat  # Windows
./check-requirements.sh   # Linux/macOS
```

#### Étape 2 : Installation des dépendances
```bash
# Installation complète
npm run install-all

# Ou manuellement:
npm install
cd server && npm install && cd ..
cd client && npm install && cd ..
```

#### Étape 3 : Configuration
```bash
# Copiez le fichier de configuration
cp config.example.env server/.env
cp config.example.env client/.env.local

# Éditez les fichiers selon vos besoins
```

#### Étape 4 : Démarrage
```bash
# Mode développement
npm run dev

# Mode production
npm run build
npm start
```

## ⚙️ Configuration Avancée

### Variables d'Environnement

#### Serveur (`server/.env`)
```env
# === CONFIGURATION DE BASE ===
PORT=5000
NODE_ENV=production

# === SÉCURITÉ ===
JWT_SECRET=votre-cle-secrete-tres-forte-ici
CORS_ORIGIN=https://votre-domaine.com

# === BASE DE DONNÉES ===
# SQLite (développement)
DATABASE_URL=sqlite:./database.sqlite

# PostgreSQL (production)
# DATABASE_URL=postgresql://user:pass@localhost:5432/ninjalinking_db

# === LIMITATION DE DÉBIT ===
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# === APIs EXTERNES (optionnel) ===
AHREFS_API_KEY=votre-cle-ahrefs
SEMRUSH_API_KEY=votre-cle-semrush
MOZ_API_KEY=votre-cle-moz

# === EMAIL (optionnel) ===
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=votre-email@gmail.com
SMTP_PASS=votre-mot-de-passe-app
```

#### Client (`client/.env.local`)
```env
# === API ===
NEXT_PUBLIC_API_URL=https://votre-api.com

# === APPLICATION ===
NEXT_PUBLIC_APP_NAME=NinjaLinking
NEXT_PUBLIC_APP_URL=https://votre-site.com
```

### Base de Données

#### SQLite (Développement)
- Aucune configuration requise
- Fichier créé automatiquement : `server/database.sqlite`

#### PostgreSQL (Production)
```sql
-- Créer la base de données
CREATE DATABASE ninjalinking_db;

-- Créer un utilisateur
CREATE USER ninjalinking_user WITH PASSWORD 'mot_de_passe_securise';
GRANT ALL PRIVILEGES ON DATABASE ninjalinking_db TO ninjalinking_user;
```

## 🔒 Sécurité

### Configuration de Production

1. **Changez le JWT_SECRET**
   ```env
   JWT_SECRET=une-cle-aleatoire-tres-longue-et-complexe
   ```

2. **Configurez HTTPS**
   - Utilisez un reverse proxy (nginx, Apache)
   - Obtenez un certificat SSL (Let's Encrypt)

3. **Limitez l'accès**
   ```env
   CORS_ORIGIN=https://votre-domaine.com
   ```

4. **Configurez le firewall**
   - Port 80 (HTTP)
   - Port 443 (HTTPS)
   - Port 5000 (API, si exposé)

### Reverse Proxy avec Nginx

```nginx
server {
    listen 80;
    server_name votre-domaine.com;
    
    # Redirection HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name votre-domaine.com;
    
    ssl_certificate /path/to/certificate.crt;
    ssl_certificate_key /path/to/private.key;
    
    # Frontend
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    # API
    location /api {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 🐳 Déploiement avec Docker

### Docker Compose
```bash
# Lancer tous les services
docker-compose up -d

# Voir les logs
docker-compose logs -f

# Arrêter
docker-compose down
```

### Docker individuel
```bash
# Construire l'image
docker build -t ninjalinking-saas .

# Lancer le conteneur
docker run -p 3000:3000 -p 5000:5000 ninjalinking-saas
```

## 📊 Monitoring et Maintenance

### Logs
```bash
# Logs du serveur
tail -f server/logs/app.log

# Logs Docker
docker-compose logs -f app
```

### Sauvegarde
```bash
# Base de données SQLite
cp server/database.sqlite backup/database-$(date +%Y%m%d).sqlite

# Base de données PostgreSQL
pg_dump ninjalinking_db > backup/database-$(date +%Y%m%d).sql
```

### Mise à jour
```bash
# Sauvegarder
./backup.sh

# Mettre à jour le code
git pull origin main

# Réinstaller les dépendances
npm run install-all

# Redémarrer
npm run dev
```

## 🔧 Dépannage

### Problèmes Courants

#### Port déjà utilisé
```bash
# Trouver le processus
netstat -ano | findstr :3000  # Windows
lsof -i :3000                 # Linux/macOS

# Arrêter le processus
taskkill /PID <PID> /F        # Windows
kill -9 <PID>                 # Linux/macOS
```

#### Erreurs de permissions
```bash
# Windows : Exécuter en tant qu'administrateur
# Linux/macOS :
sudo chown -R $USER:$USER .
chmod +x *.sh
```

#### Modules manquants
```bash
# Réinstaller toutes les dépendances
rm -rf node_modules server/node_modules client/node_modules
npm run install-all
```

### Logs d'Erreur

#### Serveur
- Console : Messages d'erreur en temps réel
- Fichier : `server/logs/error.log`

#### Client
- Console du navigateur : F12 → Console
- Terminal : Messages Next.js

## 📞 Support

### Ressources
- **Documentation** : `INSTALLATION.md`
- **Configuration** : `config.example.env`
- **Scripts** : `*.bat` (Windows), `*.sh` (Linux/macOS)

### Contact
- **Email** : support@ninjalinking.com
- **Issues** : GitHub Issues
- **Documentation** : docs.ninjalinking.com

## ✅ Checklist de Déploiement

- [ ] Prérequis installés (Node.js, npm)
- [ ] Ports 3000 et 5000 disponibles
- [ ] Variables d'environnement configurées
- [ ] Base de données configurée
- [ ] Sécurité configurée (JWT_SECRET, HTTPS)
- [ ] Reverse proxy configuré (production)
- [ ] Monitoring configuré
- [ ] Sauvegarde configurée
- [ ] Tests de fonctionnement effectués
- [ ] Documentation utilisateur fournie







