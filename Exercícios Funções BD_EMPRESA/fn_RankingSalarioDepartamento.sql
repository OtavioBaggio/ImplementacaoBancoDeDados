USE EMPRESA;

/*8. Crie uma fun��o fn_RankingSalarioDepartamento que receba o n�mero de um
departamento e retorne uma tabela com os funcion�rios desse departamento,
incluindo:
	a. Nome completo
	b. Sal�rio
	c. Posi��o no ranking de sal�rios (1 = maior sal�rio do departamento).
	d. Dica: Use ROW_NUMBER() dentro da fun��o.		*/

CREATE FUNCTION fn_RankingSalarioDepartamento(@Dnumero INT)
RETURNS TABLE
AS
RETURN(
	SELECT
		(Pnome + ' ' + ISNULL(Minicial,'') + ' ' + Unome) AS NomeCompleto,
        Salario,
        ROW_NUMBER() OVER (ORDER BY Salario DESC) AS Ranking
    FROM FUNCIONARIO
    WHERE Dnr = @Dnumero
);

SELECT * FROM dbo.fn_RankingSalarioDepartamento(5); -- Pesquisa
