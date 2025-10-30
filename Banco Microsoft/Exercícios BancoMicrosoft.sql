-- Criando o banco:
-- CREATE DATABASE BancoMicrosoft;
-- GO

select * from Employees;
 

-- 1) Crie uma visão que liste todos os funcionários que não são chefes:
CREATE or ALTER VIEW vw_FuncionariosNaoChefes
AS
select e.*
from Employees as e
where e.EmployeeID NOT IN(
	select distinct e.ReportsTo
	from Employees
	where ReportsTo IS NOT NULL
);

select * from vw_FuncionariosNaoChefes;  -- Só o Funcionário com o ID 2 era chefe


-- 2) Faça uma visão que liste a quantidade de vendas que cada produto (o quanto cada produto foi vendido)
CREATE or ALTER VIEW vw_QuantidadeVendas
AS
select p.ProductID, p.ProductName, SUM(od.Quantity) as 'Total de vendas'
from Products p
LEFT JOIN [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName

select * from vw_QuantidadeVendas;



-- 3) Faça uma visão que liste os territórios e quantos vendedores estão vinculados a ele
CREATE or ALTER VIEW vw_VendedoresPorTerritorio
AS
select t.TerritoryID, t.TerritoryDescription, COUNT(et.EmployeeID) as 'Quantidade de vendedores neste território'
from Territories as t
LEFT JOIN EmployeeTerritories as et
on t.TerritoryID = et.TerritoryID
group by t.TerritoryID, t.TerritoryDescription;

select * from vw_VendedoresPorTerritorio;


-- 4) Faça uma visão que retorne o nome do cliente da venda de maior valor:
CREATE or ALTER VIEW vw_ClienteBaleia  -- baleia se refere a cliente que gasta demais
AS
select TOP 1 c.CustomerID as 'Código do cliente', c.ContactName as Cliente, c.CompanyName as Companhia,
			o.OrderID as 'Código do pedido', 
			SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) as 'Valor da maior Venda'
from Customers as c
INNER JOIN orders as o
on c.CustomerID = o.CustomerID
INNER JOIN [Order Details] as od
on o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.ContactName, c.CompanyName, o.OrderID
ORDER BY 'Valor da maior Venda' DESC;

select * from vw_ClienteBaleia


-- 5) Faça uma visão que liste os vendedores ordenados pela lucratividade.
CREATE or ALTER VIEW vw_VendedoresLucrativos
AS
select e.EmployeeID, e.FirstName + ' ' + e.LastName as Nome_vendedor, e.Title as Cargo,
	--  calcula o valor total de vendas considerando quantidade, preço e desconto:
		SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS Lucratividade
from Employees as e
inner JOIN Orders as o
on e.EmployeeID = o.EmployeeID
inner JOIN [Order Details] as od
on o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Title

SELECT * FROM vw_VendedoresLucrativos ORDER BY Lucratividade DESC;


-- 6) Faça uma visão que retorne os produtos, seu fornecedor, sua categoria, seu preço e a 
--    informação de ele estar descontinuado ou não, para aqueles que possuem estoque
CREATE or ALTER VIEW vw_InfoProdutos
AS
select p.ProductID, p.ProductName as Produto, s.CompanyName as Forncedor, c.CategoryName as Categoria, p.UnitPrice,
		CASE
			WHEN p.Discontinued = 1 THEN 'Produto DESCONTINUADO!'
			ELSE 'Ativo'
		END AS StatusDescontinuacao,
		p.UnitsInStock as 'Quantidade em estoque'
from Products as p
INNER JOIN Suppliers as s
on p.SupplierID = s.SupplierID
INNER JOIN Categories as c
on p.CategoryID = c.CategoryID
WHERE p.UnitsInStock > 0;

select * from vw_InfoProdutos;





