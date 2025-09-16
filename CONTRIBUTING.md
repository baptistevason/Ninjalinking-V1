# Guide de contribution - NinjaLinking SAAS

Merci de votre intérêt pour contribuer au projet NinjaLinking SAAS ! Ce guide vous aidera à comprendre comment contribuer efficacement au projet.

## 🚀 Comment contribuer

### 1. Fork et Clone
```bash
# Fork le projet sur GitHub, puis clonez votre fork
git clone https://github.com/votre-username/ninjalinking-saas.git
cd ninjalinking-saas

# Ajoutez le repository original comme remote
git remote add upstream https://github.com/ninjalinking/saas.git
```

### 2. Configuration de l'environnement
```bash
# Suivez les instructions d'installation
./scripts/setup.sh  # Linux/Mac
# ou
scripts\setup.bat   # Windows
```

### 3. Créer une branche
```bash
# Créez une branche pour votre feature
git checkout -b feature/nom-de-votre-feature

# Ou pour un bugfix
git checkout -b fix/description-du-bug
```

### 4. Développement
- Écrivez du code propre et bien documenté
- Suivez les conventions de nommage du projet
- Ajoutez des tests pour vos nouvelles fonctionnalités
- Mettez à jour la documentation si nécessaire

### 5. Tests
```bash
# Tests du serveur
cd server && npm test

# Tests du client
cd client && npm test

# Tests de linting
npm run lint
```

### 6. Commit et Push
```bash
# Ajoutez vos changements
git add .

# Committez avec un message descriptif
git commit -m "feat: ajouter la fonctionnalité X"

# Poussez vers votre fork
git push origin feature/nom-de-votre-feature
```

### 7. Pull Request
- Créez une Pull Request sur GitHub
- Décrivez clairement vos changements
- Référencez les issues liées si applicable
- Attendez la review de l'équipe

## 📝 Conventions de code

### Messages de commit
Utilisez le format [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[body optionnel]

[footer optionnel]
```

Types disponibles:
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `docs`: Documentation
- `style`: Formatage, points-virgules manquants, etc.
- `refactor`: Refactoring de code
- `test`: Ajout ou modification de tests
- `chore`: Tâches de maintenance

Exemples:
```
feat(auth): ajouter l'authentification OAuth
fix(api): corriger la validation des emails
docs(readme): mettre à jour les instructions d'installation
```

### Nommage des branches
- `feature/nom-de-la-feature`
- `fix/description-du-bug`
- `docs/description-de-la-doc`
- `refactor/description-du-refactoring`

### Code Style

#### JavaScript/TypeScript
- Utilisez Prettier pour le formatage
- Suivez les règles ESLint du projet
- Utilisez des noms de variables descriptifs
- Commentez le code complexe

#### CSS
- Utilisez Tailwind CSS pour le styling
- Suivez la convention BEM pour les classes personnalisées
- Organisez les styles par composant

#### Base de données
- Utilisez des noms de tables en snake_case
- Ajoutez des index pour les requêtes fréquentes
- Documentez les migrations

## 🧪 Tests

### Tests unitaires
- Écrivez des tests pour toutes les nouvelles fonctionnalités
- Maintenez une couverture de code > 80%
- Utilisez Jest pour les tests JavaScript/TypeScript

### Tests d'intégration
- Testez les endpoints API
- Vérifiez l'intégration avec la base de données
- Testez les flux utilisateur complets

### Tests E2E
- Utilisez Playwright pour les tests end-to-end
- Testez les parcours utilisateur critiques
- Automatisez les tests dans CI/CD

## 📚 Documentation

### Code
- Documentez les fonctions complexes
- Ajoutez des JSDoc pour les fonctions publiques
- Expliquez les algorithmes non-évidents

### API
- Documentez tous les endpoints
- Incluez des exemples de requêtes/réponses
- Mettez à jour la documentation OpenAPI

### README
- Mettez à jour le README pour les nouvelles fonctionnalités
- Ajoutez des exemples d'utilisation
- Documentez les changements breaking

## 🐛 Signaler un bug

### Avant de créer une issue
1. Vérifiez que le bug n'a pas déjà été signalé
2. Testez avec la dernière version
3. Vérifiez la documentation

### Template d'issue pour bug
```markdown
**Description du bug**
Une description claire du problème.

**Étapes pour reproduire**
1. Aller à '...'
2. Cliquer sur '....'
3. Voir l'erreur

**Comportement attendu**
Ce qui devrait se passer.

**Captures d'écran**
Si applicable, ajoutez des captures d'écran.

**Environnement**
- OS: [ex. Windows 10]
- Navigateur: [ex. Chrome 91]
- Version: [ex. 1.0.0]

**Informations supplémentaires**
Tout autre contexte utile.
```

## 💡 Proposer une fonctionnalité

### Template d'issue pour feature
```markdown
**Description de la fonctionnalité**
Une description claire de la fonctionnalité souhaitée.

**Problème résolu**
Quel problème cette fonctionnalité résout-elle ?

**Solution proposée**
Décrivez votre solution.

**Alternatives considérées**
Décrivez les alternatives que vous avez considérées.

**Informations supplémentaires**
Tout autre contexte ou captures d'écran.
```

## 🔄 Processus de review

### Pour les contributeurs
- Répondez aux commentaires rapidement
- Faites les modifications demandées
- Testez vos changements après les modifications

### Pour les reviewers
- Soyez constructifs dans vos commentaires
- Expliquez pourquoi vous demandez des changements
- Félicitez le bon travail
- Répondez rapidement aux questions

## 📋 Checklist avant PR

- [ ] Code testé localement
- [ ] Tests passent
- [ ] Linting OK
- [ ] Documentation mise à jour
- [ ] Messages de commit conformes
- [ ] Branche à jour avec main
- [ ] Description de PR claire

## 🏷️ Labels des issues

- `bug`: Quelque chose ne fonctionne pas
- `enhancement`: Nouvelle fonctionnalité ou amélioration
- `documentation`: Amélioration de la documentation
- `good first issue`: Bon pour les nouveaux contributeurs
- `help wanted`: Besoin d'aide de la communauté
- `priority: high`: Priorité élevée
- `priority: medium`: Priorité moyenne
- `priority: low`: Priorité faible

## 📞 Support

- 💬 Discord: [Serveur Discord](https://discord.gg/ninjalinking)
- 📧 Email: dev@ninjalinking.com
- 📖 Documentation: [docs.ninjalinking.com](https://docs.ninjalinking.com)

## 🙏 Remerciements

Merci à tous les contributeurs qui rendent ce projet possible !

---

**Note**: Ce guide est en constante évolution. N'hésitez pas à proposer des améliorations !
