USE EMPRESA;

/* 7. Crie uma função fn_QtdProjetosFuncionario que receba o CPF de um funcionário e
retorne o número de projetos nos quais ele trabalha (tabela TRABALHA_EM). */

CREATE FUNCTION fn_QtdProjetosFuncionario(@cpf CHAR(11))
RETURNS INT
AS 
BEGIN
	DECLARE @Qtd INT;

	SELECT @Qtd = COUNT(*)
	FROM TRABALHA_EM as T
	WHERE Fcpf = @cpf;

	RETURN ISNULL(@Qtd, 0);
END;

SELECT dbo.fn_QtdProjetosFuncionario('33344555587') AS 'Quantidade de projetos'; -- Fernando Wong

