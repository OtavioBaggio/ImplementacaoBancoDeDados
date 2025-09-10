USE EMPRESA;

/*8. Crie uma função fn_RankingSalarioDepartamento que receba o número de um
departamento e retorne uma tabela com os funcionários desse departamento,
incluindo:
	a. Nome completo
	b. Salário
	c. Posição no ranking de salários (1 = maior salário do departamento).
	d. Dica: Use ROW_NUMBER() dentro da função.		*/

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
