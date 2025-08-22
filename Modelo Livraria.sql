/* Modelo Livraria: */
CREATE DATABASE IF NOT EXISTS livraria;
USE livraria;

CREATE TABLE Livro (
    ISBN VARCHAR(20) PRIMARY KEY,
    Titulo VARCHAR(255),
    Ano INT
);

CREATE TABLE Editora (
    Nome VARCHAR(255) PRIMARY KEY
);

CREATE TABLE Autor (
    CPF VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(255),
    CEP VARCHAR(10),
    Cidade VARCHAR(100),
    Nacionalidade VARCHAR(100)
);

CREATE TABLE Categoria (
    codigo INT PRIMARY KEY,
    descricao VARCHAR(100)
);

CREATE TABLE ESCRITO (
    FK_Livro_ISBN VARCHAR(20),
    FK_Autor_CPF VARCHAR(14),
    PRIMARY KEY (FK_Livro_ISBN, FK_Autor_CPF),
    FOREIGN KEY (FK_Livro_ISBN) REFERENCES Livro(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (FK_Autor_CPF) REFERENCES Autor(CPF) ON DELETE CASCADE
);

CREATE TABLE POSSUI (
    FK_Livro_ISBN VARCHAR(20),
    FK_Categoria_codigo INT,
    PRIMARY KEY (FK_Livro_ISBN, FK_Categoria_codigo),
    FOREIGN KEY (FK_Livro_ISBN) REFERENCES Livro(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (FK_Categoria_codigo) REFERENCES Categoria(codigo) ON DELETE CASCADE
);

-- Inserções
INSERT INTO Autor (CPF, Nome, CEP, Cidade, Nacionalidade)
VALUES
('123456789', 'J.K. Rowling', NULL, NULL, 'Inglaterra'),
('254863325', 'Clive Staples Lewis', NULL, NULL, 'Inglaterra'),
('523658719', 'Affonso Solano', NULL, NULL, 'Brasil'),
('639871258', 'Marcos Piangers', NULL, NULL, 'Brasil'),
('851279268', 'Ciro Botelho - Tiririca', NULL, NULL, 'Brasil'),
('863254789', 'Bianca Möl', NULL, NULL, 'Brasil'),
('785236971', 'J.K. Rowling', NULL, NULL, 'Inglaterra');

INSERT INTO Editora (Nome)
VALUES
('Rocco'),
('Wmf Martins Fontes'),
('Casa da Palavra'),
('Belas Letras'),
('Matrix');

INSERT INTO Livro (ISBN, Titulo, Ano) VALUES
('8532511015', 'Harry Potter e A Pedra Filosofal', 2000),
('9788578207698', 'As Crônicas de Nárnia', 2009),
('9788577343438', 'O Espadachim de Carvão', 2013),
('9788581742458', 'O Papai É Pop', 2015),
('9788582302026', 'Pior Que Tá Não Fica', 2015),
('9788577345670', 'Garota Desdobrável', 2015),
('8532512062', 'Harry Potter e o Prisioneiro de Azkaban', 2000);

INSERT INTO Categoria (codigo, descricao)
VALUES
(1, 'Literatura Juvenil'),
(2, 'Ficção Científica'),
(3, 'Humor');

INSERT INTO ESCRITO (FK_Livro_ISBN, FK_Autor_CPF) VALUES
('8532511015', '123456789'),
('9788578207698', '254863325'),
('9788577343438', '523658719'),
('9788581742458', '639871258'),
('9788582302026', '851279268'),
('9788577345670', '863254789'),
('8532512062', '785236971');



INSERT INTO POSSUI (FK_Livro_ISBN, FK_Categoria_Codigo)
VALUES
('8532511015', 1),
('9788578207698', 1),
('9788577343438', 2),
('9788581742458', 3),
('9788582302026', 3),
('9788577345670', 1),
('8532512062', 1);

SHOW tables;

/* Consultas: */
#Livros:
SELECT Titulo, Ano, ISBN
FROM Livro;

#Autores e livros:
SELECT * 
FROM Livro
ORDER BY Titulo;

#Autores brasileiros:
SELECT Nome
FROM Autor
WHERE Nacionalidade = 'Brasil';

#Exercicio 8: Ordem alfabetica do autor
SELECT l.ISBN, l.Titulo, l.Ano, a.Nome AS Autor, a.Nacionalidade
FROM Livro l
JOIN ESCRITO e ON l.ISBN = e.FK_Livro_ISBN
JOIN Autor a ON a.CPF = e.FK_Autor_CPF
ORDER BY a.Nome;


#Exercicio 9: Livros da categoria Juvenil em ordem de Ano:
SELECT l.ISBN, l.Titulo, l.Ano, c.descricao AS Categoria
FROM Livro l
JOIN POSSUI p ON l.ISBN = p.FK_Livro_ISBN
JOIN Categoria c ON c.codigo = p.FK_Categoria_codigo
WHERE c.descricao = 'Literatura Juvenil'
ORDER BY l.Ano;

#Exercicio 10: Livros de humor ou ficcao com ano entre 2000 e 2010:
SELECT l.ISBN, l.Titulo, l.Ano, c.descricao AS Categoria
FROM Livro l
JOIN POSSUI p ON l.ISBN = p.FK_Livro_ISBN
JOIN Categoria c ON c.codigo = p.FK_Categoria_codigo
WHERE (c.descricao = 'Humor' OR c.descricao = 'Ficção Científica')
  AND l.Ano BETWEEN 2000 AND 2010;













