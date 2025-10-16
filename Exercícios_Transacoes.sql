/*
-- Exercício 1:
Autocommit × Transação Explícita Tarefa: Insira dois departamentos: um em modo autocommit e 
outro dentro de uma transação explícita. Em seguida, desfaça o segundo (Rollback) e confirme
o primeiro. Entregável: Demonstre, por consulta, qual linha permaneceu e explique por quê. */

insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Marketing', 15);

BEGIN TRANSACTION;
insert into DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Departamento maluquinho', 23);

ROLLBACK;

SELECT * FROM DEPARTAMENTO
WHERE Dnumero IN (15, 23);  -- Apenas o departamento 15, do marketing aparece por causa do ROLLBACK


/*
-- Exercício 2:
SAVEPOINT e ROLLBACK Parcial Tarefa: Dentro de uma única transação, insira dois departamentos. 
Crie um SAVEPOINT após o primeiro insert e faça ROLLBACK para o savepoint (mantendo o primeiro e desfazendo o segundo). 
Entregável: Evidencie que apenas o primeiro persiste após COMMIT. */

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
-- Exercício 3:
UPDATE com Conferência e Decisão Tarefa: Inicie transação, atualize o endereço de um funcionário específico, 
conferir a alteração e então decidir entre COMMIT ou ROLLBACK com base na conferência. Entregável: Registre a decisão 
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