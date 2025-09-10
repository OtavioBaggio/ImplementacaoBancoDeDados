USE EMPRESA;

/* 11. Crie uma função fn_NomeDependentesFuncionario que receba o CPF de um
funcionário e retorne uma string concatenada com os nomes de todos os seus
dependentes.
a. Exemplo: João Silva → "Maria Silva, Pedro Silva, Ana Silva"
b. Dica: Use STRING_AGG (SQL Server 2017+)	*/

CREATE FUNCTION fn_NomeDependentesFuncionario(@cpf CHAR(11))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Nomes VARCHAR(MAX)

	SELECT @Nomes = STRING_AGG(Nome_dependente + ' (' + Parentesco + ')', ', ')
	FROM DEPENDENTE
	WHERE Fcpf = @cpf;

	RETURN ISNULL(@Nomes, 'Usuario nao possui Dependente cadastrado');
END;

SELECT dbo.fn_NomeDependentesFuncionario('12345678966') AS 'Dependentes de Joao';
