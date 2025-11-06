select * from TRABALHA_EM;
select * from FUNCIONARIO;

insert into FUNCIONARIO(Pnome, Unome, Cpf)
VALUES ('Marcos', 'Baggio', '586632589');

update FUNCIONARIO
set Minicial = 'M' 
WHERE Cpf = '586632589';

DELETE FROM FUNCIONARIO 
WHERE Cpf = '586632589';