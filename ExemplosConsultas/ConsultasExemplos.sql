select * from FUNCIONARIO;

-- Liste as diferentes faixas salariais dos funcionários.
select distinct salario
from Funcionario;

-- Recupere todas as informações do(s) funcionarios com primeiro nome “João”.
select *
from Funcionario as F
where F.Pnome = 'João';

-- Liste os funcionários do sexo masculino com salário maior ou igual a 30.000,00R$
select *
from Funcionario as F
where F.Sexo = 'M'
	and F.salario >= 30000.00;

-- Liste os funcionários que moram em São Paulo ou em Curitiba.
select *
from Localizacao_DEP as L
where L.Dlocal in ('São Paulo', 'Curitiba');

-- Liste os funcionários que não moram em São Paulo
select *
from Funcionario as F
where F.Endereco <> '%São Paulo, SP';

-- Preciso cortar orçamento, liste os funcionários em ordem decrescente de salário.
select *
from Funcionario as F
order by F.Salario DESC;

-- Encontre os Funcionário que não possuem supervisor (Cpf_supervisor)
select *
from Funcionario as F
where F.Cpf_supervisor IS NULL;

-- Recupere o(s) nome(s) do(s) funcionário(s) que possuem supervisor
select *
from Funcionario as F
where F.Cpf_supervisor IS NOT NULL;

-- Recupere o registro dos 3 funcionários que têm o maior salário.
select top 3 *
from Funcionario as F
order by F.Salario DESC;

-- Minimo:
select *
from FUNCIONARIO AS F

select MIN(F.salario)
from FUNCIONARIO as F;

SELECT *
FROM FUNCIONARIO AS F
where F.Salario = (SELECT MIN(F.Salario)
					FROM FUNCIONARIO AS F);

-- Declare:
DECLARE @salario_min DECIMAL(10,2);

/*
SELECT @salario_min = (SELECT MIN(F.Salario)
					FROM FUNCIONARIO AS F);
					*/
SET @salario_min = (SELECT MIN(F.Salario)
					FROM FUNCIONARIO AS F);

PRINT @salario_min;

SELECT *
FROM FUNCIONARIO AS F
where F.Salario = @salario_min;

-- COUNT
SELECT COUNT(F.Cpf)
FROM FUNCIONARIO AS F;

-- AVG
SELECT AVG(F.Salario)
FROM FUNCIONARIO AS F;

-- SUM
SELECT SUM(F.Salario)
FROM FUNCIONARIO AS F;

SELECT COUNT(*)
FROM DEPENDENTE;

SELECT
	(SELECT COUNT(*) FROM FUNCIONARIO) AS 'Nr_Funcionáios',
	(SELECT COUNT(*) FROM DEPENDENTE) AS 'Nr_Dependentes',
	(SELECT COUNT(*) FROM FUNCIONARIO) +
	(SELECT COUNT(*) FROM DEPENDENTE) AS total;

DECLARE @nr_funcionarios INT;
DECLARE @nr_dependente INT;

SET @nr_funcionarios = (SELECT COUNT(*) FROM FUNCIONARIO);
SET @nr_dependente = (SELECT COUNT(*) FROM DEPENDENTE);
PRINT @nr_funcionarios+@nr_dependente

SELECT @nr_funcionarios + @nr_dependente AS total;

-- Menor salario:
DECLARE @menor_salario DECIMAL(10,2);
DECLARE @media_salario;

SET @menor_salario = (SELECT MIN(Salario) FROM FUNCIONARIO);
SET @media_salario = (SELECT AVG(Salario) FROM FUNCIONARIO);

PRINT @media_slaario - @menor_salario;

SELECT @media_salario - @menor_salario AS desvio;

-- LIKE
SELECT *
FROM FUNCIONARIO AS F
WHERE YEAR(F.Datanasc) LIKE '__72';

-- Operador IN
SELECT *
FROM FUNCIONARIO AS F
WHERE F.Salario IN(25000, 30000);

-- Recupere os registros dos funcionários que trabalham (TRABALHA_EM) no mesmo
-- projeto e na mesma quantidade de horas do “Fernando”
SELECT F.Pnome, TE.*
FROM FUNCIONARIO AS F
JOIN TRABALHA_EM AS TE ON F.Cpf = TE.Fcpf;

DECLARE @cpf_fernando CHAR(11);

SET @cpf_fernando = (SELECT F.cpf FROM FUNCIONARIO AS F 
						WHERE F.Pnome = 'Fernando');

SELECT F.Pnome, TE.*
FROM FUNCIONARIO AS F
JOIN TRABALHA_EM AS TE ON F.Cpf = TE.Fcpf
WHERE TE.Pnr IN (SELECT Pnr FROM TRABALHA_EM WHERE Fcpf = @cpf_fernando)
AND TE.Horas IN (SELECT horas FROM TRABALHA_EM WHERE Fcpf = @cpf_fernando)
AND NOT TE.Fcpf = @cpf_fernando;


