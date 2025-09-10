-- Criar uma função que calcula a idade de um funcionário com base na data de nascimento 
CREATE FUNCTION fn_CalculaIdade(@dataNasc DATE)
RETURNS INT
AS
BEGIN
	DECLARE @idade int;
	SET @idade = DATEDIFF(YEAR, @dataNasc , GETDATE());
	IF(MONTH(@dataNasc) > MONTH(GETDATE())
		OR (MONTH(@dataNasc)) = MONTH(GETDATE())
		AND DAY(@dataNasc) > DAY(GETDATE()))
		SET @idade = @idade -1;

	return @idade;
END;
GO

SELECT F.Pnome, F.Datanasc, dbo.fn_CalculaIdade(F.Datanasc) as 'Idade'
FROM FUNCIONARIO AS F