--				 REVIS�O PROVA I
USE EMPRESA;

select * 
from FUNCIONARIO as f
where f.Pnome LIKE '_A%';


select f.Pnome as 'Funcionario', f.Salario
from FUNCIONARIO as f
order by f.Salario desc;

--	CONSULTAS B�SICAS

-- I) Liste o nome e sal�rio de todos os funcion�rios.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Salario
from FUNCIONARIO as f;


-- II) Mostre os nomes dos funcion�rios do sexo F.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Sexo
from FUNCIONARIO as f
where f.Sexo like 'F';


-- III) Exiba os nomes dos departamentos em ordem alfab�tica.
select d.Dnome as 'Nome do departamento:'
from DEPARTAMENTO as d
order by d.Dnome;


--	FILTROS E OPERADORES L�GICOS

-- IV) Liste os funcion�rios com sal�rio maior que 30.000 e que sejam do departamento 5.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', f.Salario
from FUNCIONARIO as f
left join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
where f.Salario > 30000 and d.Dnumero = 5; 


-- V) Mostre os funcion�rios que moram em S�o Paulo ou Piracicaba.
select f.Pnome as 'nome', f.Unome as 'Sobrenome', f.Endereco as 'Cidade'
from FUNCIONARIO as f
where f.Endereco like '%S�o Paulo%' or f.Endereco like '%Piracicaba%';


-- VI) Exiba os funcion�rios cujo sobrenome come�a com 'S'.
select f.Pnome as 'Funcion�rio', f.Unome as 'Sobrenome com S'
from FUNCIONARIO as f
where f.Unome like 'S%'
order by f.Unome


--	FUN��ES AGREGADAS - SUM(), AVG(), COUNT(), MAX() e MIN()

-- VII) Qual � o maior e o menor sal�rio da empresa?
select MAX(f.Salario) as 'Maior sal�rio', MIN(f.Salario) as 'Menor sal�rio'
from FUNCIONARIO as f


	-- Mas se quiser saber o nome e o cpf de quem recebe os menores e maiores sal�rios:
		-- Maior sal�rio e funcion�rio que recebe
		SELECT TOP 1 Cpf , Pnome as 'Nome', Unome as 'Sobrenome', Salario as 'Maior sal�rio'
		FROM FUNCIONARIO
		ORDER BY Salario DESC;
		-- Menor sal�rio e funcion�rio que recebe
		SELECT TOP 1 Cpf , Pnome as 'Nome', Unome as 'Sobrenome', Salario as 'Menor Sal�rio'
		FROM FUNCIONARIO
		ORDER BY Salario ASC;


-- VIII) Calcule a m�dia salarial por departamento.
select d.Dnome as 'Departamento' , AVG(f.Salario) as 'M�dia salarial' 
from FUNCIONARIO as f
left join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome


-- IX) Conte quantos funcion�rios trabalham em cada departamento.
select d.Dnome as 'Departamento' , COUNT(f.Cpf) as 'Funcion�rios'
from FUNCIONARIO as f
right join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome



--	GROUP BY e HAVING

-- X) Liste o n�mero de funcion�rios por departamento, somente os departamentos com mais de 2 funcion�rios.
select d.Dnome as 'Departamento', COUNT(f.Cpf) as 'Departamentos com mais de dois funcion�rios'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome
HAVING COUNT(f.Cpf) > 2;


-- XI) Mostre a m�dia de sal�rio dos departamentos, apenas os que possuem m�dia maior que 40.000.
select d.Dnome as 'Departamento', AVG(f.Salario) as 'M�dia salarial maior que 40.000'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero
group by d.Dnome
HAVING AVG(f.Salario) > 40000


--	JOINs

-- XII)Exiba o nome do funcion�rio e o nome do seu departamento.
select f.Pnome as 'Nome', f.Unome as 'Sobrenome', d.Dnome as 'Departamento'
from FUNCIONARIO as f
inner join DEPARTAMENTO as d
on f.Dnr = d.Dnumero

-- XIII)Liste os projetos e os nomes dos departamentos respons�veis.
select p.Projnome as 'Projeto', d.Dnome as 'Departamento respons�vel'
from PROJETO as p
inner join DEPARTAMENTO as d
on p.Dnum = d.Dnumero


-- XIV)Mostre o nome dos funcion�rios e os projetos em que trabalham, incluindo o n�mero de horas.
SELECT f.Pnome AS Nome, f.Unome AS Sobrenome, p.Projnome AS Projeto, t.Horas AS Horas
FROM FUNCIONARIO AS f
INNER JOIN TRABALHA_EM AS t
    ON f.Cpf = t.Fcpf
INNER JOIN PROJETO AS p
    ON t.Pnr = p.Projnumero;


-- XV)Liste os dependentes de cada funcion�rio (mostrar nome do funcion�rio e nome do dependente).
select f.Pnome AS Nome, f.Unome AS Sobrenome, d.Nome_dependente as Dependente, d.Parentesco
from DEPENDENTE as d
inner join FUNCIONARIO as f
on d.Fcpf = f.Cpf


--	ORDER BY

-- XVI) Mostre os funcion�rios ordenados pelo sal�rio em ordem decrescente.
select CONCAT(f.Pnome, + ' ' + f.Unome) as Nome, f.Salario
from FUNCIONARIO as f
order by f.Salario desc;


-- XVII) Liste os projetos ordenados pelo local (Projlocal).
select p.Projnome as Projeto, p.Projlocal as Local
from PROJETO as p
order by p.Projlocal



--	Vari�veis, IF/ELSE e WHILE

-- XVIII) Declare uma vari�vel @salarioLimite = 40000. Liste os funcion�rios que ganham acima desse valor.
declare @salarioLimite MONEY
		set @salarioLimite = 40000

select CONCAT(f.Pnome, + ' ' + f.Unome) as Nome, f.Salario
from FUNCIONARIO as f
where f.Salario > @salarioLimite


-- XIX) Crie um bloco IF/ELSE que mostre �Sal�rios altos� se a m�dia dos sal�rios for maior que 35.000, caso contr�rio �Sal�rios baixos�.

-- vers�o com variavel:
declare @mediaSalario MONEY
		set @mediaSalario = 35000
select @mediaSalario = AVG(f.Salario)
from FUNCIONARIO as f
if @mediaSalario > 35000
	print 'Sal�rios altos'
else
	print 'Sal�rios baixos'

-- Ver�o SEM vari�vel:
IF
	(select AVG(f.Salario)
	from FUNCIONARIO as f) > 35000
	PRINT 'Sal�rios altos'
ELSE
	PRINT 'Sal�rios baixos'


-- XX) Usando WHILE, fa�a um loop de 1 a 5 imprimindo os valores.
declare @valor int
		set @valor = 1;

WHILE @valor <= 5
BEGIN
	PRINT 'valor: ' + CAST(@valor as VARCHAR)
	set @valor = @valor + 1
END;


--	FUN��ES

-- XXI) Crie uma fun��o que receba o CPF de um funcion�rio e retorne o sal�rio dele.
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


-- XXII) Crie uma fun��o que receba o n�mero de um departamento e retorne a quantidade de funcion�rios desse departamento.
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

-- XXIII) Crie uma procedure que mostre todos os funcion�rios de um departamento (o n�mero do departamento deve ser passado como par�metro).
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


-- XXIV) Crie uma procedure que aumente em 10% o sal�rio de todos os funcion�rios de um departamento espec�fico.
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



-- XXV) Crie uma procedure que liste todos os projetos de um funcion�rio, dado o CPF.
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