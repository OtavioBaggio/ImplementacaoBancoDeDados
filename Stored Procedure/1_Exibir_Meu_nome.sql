USE EMPRESA;

/*
Stored Procedure - Procedimento Armazenado

Defini��o:
S�o lotes (batches) de declara��es SQL que podem ser executados como
uma subrotina.
Permitem centralizar a l�gica de acesso aos dados em �nico local,
facilitando a manuten��o e otimiza��o de c�digo.
Tamb�m � poss�vel ajustar permiss�es de acesso aos usu�rios, definindo
quem pode ou n�o execut�-las	*/

-- Exemplo I:
--	Crie um procedimento que exiba seu nome:

ALTER PROCEDURE USP_exibir_Meu_Nome 
	@Nome varchar(100)
AS
BEGIN
	PRINT 'Seu nome �: ' + @nome;
END;

EXEC USP_exibir_Meu_Nome 'Jos� Ot�vio R. Baggio';
