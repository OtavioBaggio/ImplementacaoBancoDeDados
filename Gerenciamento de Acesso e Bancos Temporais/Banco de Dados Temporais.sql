CREATE DATABASE BD_Temporal;
GO;

USE BD_Temporal;

CREATE TABLE InventarioCarros(
	Id INT IDENTITY PRIMARY KEY,
	Ano INT, 
	Marca VARCHAR(40),
	Modelo VARCHAR(40),
	Cor VARCHAR(10),
	Quilometragem INT,
	Disponibilidade BIT NOT NULL DEFAULT 1,
	SysStartTime dateTime2 GENERATED ALWAYS AS ROW START NOT NULL, -- trabalha em segundos
	SysEndTime dateTime2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME(SysStartTime, SysEndTime)
)
WITH
(
	-- provividencia um nome para a tabela de históricos
	SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.HistoricoInventarioCarros)
)


--Vamos preenchê-lo com os carros mais escolhidos das agências de locação de carros em todo o Brasil
Insert into dbo.InventarioCarros (Ano,Marca,Modelo,Cor,Quilometragem,Disponibilidade) 
values (2004, 'Fiat', 'Uno', 'Branco', 150000, 1);
Insert into dbo.InventarioCarros (Ano,Marca,Modelo,Cor,Quilometragem,Disponibilidade) 
values (2015, 'Ford', 'Ka', 'Preto', 30000, 1);
Insert into dbo.InventarioCarros (Ano,Marca,Modelo,Cor,Quilometragem,Disponibilidade) 
values (2022, 'Hyundai', 'HB20', 'Prata', 0, 1);
Insert into dbo.InventarioCarros (Ano,Marca,Modelo,Cor,Quilometragem,Disponibilidade) 
values (2022, 'Hyundai', 'HB20', 'Branco', 0, 1);

select * from InventarioCarros;
select * from dbo.HistoricoInventarioCarros;

-- Foram alugados alguns carros:
UPDATE InventarioCarros 
SET Disponibilidade = 0
WHERE Id = 1;
UPDATE InventarioCarros 
SET Disponibilidade = 0
WHERE Id = 4;


-- Foram ENTREGUES alguns carros:
UPDATE InventarioCarros 
SET Disponibilidade = 1, Quilometragem = 160000
WHERE Id = 1;

UPDATE InventarioCarros 
SET Disponibilidade = 1, Quilometragem = 5000
WHERE Id = 4;

-- Caminhão boiadeiro AMASSOU O MEU CARRO:
UPDATE InventarioCarros 
SET Disponibilidade = 0
WHERE Id = 1;
-- INFELIZMENTE o Uno foi de beise:
DELETE FROM InventarioCarros
WHERE Id = 1;


-- MAS eu quero me lembrar de como era o Uninho :'( 
-- Olhando para um passado distante:
SELECT * FROM InventarioCarros
FOR SYSTEM_TIME AS OF '2025-10-31 14:15:58.0203084' ORDER BY Id;

-- Recuperar todo o histórico de guerra do meu UNO:
select * from InventarioCarros
FOR SYSTEM_TIME ALL
WHERE Id = 1;

-- Ver quais carros meus não estão mais na frota:
select DISTINCT h.Modelo
from InventarioCarros as i
RIGHT JOIN dbo.HistoricoInventarioCarros as h
ON i.Id = h.Id
WHERE i.Id IS NULL;