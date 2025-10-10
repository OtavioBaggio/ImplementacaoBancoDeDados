BEGIN TRAN;

DECLARE @registoAfetado INT = 0;

UPDATE FUNCIONARIO
SET Salario = 30000
WHERE Pnome = 'Carlos' AND Unome = 'Silva'
set @registoAfetado = @@ROWCOUNT + @registoAfetado;
IF @registoAfetado <> 1
BEGIN
	ROLLBACK TRAN;
	PRINT 'Alteração NÃO realizada'
END;
ELSE
BEGIN
	COMMIT TRANSACTION;
	PRINT 'Alteração realizada com sucesso!'
END

SELECT * FROM FUNCIONARIO order by Pnome;