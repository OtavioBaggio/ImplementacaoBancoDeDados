USE EMPRESA;

-- Exemplo VI:
-- Crie um procedure que insira um novo funcionário no banco

ALTER PROCEDURE usp_inserirFuncionario
	@pnome VARCHAR(100),
    @Minicial CHAR(1),
	@unome VARCHAR(100),
	@cpf VARCHAR(11),
	@DataNasc DATE,
    @Endereco VARCHAR(150),
    @Sexo CHAR(1),
    @Salario DECIMAL(10,2),
    @Cpf_supervisor CHAR(11),
    @Dnr INT
AS
BEGIN
	IF EXISTS(
        SELECT *
        FROM FUNCIONARIO AS F
        WHERE F.Pnome = @pnome
        AND F.Minicial = @Minicial
        AND F.Unome = @unome
        )
    BEGIN
        print 'Já existe um funconário com o nome.'
        RETURN;
    END
    

    INSERT INTO FUNCIONARIO 
        (Pnome, Minicial, Unome, Cpf, DataNasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
    VALUES
        (@Pnome, @Minicial, @Unome, @Cpf, @DataNasc, @Endereco, @Sexo, @Salario, @Cpf_supervisor, @Dnr);
END;

EXEC usp_inserirFuncionario
    'Fontella',
    'S',
    'Racista',
    '68785432168',
    '1915-08-12',
    'Av do Diabo,66, Cidade Negra, BA',
    'F',
    17000,
    NULL,
    8;

select * from FUNCIONARIO;