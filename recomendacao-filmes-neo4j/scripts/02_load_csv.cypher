LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row 
CREATE (f:Filme {id: toInteger(row.movieId), titulo: row.title}); 
 
LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row 
WITH row, split(row.genres, '|') AS generos 
UNWIND generos AS gen 
MERGE (g:Genero {nome: gen}) 
MERGE (f:Filme {id: toInteger(row.movieId)}) 
MERGE (f)-[:PERTENCE_A]-
 
LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS row 
MERGE (u:Usuario {id: toInteger(row.userId)}) 
MERGE (f:Filme {id: toInteger(row.movieId)}) 
CREATE (u)-[:AVALIOU {nota: toFloat(row.rating), timestamp: toInteger(row.timestamp)}]-
