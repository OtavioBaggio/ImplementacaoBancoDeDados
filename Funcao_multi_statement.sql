-- Funções de tabela (multi-statement) - retornam uma tabela construída dentro da função com múltiplas instruções.

-- Criar uma função que retorna nome completo dos funcionários e o valor do salário anual, com férias e décimo terceiro;
CREATE FUNCTION fn_salarioAnual()
RETURNS @Tabela TABLE
(
	NomeCompleto VARCHAR(200),
	SalarioMensal DECIMAL(18,2),
	SalarioAnual DECIMAL(12,2)
)
AS
BEGIN
	INSERT INTO @Tabela
	SELECT 
		CONCAT(F.Pnome, ' ', F.Minicial, '. ', F.Unome),
		F.Salario,
		F.Salario * 12
	FROM FUNCIONARIO AS F
	
	RETURN;
END;
GO

SELECT * FROM dbo.fn_salarioAnual();