USE EMPRESA;

/* 5. Crie uma fun��o fn_AnoAposentadoria que receba a data de nascimento de um
funcion�rio e retorne o ano em que ele poder� se aposentar, considerando 65 anos
como idade de aposentadoria. */

CREATE FUNCTION fn_AnoAposentadoria(@Data_nascimento DATE)
RETURNS INT
AS 
BEGIN
	RETURN YEAR(@Data_nascimento) + 65;
END;

SELECT dbo.fn_AnoAposentadoria('1965-01-09') AS 'Ano da Aposentadoria'; -- Jo�o Silva
SELECT dbo.fn_AnoAposentadoria('1941-06-20') AS 'Ano da Aposentadoria'; -- Jennifer
SELECT dbo.fn_AnoAposentadoria('1955-12-08') AS 'Ano da Aposentadoria'; -- Fernando
SELECT dbo.fn_AnoAposentadoria('1972-07-31') AS 'Ano da Aposentadoria'; -- Joice

