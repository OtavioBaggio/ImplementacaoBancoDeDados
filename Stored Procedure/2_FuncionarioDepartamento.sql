USE EMPRESA;

-- Exemplo II:
--	Crie um procedure que liste o nome completo dos funcionários e o nome dos seus respectivos departamentos.

CREATE PROCEDURE sp_FuncionarioDepartamento
AS
BEGIN
	SELECT concat(F.Pnome, ' ', F.Unome) as 'Nomes', D.Dnome as 'Departamento'
	FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
END;

EXEC sp_FuncionarioDepartamento;

-- Use o procedimento armazenado sp_helptext para extrair o conteúdo de texto de um stored procedure.
EXEC sp_helptext sp_FuncionarioDepartamento;
