# Modelo do Grafo

## Nós

| Label  | Propriedades                        |
|--------|-------------------------------------|
| `Song` | title, artist, genres[ ], mood      |

## Relacionamentos

| Tipo           | Propriedade | Descrição                          |
|----------------|-------------|------------------------------------|
| `SIMILAR_TO`   | score: Int  | Liga duas músicas similares        |

## Como o score é calculado

```
+4  mesmo artista
+3  por gênero compartilhado
+2  mesmo mood
─────────────────
mín 2 para criar a aresta
```

## Diagrama

```
(Blinding Lights) ──[score:9]──► (Save Your Tears)
       │
       └──[score:9]──► (In Your Eyes)
       │
       └──[score:6]──► (Starboy)
```

## Visualizar no Neo4j Browser

```cypher
MATCH (a:Song)-[r:SIMILAR_TO]->(b:Song)
WHERE r.score >= 6
RETURN a, r, b
```
