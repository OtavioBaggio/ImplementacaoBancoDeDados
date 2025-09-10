USE EMPRESA

DECLARE @idade INT,
		@nome VARCHAR(40),
		@data DATE,
		@grana MONEY;

SET @nome = 'Herysson R. Figueiredo';
SET @data = '1988-06-07'; --AAAA--MM--DD
SET @grana = 2;
SET @idade = YEAR(GETDATE()) - YEAR(@data);

SELECT @nome AS 'Nome', @data AS 'Daa_Nasc',
	   @idade AS 'Idade', @grana AS 'Dinheiro';

PRINT 'Meu Nome é: ' + @nome + ', nascido em: ' + CAST(@data AS VARCHAR(11))

-- Atribuir valor com SELECT:
-- Recupere o nome do departamento com Dnumero = 2.
DECLARE @nomeDepartamento VARCHAR(100);

SELECT @nomeDepartamento = D.Dnome
FROM DEPARTAMENTO AS D
WHERE D.Dnumero = 4;
PRINT @nomeDepartamento;

-- Calculando o novo salário com um aumento de 10%, para a Jennifer
DECLARE @nome_funcionario VARCHAR(100),
		@salarioJennifer DECIMAL(10,2),
		@aumento DECIMAL(10,2),
		@novo_salario DECIMAL(10,2);

SET @nome_funcionario = 'Jennifer';
SET @aumento = 10;

SELECT @salarioJennifer = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nome_funcionario
set @novo_salario = @salarioJennifer *(1 + @aumento/100);
SELECT @nome_funcionario AS 'Nome', @salarioJennifer AS 'Salario',
	   @aumento AS '%', @novo_salario as 'Novo Salário';

-- Calculando a idade da Jennifer
DECLARE @idadeJennifer INT;
DECLARE @nome_funcionarioJ varchar(100);

SET @nome_funcionarioJ = 'Jennifer';

select @idadeJennifer = YEAR(GETDATE()) - YEAR(F.Datanasc)
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nome_funcionarioJ;

PRINT CAST(@idadeJennifer AS VARCHAR(11));

----- CONVERSÃO DE DADOS -----

-- CAST --


-- CONVERT --
SELECT F.Pnome as 'Nome', CONVERT(VARCHAR(10), F.Datanasc, 103) AS 'Data_Nasc'
FROM FUNCIONARIO AS F


