-- Banco para aula de restri��es:
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

-- Testando as Restri��es:
INSERT INTO petShop VALUES('Herysson', 'Logan', 7, 'M');
INSERT INTO petShop VALUES('Juca', 'Fuma�a', -10, 'M'); -- N�o ir� deixar por causa do numero negativo
select * from petShop;

