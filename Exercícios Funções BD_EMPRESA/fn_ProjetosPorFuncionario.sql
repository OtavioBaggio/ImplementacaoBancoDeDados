USE EMPRESA;

/* 1. Crie uma função fn_ProjetosPorFuncionario que receba o Cpf de um funcionário e
retorne os nomes dos projetos nos quais ele trabalha (usando a tabela
TRABALHA_EM). */

CREATE FUNCTION fn_ProjetosPorFuncionario(@cpf CHAR(11))
RETURNS TABLE
AS
RETURN(
	SELECT P.Projnome
	FROM TRABALHA_EM AS T
	INNER JOIN PROJETO AS P ON T.Pnr = P.Projnumero
	WHERE T.Fcpf = @cpf
);

SELECT * FROM dbo.fn_ProjetosPorFuncionario(98765432168);
