SELECT l.titulo, l.titulo, a.nome as Autor
FROM Livro as l
join LivroAutor as la
on l.isbn = la.fk_livro
join Autor as a
on la.fk_autor = a.id
join Editora as e
on l.fk_editora = e.id;

-- Tem que dar erro, já que juca só tem permissão de fazer consultas no banco:
INSERT INTO Autor(nacionalidade, nome)
VALUES ('Brasileirinho', 'Juca da Silva');

-- Para ele poder inserir autores é necessário que o admin realize o comando:
--  	GRANT INSERT ON Autor TO Juca;

select * from autor;  -- o insert irá estar na tabela autor
select * from Livro;

-- Juca tentando ser escritor de Harry Potter, não consiguirá pois não tem permissão de modificação:
UPDATE LivroAutor
SET fk_autor = 7
WHERE fk_livro = '8532511015';


