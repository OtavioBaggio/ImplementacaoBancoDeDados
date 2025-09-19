USE EMPRESA;

-- Exemplo VII:
--	Crie um procedure que insira um novo departamento com sua respectiva localidade

CREATE PROCEDURE usp_novoDepartamento
    @nomeDepartamento VARCHAR(100),
    @localidade VARCHAR(100)
AS
BEGIN
    -- Verifica se já existe departamento com esse nome
    IF EXISTS(
        SELECT 1
        FROM DEPARTAMENTO AS D
        WHERE D.Dnome = @nomeDepartamento
    )
    BEGIN
        PRINT 'Já existe um departamento com esse nome.'
        RETURN;
    END;

    DECLARE @novoNumero INT;

    -- Gera o próximo número de departamento
    SELECT @novoNumero = ISNULL(MAX(Dnumero), 0) + 1
    FROM DEPARTAMENTO;

    -- Insere o departamento (sem gerente definido ainda)
    INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
    VALUES (@nomeDepartamento, @novoNumero);

    -- Insere a localidade correspondente
    INSERT INTO LOCALIZACAO_DEP (Dnumero, Dlocal)
    VALUES (@novoNumero, @localidade);

    PRINT 'Departamento inserido com sucesso!';
END;

EXEC usp_novoDepartamento 'Marketing', 'São Paulo';

-- Conferindo:
select * 
from DEPARTAMENTO as D
FULL join LOCALIZACAO_DEP as L
on L.Dnumero = D.Dnumero;