--		CASE

-- CLassificar funcionarios por faixa salarial
	-- At� 20k - Baixo 
	-- Entre 20k - 40k - M�dio
	-- Acima de 40k - Alto

SELECT 
	Pnome as Nome,
	Unome as Sobrenome,
	Salario,
	CASE
		WHEN Salario < 20000 THEN 'Baixo'
		WHEN Salario BETWEEN 20000 AND 40000 THEN 'Medio'
		WHEN Salario > 40000 THEN 'Alto'
		ELSE 'Sem registro !'
	END as 'Categoria'
FROM FUNCIONARIO;


-- Verificar com CASE, se o funcion�rio foi contratado nos �ltimos 6 meses:
SELECT
	f.Pnome as Nome,
	f.Unome as Sobrenome,
	f.Data_Admissao,
	CAST(GETDATE() AS DATE) AS 'Hoje',
	CASE
		WHEN DATEDIFF(DAY, f.Data_Admissao, GETDATE()) <= 180 THEN 'Rec�m-admitido'
		ELSE 'Admitido h� mais de 6 meses'
	END as 'Tempo de admiss�o'
FROM FUNCIONARIO AS F;

INSERT INTO FUNCIONARIO(Pnome, Unome, Minicial, Cpf, Data_Admissao)
VALUES('Genoveva', 'Thesc', 'H', '123155', '2025-09-10');

