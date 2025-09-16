# Dockerfile pour NinjaLinking SAAS
FROM node:18-alpine AS base

# Installer les dépendances nécessaires
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Copier les fichiers de configuration des packages
COPY package*.json ./
COPY server/package*.json ./server/
COPY client/package*.json ./client/

# Installer les dépendances
RUN npm ci --only=production

# Stage pour le build du client
FROM node:18-alpine AS client-builder
WORKDIR /app
COPY client/package*.json ./client/
RUN cd client && npm ci
COPY client/ ./client/
RUN cd client && npm run build

# Stage pour le build du serveur
FROM node:18-alpine AS server-builder
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm ci
COPY server/ ./server/
RUN cd server && npm run build

# Stage de production
FROM node:18-alpine AS production
WORKDIR /app

# Installer les dépendances de production
RUN apk add --no-cache libc6-compat

# Copier les fichiers de configuration
COPY package*.json ./
COPY server/package*.json ./server/

# Installer les dépendances de production
RUN npm ci --only=production && npm cache clean --force

# Copier le serveur construit
COPY --from=server-builder /app/server/dist ./server/dist
COPY --from=server-builder /app/server/node_modules ./server/node_modules

# Copier le client construit
COPY --from=client-builder /app/client/.next ./client/.next
COPY --from=client-builder /app/client/public ./client/public
COPY --from=client-builder /app/client/package*.json ./client/

# Copier les autres fichiers nécessaires
COPY server/ ./server/
COPY client/next.config.js ./client/
COPY client/next.config.js ./client/

# Créer un utilisateur non-root
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Changer les permissions
RUN chown -R nextjs:nodejs /app
USER nextjs

# Exposer les ports
EXPOSE 3000 5000

# Variables d'environnement
ENV NODE_ENV=production
ENV PORT=5000

# Script de démarrage
COPY --chown=nextjs:nodejs scripts/start.sh ./
RUN chmod +x start.sh

CMD ["./start.sh"]
