USE EMPRESA;

-- Trigger
GO
CREATE OR ALTER TRIGGER trg_InserirFuncionario
ON FUNCIONARIO
INSTEAD OF INSERT
AS
DECLARE @nome VARCHAR(100);
SELECT @nome = Pnome FROM inserted
PRINT 'olá! NÃO INSERI NENHUM REGISTRO!'
GO
INSERT into FUNCIONARIO (Cpf, Pnome, Unome, Minicial)
VALUES ('0184785632', 'Gertulino', 'Figueiredo', 'R');

SELECT * FROM FUNCIONARIO

/* No trigger eu consigo pegar o que esta no bloco de comando
	Com o comando FROM INSERTED
*/

-- desabilitar o trigger criado:
ALTER TABLE FUNCIONARIO
DISABLE TRIGGER trg_InserirFuncionario

--
INSERT into FUNCIONARIO (Cpf, Pnome, Unome, Minicial)
VALUES ('0174785632', 'Gertulino', 'Figueiredo', 'R');

SELECT * FROM FUNCIONARIO

--

EXEC sp_helptrigger @tabname = FUNCIONARIO;	-- Da informações sobre quais tipos de triggers estão sendo realizados na tabela

--

GO
CREATE OR ALTER TRIGGER trg_afterUpdateNomes
ON FUNCIONARIO
AFTER UPDATE
AS
BEGIN
IF UPDATE(Pnome)
	BEGIN
		DECLARE @NovoNome VARCHAR(100);
		DECLARE @AntigoNome VARCHAR(100);
		SELECT @NovoNome = Pnome FROM inserted;
		SELECT @AntigoNome = Pnome FROM deleted;
		PRINT 'Antigo: ' + @AntigoNome;
		PRINT 'Nome Atualizado: ' + @NovoNome;
	END
ELSE
	PRINT 'O primeiro nome não foi alterado'
END
GO

select * from FUNCIONARIO order by Pnome, Unome
UPDATE FUNCIONARIO
SET Pnome = 'Roberto'
WHERE Cpf = '0184785632';  -- Substitua por um CPF válido da tabela

UPDATE FUNCIONARIO
SET Unome = 'Baggio'
WHERE Cpf = '0184785632';


-- Trigger para evitar nomes completos duplicados
GO
CREATE OR ALTER TRIGGER trg_AfterNomesDuplicados
ON FUNCIONARIO
AFTER INSERT
AS
BEGIN
	DECLARE @Pnome VARCHAR(50),
			@Minicial CHAR(1),
			@Unome VARCHAR(50),
			@Duplicados INT;
	SELECT @Duplicados = COUNT(*)
	FROM(
		SELECT Pnome, Unome, Minicial
		FROM FUNCIONARIO
		GROUP BY Pnome, Unome, Minicial
		HAVING COUNT(*) > 1
		) AS Duplicados;
	IF @Duplicados > 0
	BEGIN
		PRINT 'Já existe um funcionário com este nome'
		ROLLBACK TRANSACTION;
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION;
		PRINT 'Novo registro inserido';
	END
END;
GO

SELECT * FROM FUNCIONARIO ORDER BY Pnome;

insert into FUNCIONARIO (cpf, Pnome, Unome, Minicial)
VALUES ('14785596', 'Herisson', 'Silva', 'R')



GO
CREATE OR ALTER TRIGGER trg_AfterNomeDuplicados
ON FUNCIONARIO
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @Pnome VARCHAR(50),
			@Minicial CHAR(1),
			@Unome VARCHAR(50)
	SELECT @Pnome = Pnome, @Minicial = Minicial, @Unome = Unome
	FROM inserted;

	-- Verifica se existe alguem com o mesmo nome
	IF EXISTS (
		SELECT 1
		FROM FUNCIONARIO
		WHERE @Pnome = Pnome
		and @Minicial = Minicial
		and @Unome = Unome
		)
	BEGIN
		PRINT 'Já existe alguém com este nome!'
		RAISERROR('Erro: Nome duplicado', 16, 0);  -- Boas práticas de documentação, especificando qual o erro ocorreu e em qual camada de aplicação
	END
	ELSE
	BEGIN
		INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr, Data_Admissao)
		SELECT Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr, Data_Admissao
		FROM inserted;
	END;
END;
GO

select * from FUNCIONARIO order by Pnome;

INSERT INTO FUNCIONARIO(cpf, Pnome, Unome, Minicial)
VALUES ('99999999', 'Welinton', 'Figueiredo', 'R')
