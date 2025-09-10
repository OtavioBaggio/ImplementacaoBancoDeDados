USE EMPRESA;

/* 3. Crie uma função fn_NomeSupervisor que receba o Cpf de um funcionário e retorne o
nome completo do seu supervisor (usando a coluna Cpf_supervisor da tabela
FUNCIONARIO).	*/

CREATE FUNCTION fn_NomeSupervisor(@cpf CHAR(11))
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @Nome VARCHAR(50)

	SELECT @Nome = (S.Pnome + ' ' + ISNULL(S.Minicial, '') + ' ' + S.Unome)
	FROM FUNCIONARIO as F
	INNER JOIN FUNCIONARIO as S ON F.Cpf_supervisor = S.Cpf
	WHERE F.Cpf = @cpf;

	RETURN @Nome;
END;

SELECT dbo.fn_NomeSupervisor(45345345376) as NomeSupervisor;
