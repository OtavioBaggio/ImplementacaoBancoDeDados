USE BIBLIOTECA;

-- Utilizando o BD BIBLIOTECA, crie uma view para retornar as informações:
--		ISBN, Titulo, Ano, Editora, Autor/Nacionalidade, Categoria
CREATE OR ALTER VIEW vw_InfoBibliteca
AS
SELECT l.isbn as ISBN, l.titulo as 'Título', l.ano, e.nome as editora, a.nacionalidade, CONCAT(a.nome, ' (' ,a.nacionalidade, ')') as 'Autor/Nacionalidade', c.tipo_categoria as Categoria
FROM Livro AS l
INNER JOIN LivroAutor as la
on la.fk_livro = l.isbn
INNER JOIN Autor as a
on la.fk_autor = a.id
INNER JOIN Editora as e
on e.id = l.fk_editora
INNER JOIN Categoria as c
on c.id = l.fk_categoria

-- exibindo tudo:
select * from vw_InfoBibliteca
order by Título;

-- só as editoras:
select DISTINCT Editora from vw_InfoBibliteca;

-- Livros entre 2010 e 2015:
select Título, Editora, [Autor/Nacionalidade], ano
from vw_InfoBibliteca
WHERE Ano BETWEEN 2010 AND 2015;
