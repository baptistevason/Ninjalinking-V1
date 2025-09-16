// Test simple d'isolation des données
async function testIsolation() {
  try {
    console.log('🧪 Test d\'isolation des données...\n');
    
    // Attendre que le serveur démarre
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // 1. Connexion d'Alice
    console.log('1️⃣ Connexion d\'Alice...');
    const aliceResponse = await fetch('http://localhost:5000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        email: 'alice@example.com',
        password: 'password123'
      })
    });
    
    if (!aliceResponse.ok) {
      throw new Error(`Erreur connexion Alice: ${aliceResponse.status}`);
    }
    
    const aliceData = await aliceResponse.json();
    const aliceToken = aliceData.token;
    console.log('   ✅ Alice connectée\n');
    
    // 2. Connexion de Bob
    console.log('2️⃣ Connexion de Bob...');
    const bobResponse = await fetch('http://localhost:5000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        email: 'bob@example.com',
        password: 'password123'
      })
    });
    
    if (!bobResponse.ok) {
      throw new Error(`Erreur connexion Bob: ${bobResponse.status}`);
    }
    
    const bobData = await bobResponse.json();
    const bobToken = bobData.token;
    console.log('   ✅ Bob connecté\n');
    
    // 3. Alice récupère ses projets
    console.log('3️⃣ Alice récupère ses projets...');
    const aliceProjectsResponse = await fetch('http://localhost:5000/api/projects', {
      headers: { 'Authorization': `Bearer ${aliceToken}` }
    });
    
    if (!aliceProjectsResponse.ok) {
      throw new Error(`Erreur récupération projets Alice: ${aliceProjectsResponse.status}`);
    }
    
    const aliceProjects = await aliceProjectsResponse.json();
    console.log(`   📊 Alice voit ${aliceProjects.length} projets:`);
    aliceProjects.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id})`);
    });
    console.log('');
    
    // 4. Bob récupère ses projets
    console.log('4️⃣ Bob récupère ses projets...');
    const bobProjectsResponse = await fetch('http://localhost:5000/api/projects', {
      headers: { 'Authorization': `Bearer ${bobToken}` }
    });
    
    if (!bobProjectsResponse.ok) {
      throw new Error(`Erreur récupération projets Bob: ${bobProjectsResponse.status}`);
    }
    
    const bobProjects = await bobProjectsResponse.json();
    console.log(`   📊 Bob voit ${bobProjects.length} projets:`);
    bobProjects.forEach(p => {
      console.log(`      - ${p.name} (ID: ${p.id})`);
    });
    console.log('');
    
    // 5. Test de sécurité : Alice essaie d'accéder à un projet de Bob
    console.log('5️⃣ Test de sécurité - Alice essaie d\'accéder à un projet de Bob...');
    if (bobProjects.length > 0) {
      const bobProjectId = bobProjects[0].id;
      const securityResponse = await fetch(`http://localhost:5000/api/projects/${bobProjectId}`, {
        headers: { 'Authorization': `Bearer ${aliceToken}` }
      });
      
      if (securityResponse.status === 404) {
        console.log('   ✅ SÉCURITÉ OK: Alice ne peut pas accéder au projet de Bob');
      } else {
        console.log('   ❌ PROBLÈME: Alice peut accéder au projet de Bob !');
      }
    }
    console.log('');
    
    // 6. Résumé
    console.log('📋 RÉSUMÉ:');
    console.log(`   👤 Alice: ${aliceProjects.length} projets`);
    console.log(`   👤 Bob: ${bobProjects.length} projets`);
    console.log('');
    console.log('🎉 Test d\'isolation terminé !');
    
  } catch (error) {
    console.error('❌ Erreur:', error.message);
  }
}

testIsolation();
