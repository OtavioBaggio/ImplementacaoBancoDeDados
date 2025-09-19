USE EMPRESA;
/*
Par�metros de Sa�da
Os par�metros de sa�da habilitam um procedimento armazenado a retornar
dados ao procedimento chamado.
Usamos a palavra-chave OUTPUT quando o procedimento � criado, tamb�m quando � chamado.
No procedimento armazenado, o procedimento de sa�da aparece como uma
vari�vel local; No procedimento chamador, uma vari�vel deve ser criada
para receber o par�metro de sa�da;	*/

CREATE PROCEDURE usp_dobro(@valor AS INT OUTPUT)
AS
SELECT @valor * 2 
RETURN			--> O comando RETURN termina incondicionalmente o procedimento e retorna um valor inteiro ao chamador
				--> Pode ser usado para retornar status de sucesso ou falha de procedimento

-- Testanto o procedimento:
DECLARE @custo AS INT = 15;
EXEC usp_dobro @custo OUTPUT;
PRINT @custo;