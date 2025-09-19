USE EMPRESA;

-- Exemplo V:
--	Altere o procedimento sp_FuncionarioDepartamento para que receba o nome do
--	departamento e liste todos os funcionários que fazem parte do mesmo

ALTER PROCEDURE sp_FuncionarioDepartamento
	@nome_Departamento varchar(100)
AS
BEGIN
	SELECT concat(F.Pnome, ' ', F.Unome) as 'Nomes', D.Dnome as 'Departamento'
	FROM FUNCIONARIO AS F
	INNER JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
	WHERE D.Dnome = @nome_Departamento;
END;

EXEC sp_FuncionarioDepartamento 'Pesquisa'; 

