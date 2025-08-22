select * from FUNCIONARIO;

----- INNER JOIN: -----

-- Selecionar o primeiro nome, último nome, endereço dos funcionários que trabalham no departamento de
-- “Pesquisa”.
select f.Pnome, f.Unome, D.Dnome
from funcionario as F
INNER JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnome = 'Pesquisa';

-- Liste o nome dos funcionários que estão desenvolvendo o “ProdutoX”. 
select F.Pnome, F.Unome, P.Projnome
from funcionario as F
INNER JOIN TRABALHA_EM AS TE
ON TE.Fcpf = F.Cpf
INNER JOIN PROJETO AS P
ON TE.Pnr = P.Projnumero
WHERE P.Projnome = 'ProdutoX';

-- Para cada projeto localizado em “Mauá”, liste o número do projeto, o número do departamento que o 
-- controla e o sobrenome, endereço e data de nascimento do gerente do departamento.
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
WHERE P.Projlocal = 'Mauá';


----- LEFT JOIN: -----

-- Liste o último nome de TODOS os funcionários e o último nome dos respectivos gerentes, 
-- caso possuam
select 
	F.Unome as 'Nome',
	F.Unome as 'Sobrenome',
	S.Unome as 'Superviso/Gerente'
from FUNCIONARIO AS F
LEFT JOIN FUNCIONARIO AS S  -- Supervisores/Gerentes
ON F.Cpf_supervisor = S.Cpf;

-- Inserir 3 novos departamentos e 3 novos funcionários sem um departamento
-- Encontre os departamentos que não possuem funcionários a eles vinculados
select *
from DEPARTAMENTO AS D
LEFT JOIN FUNCIONARIO AS F
ON D.Dnumero = F.Dnr
WHERE F.Dnr IS NULL;

-- Encontre os funcionários que não possuem um departamento a eles vinculado
select *
from FUNCIONARIO as F
LEFT JOIN DEPARTAMENTO AS D
ON F.Dnr = D.Dnumero
WHERE D.Dnumero IS NULL;


----- RIGHT JOIN: -----

-- Encontre os departamentos que não possuem nenhum funcionário
select D.Dnome
from FUNCIONARIO AS F
RIGHT JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero;


----- CROSS JOIN: -----

-- Teste entre as relações Funcionários e Departamento
select *
from FUNCIONARIO AS F
FULL JOIN DEPARTAMENTO AS D
ON F.Salario = D.Dnumero;


----- SELF JOIN: -----
	-- é um tipo de operação de junção em SQL que une uma tabela a si mesma, permitindo comparar ou 
	-- combinar dados dentro da mesma tabela. Para realizar um Self Join, é necessário criar uma 
	-- cópia virtual da tabela usando aliases de tabela diferentes (como t1 e t2) na cláusula FROM ou JOIN. 
	-- Isto é fundamental porque a SQL não permite referenciar a mesma tabela duas vezes na mesma consulta sem aliases, o que resultaria num erro. 


-- Crie uma consulta que mostra apenas os funcionários que têm um supervisor.
select 
	T1.Unome as 'Nome',
	T1.Unome as 'Sobrenome',
	T2.Unome as 'Superviso/Gerente'
from FUNCIONARIO AS T1
JOIN FUNCIONARIO AS T2
ON T1.Cpf_supervisor = T2.Cpf;


----- SQL UNION: -----
/* O operador UNION é usado para combinar o conjunto de resultados de duas ou mais instruções SELECT.
   Cada instrução SELECT dentro de UNION deve ter o mesmo número de colunas
   As colunas também devem ter tipos de dados semelhantes
   As colunas em cada instrução SELECT também devem estar na mesma ordem	*/

-- Listar todos os nomes, sexo e data de nascimento de todas as pessoas do banco.
select F.Pnome, F.Sexo, F.Datanasc
from FUNCIONARIO AS F
UNION 
select D.Nome_dependente, D.Sexo, D.Datanasc
from DEPENDENTE AS D;

-- Imagine que a diretoria da empresa quer uma lista de todas as cidades onde a empresa possui
-- alguma atividade, seja a localização de um departamento ou a localização de um projeto
select P.Projlocal
from PROJETO AS P 
UNION -- Se usarmos o UNION ALL, irá exibir os valores duplicados; 
select L.Dlocal
from LOCALIZACAO_DEP AS L;


----- SQL EXCEPT: -----

-- Listar os CPFs dos funcionários que não são gerentes de nenhum departamento.
select F.Cpf
from FUNCIONARIO AS F
EXCEPT
select D.Cpf_gerente
from DEPARTAMENTO AS D;

-- Encontre os Funcionários que NÃO são Supervisores:
select F.Pnome, F.Unome
from FUNCIONARIO AS F
WHERE F.Cpf IN (
				select F.Cpf 
				from FUNCIONARIO AS F
				EXCEPT
				select F.Cpf_supervisor
				from FUNCIONARIO AS f);



----- SQL INTERSECT: -----

-- Encontre os Funcionários que são Supervisores
SELECT F.Pnome, F.Unome
FROM FUNCIONARIO AS F
WHERE F.Cpf IN (
    SELECT Cpf FROM FUNCIONARIO
    INTERSECT
    SELECT Cpf_supervisor FROM FUNCIONARIO WHERE Cpf_supervisor IS NOT NULL
);


----- SQL Declaracao GOUP BY -----
/*
	A instrução GROUP BY agrupa linhas com os mesmos valores em linhas de
resumo, como "encontre o número de clientes em cada país".
A instrução GROUP BY é frequentemente usada com funções agregadas
(COUNT(), MAX(), MIN(), SUM(), AVG()) para agrupar o conjunto de resultados
por uma ou mais colunas.
*/

-- Contar o número de funcionários por departamento:
select COUNT(F.Cpf) AS 'Numero Funcionarios', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- Somar os salários por departamento:
select SUM(F.Salario) AS 'Salário', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- Média de horas trabalhadas por projeto:
select AVG(t.Horas) AS 'Horas Trabalhadas', P.Projnome AS 'Nome do Projeto'
from TRABALHA_EM AS T
JOIN PROJETO AS P
	ON T.Pnr = P.Projnumero
GROUP BY P.Projnome;

-- Quantidade de funcionários por sexo:
SELECT F.Sexo, COUNT(*) AS Quantidade
FROM FUNCIONARIO AS F
GROUP BY F.Sexo;

-- Maior salário em cada departamento:
select MAX(F.Salario) as 'Maior Salário', D.Dnome AS 'Departamento'
from FUNCIONARIO AS F
JOIN DEPARTAMENTO AS D
	ON F.Dnr = D.Dnumero
GROUP BY D.Dnome;

-- Número de projetos em cada local:
select COUNT(P.Projnumero) as 'Numero de Projetos', L.Dlocal as 'Localizacao'
from PROJETO AS P
JOIN LOCALIZACAO_DEP AS L
	ON P.Projlocal = L.Dlocal
GROUP BY L.Dlocal;


----- SQL Clausula HAVING -----
/* A cláusula HAVING foi adicionada ao SQL porque a palavra-chave WHERE não
pode ser usada com funções agregadas.	*/

-- Encontrar departamentos com mais de 3 funcionários:
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

-- Listar funcionários que são gerentes de algum departamento
select F.Pnome as 'Nome', F.Unome as 'Sobrenome', F.Cpf
from FUNCIONARIO AS F
WHERE EXISTS (
				select 1
				from DEPARTAMENTO AS D 
				where D.Cpf_gerente = F.Cpf
				);




