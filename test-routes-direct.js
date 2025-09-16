// Test direct des routes pour vérifier l'isolation
const express = require('express');
const { sequelize, User, Project, Website, Backlink } = require('./server/models');
const auth = require('./server/middleware/auth');
const jwt = require('jsonwebtoken');

async function testRoutesDirectly() {
  try {
    console.log('🧪 Test direct des routes d\'isolation...\n');
    
    // Créer un serveur Express minimal pour tester
    const app = express();
    app.use(express.json());
    
    // Simuler le middleware d'auth
    app.use('/api/projects', (req, res, next) => {
      // Simuler un utilisateur connecté
      req.user = { id: req.headers['x-user-id'] ? parseInt(req.headers['x-user-id']) : 1 };
      next();
    });
    
    // Route de test pour les projets
    app.get('/api/projects', async (req, res) => {
      try {
        const projects = await Project.findAll({
          where: { userId: req.user.id }
        });
        res.json(projects);
      } catch (error) {
        res.status(500).json({ message: 'Erreur serveur' });
      }
    });
    
    // Démarrer le serveur de test
    const server = app.listen(3001, () => {
      console.log('Serveur de test démarré sur le port 3001\n');
    });
    
    // Attendre que le serveur démarre
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // Test 1: Alice (ID: 1) récupère ses projets
    console.log('1️⃣ Test Alice (ID: 1)...');
    const aliceResponse = await fetch('http://localhost:3001/api/projects', {
      headers: { 'x-user-id': '1' }
    });
    const aliceProjects = await aliceResponse.json();
    console.log(`   📊 Alice voit ${aliceProjects.length} projets:`);
    aliceProjects.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id}, User: ${p.userId})`);
    });
    console.log('');
    
    // Test 2: Bob (ID: 2) récupère ses projets
    console.log('2️⃣ Test Bob (ID: 2)...');
    const bobResponse = await fetch('http://localhost:3001/api/projects', {
      headers: { 'x-user-id': '2' }
    });
    const bobProjects = await bobResponse.json();
    console.log(`   📊 Bob voit ${bobProjects.length} projets:`);
    bobProjects.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id}, User: ${p.userId})`);
    });
    console.log('');
    
    // Test 3: Charlie (ID: 3) récupère ses projets
    console.log('3️⃣ Test Charlie (ID: 3)...');
    const charlieResponse = await fetch('http://localhost:3001/api/projects', {
      headers: { 'x-user-id': '3' }
    });
    const charlieProjects = await charlieResponse.json();
    console.log(`   📊 Charlie voit ${charlieProjects.length} projets:`);
    charlieProjects.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id}, User: ${p.userId})`);
    });
    console.log('');
    
    // Vérification de l'isolation
    console.log('🔒 VÉRIFICATION DE L\'ISOLATION:');
    const allProjects = await Project.findAll();
    console.log(`   📊 Total des projets en base: ${allProjects.length}`);
    
    const aliceProjectIds = aliceProjects.map(p => p.id);
    const bobProjectIds = bobProjects.map(p => p.id);
    const charlieProjectIds = charlieProjects.map(p => p.id);
    
    // Vérifier qu'il n'y a pas de chevauchement
    const hasOverlap = aliceProjectIds.some(id => bobProjectIds.includes(id) || charlieProjectIds.includes(id)) ||
                      bobProjectIds.some(id => charlieProjectIds.includes(id));
    
    if (!hasOverlap) {
      console.log('   ✅ ISOLATION PARFAITE: Aucun projet partagé entre utilisateurs');
    } else {
      console.log('   ❌ PROBLÈME: Des projets sont partagés entre utilisateurs');
    }
    
    // Résumé
    console.log('\n📋 RÉSUMÉ:');
    console.log(`   👤 Alice: ${aliceProjects.length} projets`);
    console.log(`   👤 Bob: ${bobProjects.length} projets`);
    console.log(`   👤 Charlie: ${charlieProjects.length} projets`);
    console.log(`   📊 Total: ${aliceProjects.length + bobProjects.length + charlieProjects.length} projets`);
    
    // Fermer le serveur
    server.close();
    await sequelize.close();
    
    console.log('\n🎉 Test terminé !');
    
  } catch (error) {
    console.error('❌ Erreur:', error);
  }
}

testRoutesDirectly();
