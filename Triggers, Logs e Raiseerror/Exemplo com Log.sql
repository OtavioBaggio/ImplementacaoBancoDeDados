USE EMPRESA;

/*
Exemplo Log:
Crie um trigger que seja disparado em vez de uma atualiza��o na tabela FUNCIONARIO
Esse trigger deve verificar se o novo sal�rio do funcion�rio a ser 
atualizado � maior ou igual a R$ 1.000,00. Se o nono sal�rio for v�lido,
a atualiza��o deve ser cancelada e uma mensagem de erro exibida, impedindo que
funcion�rios recebam sal�rios abaixo desse valor. */
GO
CREATE TABLE Log_Funcionario(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	Cpf VARCHAR(11),
	Operacao VARCHAR(10),
	Data_Hora DATETIME DEFAULT GETDATE()
	);

select * from Log_Funcionario;
GO

GO
-- Trigger para o insert
CREATE OR ALTER TRIGGER trg_LogInsertFuncionario
ON FUNCIONARIO
AFTER INSERT
AS
BEGIN
	DECLARE @cpf VARCHAR(11)
	SELECT @cpf = cpf
	from inserted;
	INSERT INTO Log_Funcionario(Cpf, Operacao)
	VALUES(@cpf, 'INSERT')
end
GO

INSERT INTO FUNCIONARIO (Cpf, Pnome, Unome, Minicial)
VALUES ('8996547', 'Z�', 'do bar', 'R');


GO

-- Trigger para o update
CREATE OR ALTER TRIGGER trg_LogUpdateFuncionario
ON FUNCIONARIO
AFTER INSERT
AS
BEGIN
	DECLARE @cpf VARCHAR(11)
	SELECT @cpf = cpf
	from inserted;
	INSERT INTO Log_Funcionario(Cpf, Operacao)
	VALUES(@cpf, 'UPDATE')
end
GO

UPDATE FUNCIONARIO
SET Unome = 'da Ro�a'
WHERE cpf = '8996547';


-- Trigger para o delete
CREATE OR ALTER TRIGGER trg_LogDeleteFuncionario
ON FUNCIONARIO
AFTER INSERT
AS
BEGIN
	DECLARE @cpf VARCHAR(11)
	SELECT @cpf = cpf
	from deleted;
	INSERT INTO Log_Funcionario(Cpf, Operacao)
	VALUES(@cpf, 'DELETE')
end
GO

DELETE FROM FUNCIONARIO WHERE cpf = '8996547';

select * from FUNCIONARIO
