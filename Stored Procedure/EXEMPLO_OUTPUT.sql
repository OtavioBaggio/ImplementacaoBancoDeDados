USE EMPRESA;
/*
Parâmetros de Saída
Os parâmetros de saída habilitam um procedimento armazenado a retornar
dados ao procedimento chamado.
Usamos a palavra-chave OUTPUT quando o procedimento é criado, também quando é chamado.
No procedimento armazenado, o procedimento de saída aparece como uma
variável local; No procedimento chamador, uma variável deve ser criada
para receber o parâmetro de saída;	*/

CREATE PROCEDURE usp_dobro(@valor AS INT OUTPUT)
AS
SELECT @valor * 2 
RETURN			--> O comando RETURN termina incondicionalmente o procedimento e retorna um valor inteiro ao chamador
				--> Pode ser usado para retornar status de sucesso ou falha de procedimento

-- Testanto o procedimento:
DECLARE @custo AS INT = 15;
EXEC usp_dobro @custo OUTPUT;
PRINT @custo;