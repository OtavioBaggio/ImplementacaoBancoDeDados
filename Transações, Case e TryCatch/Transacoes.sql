/*				TRANSA��ES
			
	Uma transa��o em banco de dados � um conjunto de opera��es que s�o tratadas como uma �nica unidade de trabalho. 
	Essas opera��es podem incluir inser��es, atualiza��es, exclus�es ou consultas, e uma transa��o deve ser completamente conclu�da ou 
	completamente revertida para garantir que o banco de dados permane�a em um estado consistente.


	Principais Comandos Relacionados a Transa��es:
		BEGIN TRANSACTION: Inicia uma nova transa��o.
		COMMIT TRANSACTION: Confirma a transa��o, aplicando permanentemente todas as opera��es feitas no banco de dados.
		ROLLBACK TRANSACTION: Desfaz todas as opera��es realizadas desde o in�cio da transa��o.
		SAVEPOINT: Define um ponto dentro de uma transa��o para permitir um rollback parcial, at� esse ponto.
*/

BEGIN TRANSACTION;

-- Tentativa de inserir um novo funcion�rio
INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('Jo�o', 'A', 'Silva', '12345678901', '1990-01-01', 'Rua das Flores, 123', 'M', 5000, NULL, 1);

-- Tentativa de inserir um novo departamento
INSERT INTO DEPARTAMENTO (Dnumero, Dnome, Cpf_gerente, Data_inicio_gerente)
VALUES (3, 'Recursos Humanos', '12345678901', '2023-09-29');

-- Verifica se houve erro em alguma das inser��es
IF @@ERROR <> 0 
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Erro detectado. Transa��o revertida.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Transa��o conclu�da com sucesso.';
END