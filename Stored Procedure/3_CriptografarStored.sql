USE EMPRESA;
-- Exemplo III:
--	Criptografar Stored Procedure:

CREATE PROCEDURE usp_Funcionario
WITH ENCRYPTION
AS
 SELECT * FROM FUNCIONARIO;

 EXEC usp_Funcionario;

 EXEC sp_helptext usp_Funcionario;
