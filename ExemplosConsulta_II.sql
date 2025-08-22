select * from FUNCIONARIO;

----- INNER JOIN: -----

-- Selecionar o primeiro nome, �ltimo nome, endere�o dos funcion�rios que trabalham no departamento de
-- �Pesquisa�.
select f.Pnome, f.Unome, D.Dnome
from funcionario as F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa';

-- Liste o nome dos funcion�rios que est�o desenvolvendo o �ProdutoX�. 
select F.Pnome, F.Unome, P.Projnome
from funcionario as F
INNER JOIN TRABALHA_EM AS TE
ON TE.Fcpf = F.Cpf
INNER JOIN PROJETO AS P
ON TE.Pnr = P.Projnumero
WHERE P.Projnome = 'ProdutoX';

-- Para cada projeto localizado em �Mau�, liste o n�mero do projeto, o n�mero do departamento que o 
-- controla e o sobrenome, endere�o e data de nascimento do gerente do departamento.
select 
	P.Projlocal, 
	P.Projnumero, 
	D.Dnumero, 
	F.Unome, 
	F.Endereco, 
	F.Datanasc
from PROJETO AS P
INNER JOIN DEPARTAMENTO AS D
	ON P.Dnum = D.Dnumero
INNER JOIN FUNCIONARIO AS F
	ON D.Cpf_gerente = F.Cpf
WHERE P.Projlocal = 'Mau�';


----- LEFT JOIN: -----

-- Liste o �ltimo nome de TODOS os funcion�rios e o �ltimo nome dos respectivos gerentes, 
-- caso possuam
select 
	F.Unome as 'Nome',
	F.Unome as 'Sobrenome',
	S.Unome as 'Superviso/Gerente'
from FUNCIONARIO AS F
LEFT JOIN FUNCIONARIO AS S  -- Supervisores/Gerentes
ON F.Cpf_supervisor = S.Cpf;

-- Inserir 3 novos departamentos e 3 novos funcion�rios sem um departamento
-- Encontre os departamentos que n�o possuem funcion�rios a eles vinculados
select *
from DEPARTAMENTO AS D
LEFT JOIN FUNCIONARIO AS F
ON D.Dnumero = F.Dnr
WHERE F.Dnr IS NULL;

-- Encontre os funcion�rios que n�o possuem um departamento a eles vinculado
select *
from FUNCIONARIO as F
LEFT JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnumero IS NULL;


----- RIGHT JOIN: -----

-- Encontre os departamentos que n�o possuem nenhum funcion�rio
select D.Dnome
from FUNCIONARIO AS F
RIGHT JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero;


----- CROSS JOIN: -----

-- Teste entre as rela��es Funcion�rios e Departamento
select *
from FUNCIONARIO AS F
FULL JOIN DEPARTAMENTO AS D
ON F.Salario = D.Dnumero;


----- SELF JOIN: -----
	-- � um tipo de opera��o de jun��o em SQL que une uma tabela a si mesma, permitindo comparar ou 
	-- combinar dados dentro da mesma tabela. Para realizar um Self Join, � necess�rio criar uma 
	-- c�pia virtual da tabela usando aliases de tabela diferentes (como t1 e t2) na cl�usula FROM ou JOIN. 
	-- Isto � fundamental porque a SQL n�o permite referenciar a mesma tabela duas vezes na mesma consulta sem aliases, o que resultaria num erro. 


-- Crie uma consulta que mostra apenas os funcion�rios que t�m um supervisor.
select 
	T1.Unome as 'Nome',
	T1.Unome as 'Sobrenome',
	T2.Unome as 'Superviso/Gerente'
from FUNCIONARIO AS T1
JOIN FUNCIONARIO AS T2
ON T1.Cpf_supervisor = T2.Cpf;


----- SQL UNION: -----
/* O operador UNION � usado para combinar o conjunto de resultados de duas ou mais instru��es SELECT.
   Cada instru��o SELECT dentro de UNION deve ter o mesmo n�mero de colunas
   As colunas tamb�m devem ter tipos de dados semelhantes
   As colunas em cada instru��o SELECT tamb�m devem estar na mesma ordem	*/

-- Listar todos os nomes, sexo e data de nascimento de todas as pessoas do banco.
select F.Pnome, F.Sexo, F.Datanasc
from FUNCIONARIO AS F
UNION 
select D.Nome_dependente, D.Sexo, D.Datanasc
from DEPENDENTE AS D;

