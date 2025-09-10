-- Fun��o com Mais de Um Par�metro

-- Queremos calcular o sal�rio anual de um funcion�rio (12 meses), mas tamb�m considerar um b�nus vari�vel (%), passado como par�metro.
CREATE FUNCTION fn_salarioBonus(
	@salario float, @bonus int
)
RETURNS FLOAT
AS
BEGIN
	RETURN @salario * 12 *(@bonus + 100 * 1);
END;
GO


