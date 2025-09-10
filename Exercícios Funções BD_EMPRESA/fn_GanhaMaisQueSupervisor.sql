USE EMPRESA;

/* 4. Crie uma função fn_GanhaMaisQueSupervisor que receba o Cpf de um funcionário
e retorne 1 (verdadeiro) se o salário dele for maior que o salário de seu supervisor,
ou 0 (falso) caso contrário	*/

CREATE FUNCTION fn_GanhaMaisQueSupervisor(@cpf CHAR(11))
RETURNS BIT
AS 
BEGIN
	DECLARE @Result BIT;

	SELECT @Result = CASE WHEN F.Salario > S.Salario THEN 1 ELSE 0 END
	FROM FUNCIONARIO AS F
	INNER JOIN FUNCIONARIO AS S ON F.Cpf_supervisor = S.Cpf
	WHERE F.Cpf = @cpf;

	RETURN @Result;
END;

SELECT dbo.fn_GanhaMaisQueSupervisor(88866555576) AS GanhaMais; -- Jorge
SELECT dbo.fn_GanhaMaisQueSupervisor(98765432168) AS GanhaMais; -- Jenifer
SELECT dbo.fn_GanhaMaisQueSupervisor(12345678966) AS GanhaMais; -- João
SELECT dbo.fn_GanhaMaisQueSupervisor(99988777767) AS GanhaMais; -- Alice
SELECT dbo.fn_GanhaMaisQueSupervisor(66688444476) AS GanhaMais; -- Ronaldo
SELECT dbo.fn_GanhaMaisQueSupervisor(45345345376) AS GanhaMais; -- Joice
SELECT dbo.fn_GanhaMaisQueSupervisor(98798798733) AS GanhaMais; -- André
SELECT dbo.fn_GanhaMaisQueSupervisor(33344555587) AS GanhaMais; -- Fernando Wong
