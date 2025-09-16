const axios = require('axios');

const API_BASE = 'http://localhost:5000/api';

async function testApiIsolation() {
  try {
    console.log('🧪 TEST D\'ISOLATION VIA L\'API\n');

    // 1. Connexion d'Alice
    console.log('1️⃣ Connexion d\'Alice...');
    const aliceLogin = await axios.post(`${API_BASE}/auth/login`, {
      email: 'alice@example.com',
      password: 'password123'
    });
    const aliceToken = aliceLogin.data.token;
    console.log('   ✅ Alice connectée\n');

    // 2. Connexion de Bob
    console.log('2️⃣ Connexion de Bob...');
    const bobLogin = await axios.post(`${API_BASE}/auth/login`, {
      email: 'bob@example.com',
      password: 'password123'
    });
    const bobToken = bobLogin.data.token;
    console.log('   ✅ Bob connecté\n');

    // 3. Alice récupère ses projets
    console.log('3️⃣ Alice récupère ses projets...');
    const aliceProjects = await axios.get(`${API_BASE}/projects`, {
      headers: { Authorization: `Bearer ${aliceToken}` }
    });
    console.log(`   📊 Alice voit ${aliceProjects.data.length} projets:`);
    aliceProjects.data.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id})`);
    });
    console.log('');

    // 4. Bob récupère ses projets
    console.log('4️⃣ Bob récupère ses projets...');
    const bobProjects = await axios.get(`${API_BASE}/projects`, {
      headers: { Authorization: `Bearer ${bobToken}` }
    });
    console.log(`   📊 Bob voit ${bobProjects.data.length} projets:`);
    bobProjects.data.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id})`);
    });
    console.log('');

    // 5. Test de sécurité : Alice essaie d'accéder à un projet de Bob
    console.log('5️⃣ Test de sécurité - Alice essaie d\'accéder à un projet de Bob...');
    try {
      const bobProjectId = bobProjects.data[0].id;
      await axios.get(`${API_BASE}/projects/${bobProjectId}`, {
        headers: { Authorization: `Bearer ${aliceToken}` }
      });
      console.log('   ❌ PROBLÈME: Alice peut accéder au projet de Bob !');
    } catch (error) {
      if (error.response && error.response.status === 404) {
        console.log('   ✅ SÉCURITÉ OK: Alice ne peut pas accéder au projet de Bob');
      } else {
        console.log('   ❌ Erreur inattendue:', error.response?.data || error.message);
      }
    }
    console.log('');

    // 6. Test de sécurité : Bob essaie d'accéder à un projet d'Alice
    console.log('6️⃣ Test de sécurité - Bob essaie d\'accéder à un projet d\'Alice...');
    try {
      const aliceProjectId = aliceProjects.data[0].id;
      await axios.get(`${API_BASE}/projects/${aliceProjectId}`, {
        headers: { Authorization: `Bearer ${bobToken}` }
      });
      console.log('   ❌ PROBLÈME: Bob peut accéder au projet d\'Alice !');
    } catch (error) {
      if (error.response && error.response.status === 404) {
        console.log('   ✅ SÉCURITÉ OK: Bob ne peut pas accéder au projet d\'Alice');
      } else {
        console.log('   ❌ Erreur inattendue:', error.response?.data || error.message);
      }
    }
    console.log('');

    // 7. Test des sites web
    console.log('7️⃣ Test des sites web...');
    const aliceWebsites = await axios.get(`${API_BASE}/websites`, {
      headers: { Authorization: `Bearer ${aliceToken}` }
    });
    const bobWebsites = await axios.get(`${API_BASE}/websites`, {
      headers: { Authorization: `Bearer ${bobToken}` }
    });
    console.log(`   🌐 Alice voit ${aliceWebsites.data.length} sites web`);
    console.log(`   🌐 Bob voit ${bobWebsites.data.length} sites web`);
    console.log('');

    // 8. Test des backlinks
    console.log('8️⃣ Test des backlinks...');
    const aliceBacklinks = await axios.get(`${API_BASE}/backlinks`, {
      headers: { Authorization: `Bearer ${aliceToken}` }
    });
    const bobBacklinks = await axios.get(`${API_BASE}/backlinks`, {
      headers: { Authorization: `Bearer ${bobToken}` }
    });
    console.log(`   🔗 Alice voit ${aliceBacklinks.data.length} backlinks`);
    console.log(`   🔗 Bob voit ${bobBacklinks.data.length} backlinks`);
    console.log('');

    // 9. Résumé
    console.log('📋 RÉSUMÉ:');
    console.log(`   👤 Alice: ${aliceProjects.data.length} projets, ${aliceWebsites.data.length} sites, ${aliceBacklinks.data.length} backlinks`);
    console.log(`   👤 Bob: ${bobProjects.data.length} projets, ${bobWebsites.data.length} sites, ${bobBacklinks.data.length} backlinks`);
    console.log('');
    console.log('🎉 Test d\'isolation terminé !');

  } catch (error) {
    console.error('❌ Erreur lors du test:', error.response?.data || error.message);
  }
}

// Attendre que le serveur démarre
setTimeout(() => {
  testApiIsolation();
}, 3000);
