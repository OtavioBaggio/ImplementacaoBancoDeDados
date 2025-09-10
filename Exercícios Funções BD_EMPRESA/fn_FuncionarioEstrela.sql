USE EMPRESA;

/*12. Crie uma função fn_FuncionarioEstrela que receba o CPF de um funcionário e
retorne:
	a. Seu nome completo
	b. Quantos dependentes possui
	c. Quantos projetos participa
	d. Se ganha mais que seu supervisor	*/

CREATE FUNCTION fn_FuncionarioEstrela(@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT 
        (F.Pnome + ' ' + ISNULL(F.Minicial,'') + ' ' + F.Unome) AS NomeCompleto,
        -- Quantos dependentes
        (SELECT COUNT(*) 
         FROM DEPENDENTE D 
         WHERE D.Fcpf = F.Cpf) AS QtdDependentes,

        -- Quantos projetos
        (SELECT COUNT(*) 
         FROM TRABALHA_EM T 
         WHERE T.Fcpf = F.Cpf) AS QtdProjetos,

        -- Se ganha mais que supervisor
        CASE 
            WHEN F.Cpf_supervisor IS NOT NULL AND F.Salario > 
                (SELECT S.Salario FROM FUNCIONARIO S WHERE S.Cpf = F.Cpf_supervisor)
            THEN 1 ELSE 0 
        END AS GanhaMaisQueSupervisor,

        -- Lista de dependentes (concatenada)
        ISNULL((
            SELECT STRING_AGG(D.Nome_dependente + ' (' + D.Parentesco + ')', ', ')
            FROM DEPENDENTE D
            WHERE D.Fcpf = F.Cpf
        ), 'Nenhum dependente') AS ListaDependentes
    FROM FUNCIONARIO F
    WHERE F.Cpf = @Cpf
);

SELECT * FROM dbo.fn_FuncionarioEstrela('12345678966'); -- João Silva
