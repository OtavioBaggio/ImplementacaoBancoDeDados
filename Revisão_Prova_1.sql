--				 REVISÃO PROVA I
USE EMPRESA;

select * 
from FUNCIONARIO as f
where f.Pnome LIKE '_A%';


select f.Pnome as 'Funcionario', f.Salario
from FUNCIONARIO as f
order by f.Salario desc;

--	CONSULTAS BÁSICAS

-- I) Liste o nome e salário de todos os funcionários.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Salario
from FUNCIONARIO as f;


-- II) Mostre os nomes dos funcionários do sexo F.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Sexo
from FUNCIONARIO as f
where f.Sexo like 'F';


-- III) Exiba os nomes dos departamentos em ordem alfabética.
select d.Dnome as 'Nome do departamento:'
from DEPARTAMENTO as d
order by d.Dnome;


--	FILTROS E OPERADORES LÓGICOS

-- IV) Liste os funcionários com salário maior que 30.000 e que sejam do departamento 5.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Salario
from FUNCIONARIO as f
left join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
where f.Salario > 30000 and d.Dnumero = 5; 


-- V) Mostre os funcionários que moram em São Paulo ou Piracicaba.
select f.Pnome as 'nome', f.Unome as 'Sobrenome', f.Endereco as 'Cidade'
from FUNCIONARIO as f
where f.Endereco like '%São Paulo%' or f.Endereco like '%Piracicaba%';


-- VI) Exiba os funcionários cujo sobrenome começa com 'S'.
select f.Pnome as 'Funcionário', f.Unome as 'Sobrenome com S'
from FUNCIONARIO as f
where f.Unome like 'S%'
order by f.Unome


--	FUNÇÕES AGREGADAS - SUM(), AVG(), COUNT(), MAX() e MIN()

-- VII) Qual é o maior e o menor salário da empresa?
select MAX(f.Salario) as 'Maior salário', MIN(f.Salario) as 'Menor salário'
from FUNCIONARIO as f


	-- Mas se quiser saber o nome e o cpf de quem recebe os menores e maiores salários:
		-- Maior salário e funcionário que recebe
		SELECT TOP 1 Cpf , Pnome as 'Nome', Unome as 'Sobrenome', Salario as 'Maior salário'
		FROM FUNCIONARIO
		ORDER BY Salario DESC;
		-- Menor salário e funcionário que recebe
		SELECT TOP 1 Cpf , Pnome as 'Nome', Unome as 'Sobrenome', Salario as 'Menor Salário'
		FROM FUNCIONARIO
		ORDER BY Salario ASC;


-- VIII) Calcule a média salarial por departamento.
select d.Dnome as 'Departamento' , AVG(f.Salario) as 'Média salarial' 
from FUNCIONARIO as f
left join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome


-- IX) Conte quantos funcionários trabalham em cada departamento.
select d.Dnome as 'Departamento' , COUNT(f.Cpf) as 'Funcionários'
from FUNCIONARIO as f
right join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome



--	GROUP BY e HAVING

-- X) Liste o número de funcionários por departamento, somente os departamentos com mais de 2 funcionários.
select d.Dnome as 'Departamento', COUNT(f.Cpf) as 'Departamentos com mais de dois funcionários'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome
HAVING COUNT(f.Cpf) > 2;


-- XI) Mostre a média de salário dos departamentos, apenas os que possuem média maior que 40.000.
select d.Dnome as 'Departamento', AVG(f.Salario) as 'Média salarial maior que 40.000'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome
HAVING AVG(f.Salario) > 40000


--	JOINs

-- XII)Exiba o nome do funcionário e o nome do seu departamento.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', d.Dnome as 'Departamento'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero

-- XIII)Liste os projetos e os nomes dos departamentos responsáveis.
select p.Projnome as 'Projeto', d.Dnome as 'Departamento responsável'
from PROJETO as p
inner join DEPARTAMENTO as d
on p.Dnum = d.Dnumero


-- XIV)Mostre o nome dos funcionários e os projetos em que trabalham, incluindo o número de horas.
SELECT f.Pnome AS Nome, f.Unome AS Sobrenome, p.Projnome AS Projeto, t.Horas AS Horas
FROM FUNCIONARIO AS f
INNER JOIN TRABALHA_EM AS t
    ON f.Cpf = t.Fcpf
INNER JOIN PROJETO AS p
    ON t.Pnr = p.Projnumero;


