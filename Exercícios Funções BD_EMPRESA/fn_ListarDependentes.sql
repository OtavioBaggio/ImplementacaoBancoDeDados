USE EMPRESA;

/* 2. Crie uma função fn_ListarDependentes que receba o Cpf de um funcionário e
retorne uma tabela com os nomes e parentescos de todos os seus dependentes */

CREATE FUNCTION fn_ListarDependentes(@cpf CHAR(11))
RETURNS TABLE
AS
RETURN(
	SELECT D.Nome_dependente as 'Dependente', Parentesco
	FROM DEPENDENTE AS D
	WHERE Fcpf = @cpf
);

SELECT * FROM dbo.fn_ListarDependentes(12345678966);
