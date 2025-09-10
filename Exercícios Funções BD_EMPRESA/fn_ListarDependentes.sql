USE EMPRESA;

/* 2. Crie uma fun��o fn_ListarDependentes que receba o Cpf de um funcion�rio e
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
