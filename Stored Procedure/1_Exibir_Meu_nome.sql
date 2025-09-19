USE EMPRESA;

/*
Stored Procedure - Procedimento Armazenado

Definição:
São lotes (batches) de declarações SQL que podem ser executados como
uma subrotina.
Permitem centralizar a lógica de acesso aos dados em único local,
facilitando a manutenção e otimização de código.
Também é possível ajustar permissões de acesso aos usuários, definindo
quem pode ou não executá-las	*/

-- Exemplo I:
--	Crie um procedimento que exiba seu nome:

ALTER PROCEDURE USP_exibir_Meu_Nome 
	@Nome varchar(100)
AS
BEGIN
	PRINT 'Seu nome é: ' + @nome;
END;

EXEC USP_exibir_Meu_Nome 'José Otávio R. Baggio';
