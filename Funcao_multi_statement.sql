-- Fun��es de tabela (multi-statement) - retornam uma tabela constru�da dentro da fun��o com m�ltiplas instru��es.

-- Criar uma fun��o que retorna nome completo dos funcion�rios e o valor do sal�rio anual, com f�rias e d�cimo terceiro;
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