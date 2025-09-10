USE EMPRESA;
/* As funções no SQL Server permitem encapsular lógicas de
processamento que podem ser reutilizadas em consultas. Diferente das
Stored Procedures, elas retornam obrigatoriamente um valor (escalar ou
tabela) e podem ser usadas diretamente em instruções SELECT, WHERE,
etc.	*/

-- SEMPRE RECOMENDAVEL CRIAR UM NOVO SCRIPT PARA CADA FUNÇÃO !!!

CREATE FUNCTION fn_Dobro(@Numero INT)
RETURNS INT
AS
BEGIN
	RETURN @Numero * 2;
END;