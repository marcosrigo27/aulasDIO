# Recomendacao de Filmes com Neo4j - Projeto Nota 10 
 
## Contexto 
Plataforma de streaming quer recomendar filmes. 
 
## Modelo do grafo 
(Usuario)-[:AVALIOU]-
 
## Como executar 
1. Copie os CSVs para a pasta import do Neo4j 
2. Execute os scripts em ordem 
 
## Troubleshooting 
- Generos separados por pipe: usei UNWIND e MERGE 
