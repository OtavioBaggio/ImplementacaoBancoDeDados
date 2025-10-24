-- Banco para aula de restrições:
CREATE DATABASE RESTRICOES;
--
GO;
-- Colocando em uso:
USE RESTRICOES;
GO;

CREATE TABLE petShop
(
	id INT PRIMARY KEY IDENTITY,
	nomeDono VARCHAR(50) UNIQUE,
	nomePet VARCHAR(50) NOT NULL,
	idadePet INT CHECK(idadePet > 0),
	sexoPet CHAR CHECK(sexoPet IN ('M', 'F', 'N'))
);

-- Testando as Restrições:
INSERT INTO petShop VALUES('Herysson', 'Logan', 7, 'M');
INSERT INTO petShop VALUES('Juca', 'Fumaça', -10, 'M'); -- Não irá deixar por causa do numero negativo
select * from petShop;

