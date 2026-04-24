// ── Q1: Recomendações para uma música ────────────────────────────────────────
MATCH (s:Song {title: "Blinding Lights"})-[r:SIMILAR_TO]->(rec:Song)
RETURN rec.title AS musica, rec.artist AS artista, r.score AS score
ORDER BY score DESC
LIMIT 5;

// ── Q2: Músicas por mood ──────────────────────────────────────────────────────
MATCH (s:Song)
WHERE s.mood = "energetic"
RETURN s.title AS musica, s.artist AS artista;

// ── Q3: Caminho mais curto entre duas músicas ─────────────────────────────────
MATCH path = shortestPath(
  (a:Song {title: "Starboy"})-[:SIMILAR_TO*]->(b:Song {title: "Say So"})
)
RETURN [n IN nodes(path) | n.title] AS trilha, length(path) AS saltos;

// ── Q4: Músicas mais conectadas do grafo ──────────────────────────────────────
MATCH (s:Song)-[:SIMILAR_TO]->(outro:Song)
RETURN s.title AS musica, count(outro) AS conexoes
ORDER BY conexoes DESC;
