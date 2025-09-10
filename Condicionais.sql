USE EMPRESA;

----- CONDICIONAIS IF/ELSE -----

-- Verificar se um Funcionário Recebe Abaixo da Média Salarial
DECLARE @salario_medio DECIMAL(10,2),
		@salaro_func DECIMAL(10,2),
		@nome_func VARCHAR(100) = 'Ana';

SELECT @salario_medio = AVG(F.Salario)
FROM FUNCIONARIO AS F;

SELECT @salaro_func = F.Salario
FROM FUNCIONARIO AS F
WHERE F.Pnome = @nome_func;

IF @salaro_func < @salario_medio
	PRINT @nome_func + 'recebe abaixo da média'
ELSE
	PRINT @nome_func + 'recebe na média ou acima'


-- Verificar se um Funcionário Está Próximo da Aposentadoria, considerar a
-- idade para aposentadoria de 60 anos
DECLARE @Idade INT,
		@nome VARCHAR(100) = 'Ronaldinho Gaúcho',
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


-- Verificar se um Funcionário Já Recebeu Bônus Este Ano
DECLARE @bonusSalarial DECIMAL(10,2),
        @id_func INT;

SELECT @id_func = F.Cpf
FROM FUNCIONARIO AS F
WHERE F.Pnome = 'Ronaldinho Gaúcho';

-- Agora verificamos se houve algum bônus neste ano
SELECT @bonusSalarial = SUM(F.Bonus)
FROM FUNCIONARIO AS F
WHERE F.Cpf = @id_func
  AND YEAR(F.Data_Admissao) = YEAR(GETDATE());

IF @bonusSalarial IS NOT NULL AND @bonusSalarial > 0
    PRINT 'Funcionário já recebeu bônus este ano.'
ELSE
    PRINT 'Funcionário ainda não recebeu bônus este ano.'