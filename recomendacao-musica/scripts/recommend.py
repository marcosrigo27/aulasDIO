from neo4j import GraphDatabase
import csv, os

URI      = "bolt://localhost:7687"
USER     = "neo4j"
PASSWORD = "senha123"  # troque se necessário

driver = GraphDatabase.driver(URI, auth=(USER, PASSWORD))

# ── Carrega músicas do CSV ────────────────────────────────────────────────────
def load_songs():
    path = os.path.join(os.path.dirname(__file__), "../dataset/songs.csv")
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))

# ── Cria o grafo no Neo4j ─────────────────────────────────────────────────────
def setup(session, songs):
    session.run("MATCH (n) DETACH DELETE n")

    for s in songs:
        session.run(
            "CREATE (:Song {title:$t, artist:$a, genres:$g, mood:$m})",
            t=s["title"], a=s["artist"],
            g=s["genres"].split(","), m=s["mood"]
        )

    session.run("""
        MATCH (a:Song), (b:Song) WHERE a.title < b.title
        WITH a, b,
             size([g IN a.genres WHERE g IN b.genres]) * 3 AS gs,
             CASE WHEN a.artist = b.artist THEN 4 ELSE 0 END AS as_,
             CASE WHEN a.mood   = b.mood   THEN 2 ELSE 0 END AS ms
        WITH a, b, gs + as_ + ms AS score WHERE score >= 2
        CREATE (a)-[:SIMILAR_TO {score:score}]->(b)
        CREATE (b)-[:SIMILAR_TO {score:score}]->(a)
    """)
    print(f"✓ Grafo criado com {len(songs)} músicas.\n")

# ── Recomenda músicas ─────────────────────────────────────────────────────────
def recommend(session, title, top=5):
    rows = session.run("""
        MATCH (s:Song {title:$t})-[r:SIMILAR_TO]->(rec:Song)
        RETURN rec.title AS musica, rec.artist AS artista, r.score AS score
        ORDER BY score DESC LIMIT $k
    """, t=title, k=top).data()

    print(f"🎵 Recomendações para '{title}':")
    for r in rows:
        bar = "█" * r["score"]
        print(f"  {r['musica']:<25} {r['artista']:<15} {bar} ({r['score']})")
    print()

# ── Main ──────────────────────────────────────────────────────────────────────
with driver.session() as s:
    setup(s, load_songs())
    recommend(s, "Blinding Lights")
    recommend(s, "Levitating")
    recommend(s, "Kiss Me More")

driver.close()
