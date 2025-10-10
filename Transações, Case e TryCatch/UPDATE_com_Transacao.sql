BEGIN TRAN;

DECLARE @registoAfetado INT = 0;

UPDATE FUNCIONARIO
SET Salario = 30000
WHERE Pnome = 'Carlos' AND Unome = 'Silva'
set @registoAfetado = @@ROWCOUNT + @registoAfetado;
IF @registoAfetado <> 1
BEGIN
	ROLLBACK TRAN;
	PRINT 'Altera��o N�O realizada'
END;
ELSE
BEGIN
	COMMIT TRANSACTION;
	PRINT 'Altera��o realizada com sucesso!'
END

SELECT * FROM FUNCIONARIO order by Pnome;