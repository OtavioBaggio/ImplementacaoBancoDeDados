-- Verificar o tamando de uma departamento, se tiver at� 1 funcion�rio o
-- departamento � �pequeno�, se tiver de 2 a 3 pessoas o departamento �
-- �medio�, se tiver mais de 3 � uma departamento �grande�
DECLARE @QtdFuncionarios INT;

SELECT @QtdFuncionarios = count(F.Cpf)
FROM FUNCIONARIO AS F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa';

PRINT @QtdFuncionarios;

IF(@QtdFuncionarios <= 1)
	PRINT 'Quantidade de Funcionarios: ' + CAST(@QtdFuncionarios AS VARCHAR(10)) + ', Pequeno';
ELSE IF (@QtdFuncionarios >= 2 AND @QtdFuncionarios <= 3)
	PRINT 'Quantidade de Funcionarios: ' + CAST(@QtdFuncionarios AS VARCHAR(10)) + ', Medio';
ELSE
	PRINT 'Quantidade de Funcionarios: ' + CAST(@QtdFuncionarios AS VARCHAR(10)) + ', Grande';



------- WHILE -------
DECLARE @valor INT;
SET @valor = 0;

WHILE @valor < 10
	BEGIN
	PRINT 'N�mero:' + CAST(@valor AS VARCHAR(2))
	SET @valor = @valor+1;
	END

-- Aumentar o sal�rio da �Joice Leite� em 5% repetidamente at� que ele chegue em R$ 30.000.
DECLARE @salariojoice decimal(10,2);

select @salariojoice = F.Salario
FROM FUNCIONARIO AS F
WHERE f.Pnome = 'Joice' AND F.Unome = 'Leite';

WHILE (@salariojoice >= 30000)
	BEGIN
		PRINT @salariojoice;
		SET @salariojoice = @salariojoice * 1.05;
	END;
PRINT @salariojoice;