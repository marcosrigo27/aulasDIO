# 🎵 Recomendação de Músicas com Grafos e Neo4j

Sistema de recomendação baseado em similaridade ponderada entre músicas,
modelado como um grafo no Neo4j.

---

## Estrutura do projeto

```
projeto/
├── dataset/
│   └── songs.csv          ← músicas com gênero, artista e mood
├── queries/
│   ├── 01_carga.cypher    ← cria os nós e arestas no Neo4j
│   └── 02_recomendacao.cypher  ← queries de recomendação
├── scripts/
│   └── recommend.py       ← script Python para rodar tudo
└── docs/
    └── modelo.md          ← explicação do modelo do grafo
```

---

## Como rodar

### 1. Subir o Neo4j (via Docker)
```bash
docker run -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=neo4j/senha123 neo4j:latest
```

### 2. Instalar dependências
```bash
pip install neo4j
```

### 3. Executar
```bash
python scripts/recommend.py
```

O script carrega o CSV, cria o grafo e imprime as recomendações.

---

## Por que grafos?

Músicas têm múltiplas relações (artista, gênero, mood). Em um grafo, cada
relação vira uma aresta com peso — o algoritmo percorre essas conexões via
BFS e soma os scores para ranquear recomendações.