-- Imagine que a diretoria da empresa quer uma lista de todas as cidades onde a empresa possui
-- alguma atividade, seja a localiza��o de um departamento ou a localiza��o de um projeto
select P.Projlocal
from PROJETO AS P 
UNION -- Se usarmos o UNION ALL, ir� exibir os valores duplicados; 
select L.Dlocal
from LOCALIZACAO_DEP AS L;


----- SQL EXCEPT: -----

-- Listar os CPFs dos funcion�rios que n�o s�o gerentes de nenhum departamento.
select F.Cpf
from FUNCIONARIO AS F
EXCEPT
select D.Cpf_gerente
from DEPARTAMENTO AS D;

-- Encontre os Funcion�rios que N�O s�o Supervisores:
select F.Pnome, F.Unome
from FUNCIONARIO AS F
WHERE F.Cpf IN (
				select F.Cpf 
				from FUNCIONARIO AS F
				EXCEPT
				select F.Cpf_supervisor
				from FUNCIONARIO AS f);



----- SQL INTERSECT: -----

-- Encontre os Funcion�rios que s�o Supervisores
SELECT F.Pnome, F.Unome
FROM FUNCIONARIO AS F
WHERE F.Cpf IN (
    SELECT Cpf FROM FUNCIONARIO
    INTERSECT
    SELECT Cpf_supervisor FROM FUNCIONARIO WHERE Cpf_supervisor IS NOT NULL
);


----- SQL Declaracao GOUP BY -----
/*
	A instru��o GROUP BY agrupa linhas com os mesmos valores em linhas de
resumo, como "encontre o n�mero de clientes em cada pa�s".
A instru��o GROUP BY � frequentemente usada com fun��es agregadas
(COUNT(), MAX(), MIN(), SUM(), AVG()) para agrupar o conjunto de resultados
por uma ou mais colunas.
*/

-- Contar o n�mero de funcion�rios por departamento:
select COUNT(F.Cpf) AS 'Numero Funcionarios', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- Somar os sal�rios por departamento:
select SUM(F.Salario) AS 'Sal�rio', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- M�dia de horas trabalhadas por projeto:
select AVG(t.Horas) AS 'Horas Trabalhadas', P.Projnome AS 'Nome do Projeto'
from TRABALHA_EM AS T
JOIN PROJETO AS P
	ON T.Pnr = P.Projnumero
GROUP BY P.Projnome;

-- Quantidade de funcion�rios por sexo:
SELECT F.Sexo, COUNT(*) AS Quantidade
FROM FUNCIONARIO AS F
GROUP BY F.Sexo;

-- Maior sal�rio em cada departamento:
select MAX(F.Salario) as 'Maior Sal�rio', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- N�mero de projetos em cada local:
select COUNT(P.Projnumero) as 'Numero de Projetos', L.Dlocal as 'Localizacao'
from PROJETO AS P
JOIN LOCALIZACAO_DEP AS L
	ON P.Projlocal = L.Dlocal
GROUP BY L.Dlocal;


----- SQL Clausula HAVING -----
/* A cl�usula HAVING foi adicionada ao SQL porque a palavra-chave WHERE n�o
pode ser usada com fun��es agregadas.	*/

-- Encontrar departamentos com mais de 3 funcion�rios:
select COUNT(F.Cpf) as 'Funcionario', D.Dnome as 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome
HAVING COUNT(F.Cpf) > 3;

-- Listar projetos que exigem no minimo 50 horas de trabalho no total
select P.Projnome as 'Projeto', SUM(TE.Horas) as 'Horas'
from TRABALHA_EM AS TE
INNER JOIN PROJETO AS P
	ON TE.Pnr = P.Projnumero
GROUP BY P.Projnome
HAVING SUM(TE.Horas) >= 50;


----- SQL Operador EXISTS -----

-- Listar funcion�rios que s�o gerentes de algum departamento
select F.Pnome as 'Nome', F.Unome as 'Sobrenome', F.Cpf
from FUNCIONARIO AS F
WHERE EXISTS (
				select 1
				from DEPARTAMENTO AS D 
				where D.Cpf_gerente = F.Cpf
				);




