SELECT dbo.fn_Dobro(5) AS 'Resultado';

SELECT F.Pnome, F.Unome, F.Salario, dbo.fn_Dobro(F.Salario) AS 'Dobro'
FROM FUNCIONARIO AS F;