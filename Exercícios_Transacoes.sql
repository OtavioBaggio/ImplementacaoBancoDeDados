/*
-- Exerc�cio 1:
Autocommit � Transa��o Expl�cita Tarefa: Insira dois departamentos: um em modo autocommit e 
outro dentro de uma transa��o expl�cita. Em seguida, desfa�a o segundo (Rollback) e confirme
o primeiro. Entreg�vel: Demonstre, por consulta, qual linha permaneceu e explique por qu�. */

insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Marketing', 15);

BEGIN TRANSACTION;
insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Departamento maluquinho', 23);

ROLLBACK;

SELECT * FROM DEPARTAMENTO
WHERE Dnumero IN (15, 23);  -- Apenas o departamento 15, do marketing aparece por causa do ROLLBACK


/*
-- Exerc�cio 2:
SAVEPOINT e ROLLBACK Parcial Tarefa: Dentro de uma �nica transa��o, insira dois departamentos. 
Crie um SAVEPOINT ap�s o primeiro insert e fa�a ROLLBACK para o savepoint (mantendo o primeiro e desfazendo o segundo). 
Entreg�vel: Evidencie que apenas o primeiro persiste ap�s COMMIT. */

BEGIN TRANSACTION
insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Confeitaria', 17);

SAVE TRANSACTION dpCheckpoint;

insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Assassinos do chefe', 66)

ROLLBACK TRANSACTION dpCheckpoint;

commit;

SELECT * FROM DEPARTAMENTO WHERE Dnumero IN (17, 66);  -- Apenas o primeiro persiste


/*
-- Exerc�cio 3:
UPDATE com Confer�ncia e Decis�o Tarefa: Inicie transa��o, atualize o endere�o de um funcion�rio espec�fico, 
conferir a altera��o e ent�o decidir entre COMMIT ou ROLLBACK com base na confer�ncia. Entreg�vel: Registre a decis�o 
e o estado final do registro. */

select f.Pnome as Nome, f.Unome as Sobrenome, f.Endereco
from FUNCIONARIO as f
where cpf = '98765432300';

BEGIN TRANSACTION 
update FUNCIONARIO
set Endereco = 'Rua dos alfedeiros, 934'
where cpf = '98765432300';

select f.Pnome as Nome, f.Unome as Sobrenome, f.Endereco
from FUNCIONARIO as f
where cpf = '98765432300';

COMMIT;  -- DEU CERTO