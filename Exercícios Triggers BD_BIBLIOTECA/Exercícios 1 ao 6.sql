use BIBLIOTECA;

select * from Livro;

-- 1. Crie um trigger que impeça a inserção de livros com o mesmo Titulo na tabela Livro
CREATE or ALTER TRIGGER trg_ImpedirTitulosDuplicadoss
ON Livro
INSTEAD OF INSERT
AS
BEGIN
    -- Verifica se algum título já existe na tabela
    IF EXISTS (
        SELECT 1 
        FROM Livro L
        INNER JOIN inserted I ON L.titulo = I.titulo
    )
    BEGIN
        RAISERROR('Erro: Já existe um livro com este título na biblioteca.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    -- Se não houver duplicatas, insere normalmente
    INSERT INTO Livro (isbn, titulo, ano, fk_editora, fk_categoria)
    SELECT isbn, titulo, ano, fk_editora, fk_categoria
    FROM inserted;
END;
GO

-- Teste 1: Tentar inserir livro com título duplicado (deve falhar)
INSERT INTO Livro VALUES('1234567890','Harry Potter e A Pedra Filosofal','2023',1,1);


-- 2. Crie um trigger que atualize automaticamente o ano de publicação na tabela Livro
-- para o ano atual quando um novo livro é inserido.
CREATE OR ALTER TRIGGER trg_AtualizarAnoLivro
ON Livro
INSTEAD OF INSERT
AS
BEGIN
    -- Insere o livro substituindo o ano pelo ano atual
    INSERT INTO Livro (isbn, titulo, ano, fk_editora, fk_categoria)
    SELECT isbn, titulo, YEAR(GETDATE()), fk_editora, fk_categoria
    FROM inserted;
END;
GO

-- Teste 2: Inserir novo livro (ano será automaticamente ajustado para 2025)
INSERT INTO Livro VALUES('1234567890','Novo Livro Teste','2000',1,1);
SELECT * FROM Livro WHERE isbn = '1234567890';


-- 3. Crie um trigger que exclua automaticamente registros da tabela LivroAutor quando o
-- livro correspondente é excluído da tabela Livro
CREATE or alter TRIGGER trg_ExcluirLivroAutor
ON Livro
AFTER DELETE
AS
BEGIN
    -- Remove todos os registros da tabela LivroAutor relacionados ao livro excluído
    DELETE FROM LivroAutor
    WHERE fk_livro IN (SELECT isbn FROM deleted);
    
    PRINT 'Registros relacionados removidos da tabela LivroAutor.';
END;
GO

-- Teste: Excluir um livro e verificar se LivroAutor foi atualizado
DELETE FROM Livro WHERE isbn = '9788577345670';
SELECT * FROM LivroAutor;


-- 4. Crie um trigger que atualize o número total de livros em uma categoria específica na
-- tabela Categoria sempre que um novo livro é inserido nessa categoria.

IF NOT EXISTS (SELECT 1 FROM sys.columns 
               WHERE object_id = OBJECT_ID('Categoria') 
               AND name = 'total_livros')
BEGIN
    ALTER TABLE Categoria ADD total_livros INT DEFAULT 0;
END;
GO

-- Inicializa os valores existentes
UPDATE Categoria
SET total_livros = (
    SELECT COUNT(*) 
    FROM Livro 
    WHERE Livro.fk_categoria = Categoria.id
);
GO

-- Trigger para INSERT
CREATE TRIGGER trg_AtualizarTotalLivrosInsert
ON Livro
AFTER INSERT
AS
BEGIN
    UPDATE Categoria
    SET total_livros = total_livros + 1
    WHERE id IN (SELECT DISTINCT fk_categoria FROM inserted);
END;
GO

-- Trigger para DELETE
CREATE TRIGGER trg_AtualizarTotalLivrosDelete
ON Livro
AFTER DELETE
AS
BEGIN
    UPDATE Categoria
    SET total_livros = total_livros - 1
    WHERE id IN (SELECT DISTINCT fk_categoria FROM deleted);
END;
GO

-- Trigger para UPDATE (caso a categoria do livro seja alterada)
CREATE or alter TRIGGER trg_AtualizarTotalLivrosUpdate
ON Livro
AFTER UPDATE
AS
BEGIN
    IF UPDATE(fk_categoria)
    BEGIN
        -- Decrementa da categoria antiga
        UPDATE Categoria
        SET total_livros = total_livros - 1
        WHERE id IN (SELECT DISTINCT fk_categoria FROM deleted);
        
        -- Incrementa na categoria nova
        UPDATE Categoria
        SET total_livros = total_livros + 1
        WHERE id IN (SELECT DISTINCT fk_categoria FROM inserted);
    END
END;
GO

-- Teste: Verificar total de livros por categoria
SELECT id, tipo_categoria, total_livros FROM Categoria;


-- 5. Crie um trigger que restrinja a exclusão de categorias na tabela Categoria se houver
-- livros associados a essa categoria.
CREATE or alter TRIGGER trg_ImpedirExclusaoCategoria
ON Categoria
INSTEAD OF DELETE
AS
BEGIN
    -- Verifica se existem livros associados à categoria
    IF EXISTS (
        SELECT 1 
        FROM Livro L
        INNER JOIN deleted D ON L.fk_categoria = D.id
    )
    BEGIN
        RAISERROR('Erro: Não é possível excluir esta categoria pois existem livros associados a ela.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    -- Se não houver livros associados, permite a exclusão
    DELETE FROM Categoria
    WHERE id IN (SELECT id FROM deleted);
    
    PRINT 'Categoria excluída com sucesso.';
END;
GO

-- Teste: Tentar excluir categoria com livros (deve falhar)
DELETE FROM Categoria WHERE id = 1;


-- 6. Crie um trigger que registre em uma tabela de auditoria sempre que um livro for atualizado na tabela Livro.
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AuditoriaLivro')
BEGIN
    CREATE TABLE AuditoriaLivro (
        id INT NOT NULL IDENTITY PRIMARY KEY,
        isbn VARCHAR(50) NOT NULL,
        titulo_antigo VARCHAR(100),
        titulo_novo VARCHAR(100),
        ano_antigo INT,
        ano_novo INT,
        fk_editora_antigo INT,
        fk_editora_novo INT,
        fk_categoria_antigo INT,
        fk_categoria_novo INT,
        data_alteracao DATETIME DEFAULT GETDATE(),
        usuario VARCHAR(100) DEFAULT SYSTEM_USER
    );
END;
GO

-- Trigger de auditoria
CREATE or alter TRIGGER trg_AuditoriaLivro
ON Livro
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditoriaLivro (
        isbn, 
        titulo_antigo, 
        titulo_novo,
        ano_antigo,
        ano_novo,
        fk_editora_antigo,
        fk_editora_novo,
        fk_categoria_antigo,
        fk_categoria_novo
    )
    SELECT 
        d.isbn,
        d.titulo,
        i.titulo,
        d.ano,
        i.ano,
        d.fk_editora,
        i.fk_editora,
        d.fk_categoria,
        i.fk_categoria
    FROM deleted d
    INNER JOIN inserted i ON d.isbn = i.isbn;
    
    PRINT 'Alteração registrada na tabela de auditoria.';
END;
GO

-- Teste: Atualizar um livro e verificar auditoria
UPDATE Livro SET titulo = 'Harry Potter - Edição Revisada' WHERE isbn = '8532511015';
SELECT * FROM AuditoriaLivro;
