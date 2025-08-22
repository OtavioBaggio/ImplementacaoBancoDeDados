select * from FUNCIONARIO;

-- Liste as diferentes faixas salariais dos funcion�rios.
select distinct salario
from Funcionario;

-- Recupere todas as informa��es do(s) funcionarios com primeiro nome �Jo�o�.
select *
from Funcionario as F
where F.Pnome = 'Jo�o';

-- Liste os funcion�rios do sexo masculino com sal�rio maior ou igual a 30.000,00R$
select *
from Funcionario as F
where F.Sexo = 'M'
	and F.salario >= 30000.00;

-- Liste os funcion�rios que moram em S�o Paulo ou em Curitiba.
select *
from Localizacao_DEP as L
where L.Dlocal in ('S�o Paulo', 'Curitiba');

-- Liste os funcion�rios que n�o moram em S�o Paulo
select *
from Funcionario as F
where F.Endereco <> '%S�o Paulo, SP';

-- Preciso cortar or�amento, liste os funcion�rios em ordem decrescente de sal�rio.
select *
from Funcionario as F
order by F.Salario DESC;

-- Encontre os Funcion�rio que n�o possuem supervisor (Cpf_supervisor)
select *
from Funcionario as F
where F.Cpf_supervisor IS NULL;

-- Recupere o(s) nome(s) do(s) funcion�rio(s) que possuem supervisor
select *
from Funcionario as F
where F.Cpf_supervisor IS NOT NULL;

-- Recupere o registro dos 3 funcion�rios que t�m o maior sal�rio.
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
	(SELECT COUNT(*) FROM FUNCIONARIO) AS 'Nr_Funcion�ios',
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

-- Recupere os registros dos funcion�rios que trabalham (TRABALHA_EM) no mesmo
-- projeto e na mesma quantidade de horas do �Fernando�
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


