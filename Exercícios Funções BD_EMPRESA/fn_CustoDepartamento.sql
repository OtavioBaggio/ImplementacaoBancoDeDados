USE EMPRESA;

/*9. Crie uma função fn_CustoDepartamento que receba o número de um departamento
e retorne a soma dos salários de todos os funcionários do departamento (ou seja,
quanto custa manter esse time por mês)	*/

CREATE FUNCTION fn_CustoDepartamento(@Dnum INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @custo DECIMAL(18,2)

	SELECT @custo = SUM(Salario)
	FROM FUNCIONARIO
	WHERE Dnr = @Dnum;

	RETURN ISNULL(@custo, 0);
END;

SELECT dbo.fn_CustoDepartamento(5) AS 'Custo do Time';

-- 10. Teste a função mostrando o custo mensal de cada departamento:
SELECT D.Dnome as 'Departamento', dbo.fn_CustoDepartamento(D.Dnumero) AS 'Custo Mensal'
FROM DEPARTAMENTO D;