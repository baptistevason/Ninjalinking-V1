# Guide d'Installation - NinjaLinking SaaS

## Prérequis

### 1. Node.js et npm
- **Node.js** version 18.0.0 ou supérieure
- **npm** version 8.0.0 ou supérieure

**Installation :**
- Téléchargez Node.js depuis [https://nodejs.org/](https://nodejs.org/)
- Choisissez la version LTS (Long Term Support)
- Suivez l'installateur pour Windows

**Vérification :**
```bash
node --version
npm --version
```

### 2. Git (optionnel mais recommandé)
- Téléchargez Git depuis [https://git-scm.com/](https://git-scm.com/)
- Permet de cloner le projet depuis un dépôt

## Installation

### Méthode 1 : Installation Automatique (Recommandée)

1. **Téléchargez le projet**
   - Copiez le dossier `ninjalinking-saas` sur l'ordinateur cible
   - Ou clonez depuis un dépôt Git

2. **Lancez l'installation automatique**
   ```bash
   # Sur Windows
   .\deploy.bat
   
   # Sur Linux/Mac
   chmod +x deploy.sh
   ./deploy.sh
   ```

3. **L'application se lance automatiquement**
   - Frontend : http://localhost:3000
   - Backend : http://localhost:5000

### Méthode 2 : Installation Manuelle

1. **Installez les dépendances racine**
   ```bash
   npm install
   ```

2. **Installez les dépendances du serveur**
   ```bash
   cd server
   npm install
   cd ..
   ```

3. **Installez les dépendances du client**
   ```bash
   cd client
   npm install
   cd ..
   ```

4. **Configurez les variables d'environnement**

   **Serveur** (`server/.env`) :
   ```env
   PORT=5000
   NODE_ENV=development
   JWT_SECRET=ninjalinking-secret-key-2024
   DATABASE_URL=sqlite:./database.sqlite
   ```

   **Client** (`client/.env.local`) :
   ```env
   NEXT_PUBLIC_API_URL=http://localhost:5000
   ```

5. **Lancez l'application**
   ```bash
   npm run dev
   ```

## Configuration Avancée

### Base de Données

**SQLite (par défaut) :**
- Aucune configuration supplémentaire requise
- La base de données se crée automatiquement

**PostgreSQL (production) :**
1. Installez PostgreSQL
2. Créez une base de données
3. Modifiez `server/.env` :
   ```env
   DATABASE_URL=postgresql://username:password@localhost:5432/ninjalinking_db
   ```

### Ports

**Changer les ports :**
- **Frontend** : Modifiez `client/.env.local` et `package.json`
- **Backend** : Modifiez `server/.env`

### Sécurité

**En production :**
1. Changez `JWT_SECRET` dans `server/.env`
2. Configurez `NODE_ENV=production`
3. Utilisez HTTPS
4. Configurez un reverse proxy (nginx)

## Démarrage

### Développement
```bash
npm run dev
```

### Production
```bash
npm run build
npm start
```

## Vérification

1. **Frontend** : Ouvrez http://localhost:3000
2. **Backend** : Ouvrez http://localhost:5000
3. **API** : Testez http://localhost:5000/api

## Dépannage

### Erreurs Communes

**"Module not found" :**
```bash
# Réinstallez les dépendances
npm run install-all
```

**"Port already in use" :**
```bash
# Trouvez le processus utilisant le port
netstat -ano | findstr :3000
netstat -ano | findstr :5000

# Arrêtez le processus
taskkill /PID <PID> /F
```

**"Permission denied" :**
- Exécutez en tant qu'administrateur
- Vérifiez les permissions des dossiers

### Logs

**Serveur :**
- Les logs s'affichent dans la console
- Fichier de log : `server/logs/`

**Client :**
- Logs dans la console du navigateur
- Logs Next.js dans la console

## Support

Pour toute question ou problème :
1. Vérifiez ce guide
2. Consultez les logs d'erreur
3. Vérifiez les prérequis
4. Contactez le support technique

## Mise à Jour

1. Sauvegardez vos données
2. Téléchargez la nouvelle version
3. Exécutez `npm run install-all`
4. Relancez l'application

