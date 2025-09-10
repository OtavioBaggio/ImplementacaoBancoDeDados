USE EMPRESA;

/* 6. Crie uma fun��o fn_TemMaisQueNDependentes que receba um n�mero N e o CPF
de um funcion�rio, retornando 1 se ele tiver mais que N dependentes e 0 caso
contr�rio	*/

CREATE FUNCTION fn_TemMaisQueNDependentes(@cpf CHAR(11), @Num int)
RETURNS BIT
AS
BEGIN
	DECLARE @Qtd INT;
    DECLARE @Result BIT;

    -- Conta os dependentes do funcion�rio
    SELECT @Qtd = COUNT(*)
    FROM DEPENDENTE
    WHERE Fcpf = @Cpf;

    -- Verifica se a quantidade � maior que N
    IF @Qtd > @Num
        SET @Result = 1;
    ELSE
        SET @Result = 0;

    RETURN @Result;
END;

SELECT dbo.fn_TemMaisQueNDependentes(12345678966, 2) as 'Mais que 2 Dependentes';


