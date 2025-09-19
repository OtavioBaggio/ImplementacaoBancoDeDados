USE EMPRESA;


-- Exemplo VIII:
--	Crie um procedure que faz uma listagem dos funcionários por departamento, mas
--	se o departamento não for especificado, o procedimento lista todos os funcionarios

CREATE PROCEDURE sp_EspecificarFuncionarioDepartamento(@departamento VARCHAR(100) = null)
AS
BEGIN
	IF(@departamento is null)
		BEGIN
			SELECT concat(F.Pnome, ' ', F.Unome) as 'Nomes', D.Dnome as 'Departamento'
			FROM FUNCIONARIO AS F
			LEFT JOIN DEPARTAMENTO AS D
			ON F.Dnr = D.Dnumero
		END

	SELECT concat(F.Pnome, ' ', F.Unome) as 'Nomes', D.Dnome as 'Departamento'
	FROM FUNCIONARIO AS F
	LEFT JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = @departamento
END;
GO


EXEC sp_EspecificarFuncionarioDepartamento;

-- Lista apenas os do departamento 'Pesquisa':
EXEC sp_EspecificarFuncionarioDepartamento 'Pesquisa';
