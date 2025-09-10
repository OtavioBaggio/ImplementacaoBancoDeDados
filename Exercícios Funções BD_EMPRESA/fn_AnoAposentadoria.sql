USE EMPRESA;

/* 5. Crie uma função fn_AnoAposentadoria que receba a data de nascimento de um
funcionário e retorne o ano em que ele poderá se aposentar, considerando 65 anos
como idade de aposentadoria. */

CREATE FUNCTION fn_AnoAposentadoria(@Data_nascimento DATE)
RETURNS INT
AS 
BEGIN
	RETURN YEAR(@Data_nascimento) + 65;
END;

SELECT dbo.fn_AnoAposentadoria('1965-01-09') AS 'Ano da Aposentadoria'; -- João Silva
SELECT dbo.fn_AnoAposentadoria('1941-06-20') AS 'Ano da Aposentadoria'; -- Jennifer
SELECT dbo.fn_AnoAposentadoria('1955-12-08') AS 'Ano da Aposentadoria'; -- Fernando
SELECT dbo.fn_AnoAposentadoria('1972-07-31') AS 'Ano da Aposentadoria'; -- Joice

