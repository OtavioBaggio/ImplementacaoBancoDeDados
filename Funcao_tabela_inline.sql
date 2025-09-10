-- Funções de tabela (inline) - retornam uma tabela como resultado de uma query

-- Retornar todos os funcionários de um determinado departamento.
CREATE FUNCTION fn_funcionarioDepartamento(@departamento VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
	SELECT F.Pnome, F.Unome, f.Salario
	FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = @departamento
);
GO

SELECT * FROM dbo.fn_funcionarioDepartamento('Pesquisa');