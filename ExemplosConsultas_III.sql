USE EMPRESA;

select * from FUNCIONARIO;

----- SQL EXISTS: -----

-- Listar departamentos que possuem projetos associados:
SELECT D.Dnome, D.Dnumero
FROM DEPARTAMENTO as D
WHERE EXISTS(
				SELECT 1
				FROM PROJETO AS P
				WHERE P.Dnum = D.Dnumero);

----- SQL ANY E ALL -----

-- Encontrar funcionários que ganham mais do que qualquer funcionário
-- do departamento de 'Administração'
select F.Pnome, F.Unome, F.Salario
from FUNCIONARIO AS F
WHERE F.Salario > ANY(
						select Salario
						from FUNCIONARIO 
						INNER JOIN DEPARTAMENTO
						ON Dnr = Dnumero
						WHERE Dnome = 'Administração'
						);

-- Encontrar projetos que exigem mais horas do que todos os projetos no local 
-- 'Itu'ou 'Santo André'
select P.Projnome as 'Projeto', SUM(TE.Horas) as 'Horas'
from PROJETO AS P
INNER JOIN TRABALHA_EM AS TE
ON TE.Pnr = P.Projnumero
GROUP BY P.Projnome
HAVING SUM(TE.Horas) > ALL(
							select SUM(TE.Horas)
							from PROJETO as P
							INNER JOIN TRABALHA_EM as TE
							ON TE.Pnr = p.Projnumero
							WHERE P.Projlocal = 'Itu' OR P.Projlocal = 'Santo André'
							GROUP BY P.Projlocal
							);





