/*				TRANSAÇÕES
			
	Uma transação em banco de dados é um conjunto de operações que são tratadas como uma única unidade de trabalho. 
	Essas operações podem incluir inserções, atualizações, exclusões ou consultas, e uma transação deve ser completamente concluída ou 
	completamente revertida para garantir que o banco de dados permaneça em um estado consistente.


	Principais Comandos Relacionados a Transações:
		BEGIN TRANSACTION: Inicia uma nova transação.
		COMMIT TRANSACTION: Confirma a transação, aplicando permanentemente todas as operações feitas no banco de dados.
		ROLLBACK TRANSACTION: Desfaz todas as operações realizadas desde o início da transação.
		SAVEPOINT: Define um ponto dentro de uma transação para permitir um rollback parcial, até esse ponto.
*/

BEGIN TRANSACTION;

-- Tentativa de inserir um novo funcionário
INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('João', 'A', 'Silva', '12345678901', '1990-01-01', 'Rua das Flores, 123', 'M', 5000, NULL, 1);

-- Tentativa de inserir um novo departamento
INSERT INTO DEPARTAMENTO (Dnumero, Dnome, Cpf_gerente, Data_inicio_gerente)
VALUES (3, 'Recursos Humanos', '12345678901', '2023-09-29');

-- Verifica se houve erro em alguma das inserções
IF @@ERROR <> 0 
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Erro detectado. Transação revertida.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Transação concluída com sucesso.';
END