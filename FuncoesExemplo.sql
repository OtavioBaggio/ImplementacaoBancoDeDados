USE EMPRESA;
/* As fun��es no SQL Server permitem encapsular l�gicas de
processamento que podem ser reutilizadas em consultas. Diferente das
Stored Procedures, elas retornam obrigatoriamente um valor (escalar ou
tabela) e podem ser usadas diretamente em instru��es SELECT, WHERE,
etc.	*/

-- SEMPRE RECOMENDAVEL CRIAR UM NOVO SCRIPT PARA CADA FUN��O !!!

CREATE FUNCTION fn_Dobro(@Numero INT)
RETURNS INT
AS
BEGIN
	RETURN @Numero * 2;
END;