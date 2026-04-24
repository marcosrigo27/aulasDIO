// ── 1. Limpar banco ───────────────────────────────────────────────────────────
MATCH (n) DETACH DELETE n;

// ── 2. Criar músicas ──────────────────────────────────────────────────────────
CREATE (:Song {title: "Blinding Lights",  artist: "The Weeknd", genres: ["synth-pop","r&b"],  mood: "energetic"});
CREATE (:Song {title: "Levitating",       artist: "Dua Lipa",   genres: ["pop","disco"],      mood: "happy"});
CREATE (:Song {title: "Save Your Tears",  artist: "The Weeknd", genres: ["synth-pop","pop"],  mood: "melancholic"});
CREATE (:Song {title: "Don't Start Now",  artist: "Dua Lipa",   genres: ["pop","disco"],      mood: "energetic"});
CREATE (:Song {title: "Starboy",          artist: "The Weeknd", genres: ["r&b","pop"],        mood: "dark"});
CREATE (:Song {title: "Physical",         artist: "Dua Lipa",   genres: ["pop","dance"],      mood: "energetic"});
CREATE (:Song {title: "Kiss Me More",     artist: "Doja Cat",   genres: ["pop","r&b"],        mood: "happy"});
CREATE (:Song {title: "Need to Know",     artist: "Doja Cat",   genres: ["r&b","dance"],      mood: "energetic"});
CREATE (:Song {title: "Say So",           artist: "Doja Cat",   genres: ["pop","disco"],      mood: "happy"});
CREATE (:Song {title: "In Your Eyes",     artist: "The Weeknd", genres: ["synth-pop","r&b"],  mood: "romantic"});
CREATE (:Song {title: "Future Nostalgia", artist: "Dua Lipa",   genres: ["pop","disco"],      mood: "energetic"});

// ── 3. Criar arestas SIMILAR_TO com score ponderado ──────────────────────────
//   +3 por gênero compartilhado
//   +4 se mesmo artista
//   +2 se mesmo mood
//   só cria aresta se score >= 2
MATCH (a:Song), (b:Song) WHERE a.title < b.title
WITH a, b,
     size([g IN a.genres WHERE g IN b.genres]) * 3 AS genreScore,
     CASE WHEN a.artist = b.artist THEN 4 ELSE 0 END AS artistScore,
     CASE WHEN a.mood   = b.mood   THEN 2 ELSE 0 END AS moodScore
WITH a, b, genreScore + artistScore + moodScore AS score
WHERE score >= 2
CREATE (a)-[:SIMILAR_TO {score: score}]->(b)
CREATE (b)-[:SIMILAR_TO {score: score}]->(a);
