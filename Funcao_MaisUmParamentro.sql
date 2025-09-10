-- Função com Mais de Um Parâmetro

-- Queremos calcular o salário anual de um funcionário (12 meses), mas também considerar um bônus variável (%), passado como parâmetro.
CREATE FUNCTION fn_salarioBonus(
	@salario float, @bonus int
)
RETURNS FLOAT
AS
BEGIN
	RETURN @salario * 12 *(@bonus + 100 * 1);
END;
GO