-- XV)Liste os dependentes de cada funcionário (mostrar nome do funcionário e nome do dependente).
select f.Pnome AS Nome, f.Unome AS Sobrenome, d.Nome_dependente as Dependente, d.Parentesco
from DEPENDENTE as d
inner join FUNCIONARIO as f
on d.Fcpf = f.Cpf


--	ORDER BY

-- XVI) Mostre os funcionários ordenados pelo salário em ordem decrescente.
select CONCAT(f.Pnome, + ' ' + f.Unome) as Nome, f.Salario
from FUNCIONARIO as f
order by f.Salario desc;


-- XVII) Liste os projetos ordenados pelo local (Projlocal).
select p.Projnome as Projeto, p.Projlocal as Local
from PROJETO as p
order by p.Projlocal



--	Variáveis, IF/ELSE e WHILE

-- XVIII) Declare uma variável @salarioLimite = 40000. Liste os funcionários que ganham acima desse valor.
declare @salarioLimite MONEY
		set @salarioLimite = 40000

select CONCAT(f.Pnome, + ' ' + f.Unome) as Nome, f.Salario
from FUNCIONARIO as f
where f.Salario > @salarioLimite


-- XIX) Crie um bloco IF/ELSE que mostre “Salários altos” se a média dos salários for maior que 35.000, caso contrário “Salários baixos”.

-- versão com variavel:
declare @mediaSalario MONEY
		set @mediaSalario = 35000
select @mediaSalario = AVG(f.Salario)
from FUNCIONARIO as f
if @mediaSalario > 35000
	print 'Salários altos'
else
	print 'Salários baixos'

-- Verão SEM variável:
IF
	(select AVG(f.Salario)
	from FUNCIONARIO as f) > 35000
	PRINT 'Salários altos'
ELSE
	PRINT 'Salários baixos'


-- XX) Usando WHILE, faça um loop de 1 a 5 imprimindo os valores.
declare @valor int
		set @valor = 1;

WHILE @valor <= 5
BEGIN
	PRINT 'valor: ' + CAST(@valor as VARCHAR)
	set @valor = @valor + 1
END;


--	FUNÇÕES

-- XXI) Crie uma função que receba o CPF de um funcionário e retorne o salário dele.
CREATE FUNCTION SalarioFuncionario(@cpf varchar(11))
RETURNS MONEY
AS 
BEGIN
	declare @salario MONEY

	select @salario = f.Salario
	from FUNCIONARIO as f
	where f.Cpf = @cpf

	RETURN @salario;
END;

select dbo.SalarioFuncionario('66688444476') AS Salario;


-- XXII) Crie uma função que receba o número de um departamento e retorne a quantidade de funcionários desse departamento.
CREATE FUNCTION FuncionarioPorDepartamento(@numeroDep int)
RETURNS INT
AS
BEGIN
	declare @qtdFunc INT

	select @qtdFunc = COUNT(*)
	from FUNCIONARIO as f
	where f.Dnr = @numeroDep

	RETURN @qtdFunc
END;

select dbo.FuncionarioPorDepartamento(5) as 'Quantidade de Funcionarios'



--	PROCEDURES

-- XXIII) Crie uma procedure que mostre todos os funcionários de um departamento (o número do departamento deve ser passado como parâmetro).
CREATE PROCEDURE usp_FuncionarioDepartamento(@nDep int)
AS 
BEGIN
	select f.Cpf, 
	CONCAT(f.Pnome, + ' ' + f.Unome) as Nome,
	f.Dnr as Numero_Departamento
	from FUNCIONARIO as f
	where f.Dnr = @nDep
END;

EXEC usp_FuncionarioDepartamento @nDep = 5;


-- XXIV) Crie uma procedure que aumente em 10% o salário de todos os funcionários de um departamento específico.
CREATE PROCEDURE usp_AumentarSalario(@nDep int)
AS
BEGIN
	UPDATE FUNCIONARIO
	set Salario = Salario * 1.10
	where Dnr = @nDep
END;

EXEC usp_AumentarSalario @nDep = 5

SELECT Pnome, Unome, Salario, Dnr
FROM FUNCIONARIO
WHERE Dnr = 5;



-- XXV) Crie uma procedure que liste todos os projetos de um funcionário, dado o CPF.
CREATE PROCEDURE usp_ListarProjetos(@cpf varchar(11))
AS
BEGIN
	select  t.Fcpf as CPF,
			p.Projnome as Projeto,
			p.Projnumero as Numero_projeto,
			t.Horas as Horas_trabalhadas
	from TRABALHA_EM as t
	inner join PROJETO as p
	on t.Pnr = p.Projnumero
	where t.Fcpf = @cpf
END;

EXEC usp_ListarProjetos @cpf = '12345678966';