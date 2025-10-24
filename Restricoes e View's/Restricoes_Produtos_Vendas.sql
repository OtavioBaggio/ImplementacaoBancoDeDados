USE RESTRICOES;

CREATE TABLE Produto
(
	cod INT PRIMARY KEY,
	nome VARCHAR(50),
	categoria VARCHAR(50)
);

CREATE TABLE Inventario
(
	id INT PRIMARY KEY IDENTITY,
	codProduto INT,
	quantidade INT,
	minLevel INT,
	maxLevel INT,
	CONSTRAINT fk_inv_produto
		FOREIGN KEY (codProduto)
		REFERENCES Produto (cod)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- Outra forma de criar restrições:
ALTER TABLE Inventario
ADD CONSTRAINT fk_inv_produto
FOREIGN KEY(codProduto)
		REFERENCES Produto(cod)
		ON DELETE CASCADE
		ON UPDATE CASCADE;

CREATE TABLE Venda
(
	id INT PRIMARY KEY IDENTITY,
	codProduto INT,
	quantidade INT
);

ALTER TABLE Venda
ADD CONSTRAINT fk_Venda_produto
FOREIGN KEY(codProduto)
		REFERENCES Produto(cod)
		ON DELETE SET NULL
		ON UPDATE CASCADE;

-- Simulando algumas vendas:
INSERT INTO Venda
VALUES (87655, 5),
	   (3, 10),
	   (3, 20),
	   (3, 5),
	   (5, 1),
	   (4, 2),
	   (6, 4);

-- Cadastrando produtos:
INSERT INTO Produto 
VALUES (1, 'Sabão', 'Higiene'),
	   (2, 'Coca', 'Bebidas'),
	   (3, 'Spaten 473ml', 'Bebidas'),
	   (4, 'Belinha', 'Bebidas'),
	   (5, 'Catuaba', 'Bebidas'),
	   (6, 'Monster BRASILEIRO', 'Bebidas');

INSERT INTO Inventario (codProduto, quantidade, minLevel, maxLevel)
VALUES (1, 8, 2, 20),
	   (2, 100, 80, 200),
	   (3, 1000, 800, 5000),
	   (4, 5, 1, 10),
	   (5, 15, 10, 100),
	   (6, 200, 100, 500);

SELECT * FROM Produto as P
INNER JOIN Inventario AS I 
ON I.codProduto = P.cod;

SELECT * FROM PRODUTO AS P
RIGHT JOIN Venda as V
ON V.codProduto = P.cod;

DELETE FROM Produto
WHERE cod = 1; -- removendo o sabão

DELETE FROM Produto
WHERE cod = 4; -- removendo a belinha

-- alterando o codigo do produto:
UPDATE Produto
SET cod = 87655
WHERE cod = 2;

-- removendo a constraint
ALTER TABLE Venda 
DROP CONSTRAINT fk_Venda_produto;



	   