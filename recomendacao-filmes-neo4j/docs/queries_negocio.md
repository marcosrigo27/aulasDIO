# Queries de Negocio 
 
## Q1 - Top filmes 
```cypher 
MATCH (f:Filme)<-[r:AVALIOU]-(:Usuario) 
RETURN f.titulo, avg(r.nota) AS media ORDER BY media DESC LIMIT 5; 
``` 
