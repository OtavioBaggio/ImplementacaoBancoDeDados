USE EMPRESA;

----- CONDICIONAIS IF/ELSE -----

-- Verificar se um Funcion�rio Recebe Abaixo da M�dia Salarial
DECLARE @salario_medio DECIMAL(10,2),
		@salaro_func DECIMAL(10,2),
		@nome_func VARCHAR(100) = 'Ana';

SELECT @salario_medio = AVG(F.Salario)
FROM FUNCIONARIO AS F;

SELECT @salaro_func = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nome_func;

IF @salaro_func < @salario_medio
	PRINT @nome_func + 'recebe abaixo da m�dia'
ELSE
	PRINT @nome_func + 'recebe na m�dia ou acima'


-- Verificar se um Funcion�rio Est� Pr�ximo da Aposentadoria, considerar a
-- idade para aposentadoria de 60 anos
DECLARE @Idade INT,
		@nome VARCHAR(100) = 'Ronaldinho Ga�cho',
		@dataNasc DATE;

SELECT @dataNasc = F.Datanasc
FROM FUNCIONARIO AS F
WHERE f.Pnome = @nome
set @Idade = YEAR(GETDATE()) - YEAR(@dataNasc); 

IF @Idade > 55 AND @idade <= 60
	PRINT 'Aposentadoria chegando'
ELSE IF @Idade > 61 AND @Idade < 80
	PRINT 'Devia parar ein'
ELSE IF @Idade >= 89
	PRINT 'DEUS PUXOU'
ELSE
	PRINT 'VAI CAPINA UM LOTE'


-- Verificar se um Funcion�rio J� Recebeu B�nus Este Ano
DECLARE @bonusSalarial DECIMAL(10,2),
        @id_func INT;

SELECT @id_func = F.Cpf
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Ronaldinho Ga�cho';

-- Agora verificamos se houve algum b�nus neste ano
SELECT @bonusSalarial = SUM(F.Bonus)
FROM FUNCIONARIO AS F
WHERE F.Cpf = @id_func
  AND YEAR(F.Data_Admissao) = YEAR(GETDATE());

IF @bonusSalarial IS NOT NULL AND @bonusSalarial > 0
    PRINT 'Funcion�rio j� recebeu b�nus este ano.'
ELSE
    PRINT 'Funcion�rio ainda n�o recebeu b�nus este ano.'