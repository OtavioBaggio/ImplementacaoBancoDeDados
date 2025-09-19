USE EMPRESA;

-- Exemplo V:
--  Crie uma procedure que atualiza o sal�rio de um funcion�rio baseado no CPF, se
--  n�o encontrar nenhum funcion�rio com o CPF passado exiba uma mensagem.

ALTER PROCEDURE usp_AtualizarFuncionario
	@Cpf VARCHAR(11),
	@NovoSalario DECIMAL(10,2)
AS
BEGIN
	-- Atualiza
	UPDATE FUNCIONARIO
	SET Salario = @NovoSalario
	WHERE Cpf = @Cpf;

	IF @@ROWCOUNT = 0
		PRINT 'N�o, ninguem com o CPF: ' + @Cpf;
END;

EXEC usp_AtualizarFuncionario '98765432200', 15000.00; 
EXEC usp_AtualizarFuncionario '00000000000', 15000.00;	-- ir� chamar o print da funcao

SELECT * FROM FUNCIONARIO;