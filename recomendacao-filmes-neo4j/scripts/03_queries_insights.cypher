MATCH (f:Filme)<-[r:AVALIOU]-(:Usuario) 
WITH f, avg(r.nota) AS media, count(r) AS total 
WHERE total >= 2 
RETURN f.titulo, media, total ORDER BY media DESC; 
 
MATCH (u:Usuario {id:1})-[r:AVALIOU]-
WHERE r.nota > 3.5 
WITH g, count(*) AS peso 
MATCH (g)<-[:PERTENCE_A]-(recomendado:Filme) 
WHERE NOT EXISTS((u {id:1})-[:AVALIOU]-
RETURN recomendado.titulo, collect(DISTINCT g.nome) AS generos, sum(peso) AS score 
ORDER BY score DESC LIMIT 5; 
