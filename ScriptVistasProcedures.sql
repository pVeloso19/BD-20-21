-- Queries

-- Agendar um teste
delimiter $$
CREATE PROCEDURE agendar_Teste(IN dataTeste DATETIME, IN matricula VARCHAR(45), IN  posto INT, IN cliente INT)
BEGIN 
	-- Declarar Variáveis
	DECLARE i INT;
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
    
    START TRANSACTION;
    
    -- ID Teste
	SET i = (SELECT count(*) FROM marcacao);
      
    INSERT 
		INTO marcacao (Id, Data_De_Realizacao, Matricula, Posto, Cliente)
        VALUES (i+1, dataTeste, matricula, posto, cliente);
	
        -- Verificação ocorrência de um erro
    IF ErroTransacao THEN
        BEGIN
			SELECT `Não foi possível registar teste` AS Mensagem_Retorno;
            ROLLBACK;
        END;
    ELSE
        BEGIN
			SELECT `Operação concluída com sucesso` AS Mensagem_Retorno;
            COMMIT;
        END;
    END IF;
END; $$    

-- Permitir desmarcar Testes
delimiter $$
CREATE PROCEDURE desmarcar_Teste(IN marcacao_x INT)
BEGIN
	-- Declaração de handler para tratamento de Erros    
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
    
     -- Inicio Transação
    START TRANSACTION;
    
    -- Desmarcar Teste
    DELETE FROM marcacao 
		   WHERE Id = marcacao_x;	
           
    -- Verificação ocorrência de um erro
    IF ErroTransacao THEN
		-- Desfazer operações realizadas
        BEGIN
			SELECT `Não foi possível desmarcar teste` AS Mensagem_Retorno;
            ROLLBACK;
        END;
    ELSE
		-- Confirmar as operações realizadas
        BEGIN
			SELECT `Operação concluída com sucesso` AS Mensagem_Retorno;
            COMMIT;
        END;
    END IF;
END;$$

-- Permitir remarcar Testes
delimiter $$
CREATE PROCEDURE remarcar_Teste(IN marcacao_x INT, IN dataTeste DATETIME, IN matricula VARCHAR(45),  IN posto INT, IN cliente INT)
BEGIN     
    -- Declaração de handler para tratamento de Erros
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
    
    START TRANSACTION;
    
    UPDATE marcacao
		SET Data_De_Realizacao = dataTeste,
			Matricula = matricula,
            Posto = posto,
            Cliente = cliente            
        WHERE Id = marcacao_x;
		
    -- Verificação ocorrência de um erro
    IF ErroTransacao THEN
        BEGIN
			SELECT `Não foi possível remarcar teste` AS Mensagem_Retorno;
            ROLLBACK;
        END;
    ELSE
        BEGIN
			SELECT `Operação concluída com sucesso` AS Mensagem_Retorno;
            COMMIT;
        END;
    END IF;
END; $$  

-- Permitir emitir resultados dos Testes
CREATE VIEW vista_Resultados_Testes AS
	SELECT Nome, Resultado 
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao;

-- Saber resultado de um determinado Teste e o dono do Teste
delimiter $$
CREATE PROCEDURE resultado_e_dono_Teste(IN teste_x INT)
BEGIN
	SELECT Nome, Resultado
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
        WHERE T.Id = teste_x;
END; $$
        
-- Saber o laboratório que analisou um Teste, bem como o Funcionário
delimiter $$
CREATE PROCEDURE lab_e_funcionario_Teste(IN teste_x INT)
BEGIN
	SELECT L.Nome AS nomeLaboratorio, F.Nome AS nomeFuncionario 
		FROM teste AS T 
			INNER JOIN funcionario AS F ON T.funcionario = F.Codigo_Funcionario
					 INNER JOIN laboratorio AS L ON F.laboratorio = L.Id
        WHERE T.Id = teste_x;             
END;$$

-- Saber Posto de Recolha de um Teste
delimiter $$
CREATE PROCEDURE posto_Teste(IN teste_x INT)
BEGIN
	SELECT Nome
		FROM teste AS T 
			INNER JOIN posto AS P ON T.posto = P.ID
        WHERE T.Id = teste_x;
END;$$

-- Identificar os dados da Pessoa a quem pertence o Teste
delimiter $$
CREATE PROCEDURE dadosPessoa_Teste(IN teste_x INT)
BEGIN
	SELECT Nome, Data_Nascimento, Genero, Localidade, Codigo_Postal, Rua 
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
        WHERE T.Id = teste_x;
END;$$

-- Listar todos os Testes realizados num determinado Laboratório 
delimiter $$
CREATE PROCEDURE testes_Laboratorio(IN laboratorio_x INT)
BEGIN
	SELECT T.Id AS IdTeste
		FROM teste AS T 
			INNER JOIN funcionario AS F ON T.funcionario = F.Codigo_Funcionario
				INNER JOIN laboratorio AS L On F.laboratorio = L.Id 	
        WHERE L.Id = laboratorio_x;
END;$$

-- Listar todos os Testes realizados por um Funcionário 
delimiter $$
CREATE PROCEDURE testes_Funcionario(IN funcionario_x INT)
BEGIN
	SELECT Id
		FROM teste AS T
        WHERE T.Funcionario = funcionario_x;
END;$$

-- Obter lista com as marcações para um Período
delimiter $$
CREATE PROCEDURE marcacoes_Periodo(IN inicio DATETIME, IN fim DATETIME)
BEGIN
	SELECT Id, Data_De_Realizacao, Matricula
		FROM marcacao 
        WHERE Data_De_Realizacao >= inicio
			AND Data_De_Realizacao <= fim;
END;$$

-- Listar as pessoas infetadas, identificando idade e género destas
CREATE VIEW pessoas_infetadas AS
	SELECT Nome, Genero
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
		WHERE T.Resultado = 'P';

-- Apresentar valores relativos ao número de pessoas infetadas num determinado género - Confirmada 
delimiter $$
CREATE PROCEDURE infetadas_genero(IN genero_x VARCHAR(1))
BEGIN
	SELECT C.Numero_Cartao_Cidadao AS IdCliente, Nome, Genero
		FROM teste AS T 
			INNER JOIN cliente AS C on T.cliente = C.Numero_Cartao_Cidadao
        WHERE C.Genero = genero_x AND Resultado = 'P';
END;$$

-- Apresentar valores relativos ao número de pessoas infetadas numa determinada faixa etária
delimiter $$
CREATE PROCEDURE infetadas_faixaEtaria(IN inicio INT, IN fim INT)
BEGIN	
	SELECT C.Numero_Cartao_Cidadao AS IdCliente, Nome, (YEAR(T.Data_Realizacao) - YEAR(C.Data_Nascimento)) AS Idade
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
        WHERE (YEAR(T.Data_Realizacao) - YEAR(C.Data_Nascimento) >= inicio)
		  AND (YEAR(T.Data_Realizacao) - YEAR(C.Data_Nascimento) <= fim)	
		  AND Resultado = 'P';
END;$$

-- Conhecer número total de testes realizados num posto
delimiter $$
CREATE PROCEDURE numero_testesGerais_Posto(IN posto_x INT)
BEGIN
	SELECT count(*) AS numeroTestesPosto
		FROM teste T
        WHERE T.Posto = posto_x;
END;$$

-- numero de testes realizados num posto para um determinado resultado
delimiter $$
CREATE PROCEDURE numero_testesResult_Posto(IN posto_x INT, IN result_x VARCHAR(1))
BEGIN
	SELECT count(*) AS numeroTestesPostoResultado
		FROM teste AS T
        WHERE T.Posto = posto_x AND T.Resultado = result_x;
END;$$

-- numero de testes analisados por um laboratorio 
delimiter $$
CREATE PROCEDURE numero_testesGerais_Laboratorio(IN laboratorio_x INT)
BEGIN
	SELECT count(*) AS numeroTestesLaboratorio
		FROM teste AS T 
			INNER JOIN funcionario AS F ON T.funcionario = F.Codigo_Funcionario
					INNER JOIN laboratorio AS L ON F.Laboratorio = L.Id
        WHERE L.Id = laboratorio_x;
END;$$

-- numero de testes com um determinado resultado analisados por um laboratorio 
delimiter $$
CREATE PROCEDURE numero_testesResult_Laboratorio(IN laboratorio_x INT, IN result_x VARCHAR(1))
BEGIN
	SELECT count(*) AS numeroTestesLaboratorioResult
		FROM teste AS T 
			INNER JOIN funcionario AS F ON T.funcionario = F.Codigo_Funcionario
					 INNER JOIN laboratorio AS L ON F.Laboratorio = L.Id
        WHERE L.Id = laboratorio_x AND Resultado = result_x;
END;$$

-- Identificar o tipo de teste a que um resultado se refere
delimiter $$
CREATE PROCEDURE tipoTeste_Result(IN result_x VARCHAR(1))
BEGIN
	SELECT tipo
		FROM teste
		WHERE resultado = result_x;
END;$$

-- Listar todas as pessoas que realizaram um tipo de teste
delimiter $$
CREATE PROCEDURE pessoas_tipoTeste(IN tipo_x VARCHAR(1))
BEGIN
	SELECT Numero_Cartao_Cidadao, Nome, Data_Nascimento, Genero, Localidade, Codigo_Postal, Rua 
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
		WHERE Tipo = tipo_x;
END;$$

-- Verificar quem realizou um certo tipo de teste num período
delimiter $$
CREATE PROCEDURE pessoas_tipoTeste_Periodo(IN tipo_x VARCHAR(1), IN inicio DATETIME, IN fim DATETIME)
BEGIN
	SELECT Numero_Cartao_Cidadao, Nome, Genero
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
		WHERE Tipo = tipo_x 
		  AND T.Data_Realizacao >= inicio 
          AND T.DATA_Realizacao <= fim;
END;$$

-- Listar todas as pessoas que realizaram um teste num dado posto, com resultado emitido
delimiter $$
CREATE PROCEDURE pessoas_testePosto(IN posto_x INT)
BEGIN
	SELECT Numero_Cartao_Cidadao, Nome, Genero
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
		WHERE Posto = posto_x;
END;$$

-- Identificar as pessoas que realizaram teste tendo em conta a sua localidade
delimiter $$
CREATE PROCEDURE pessoas_TesteLocalidade(IN localidade_x VARCHAR(45))
BEGIN
	SELECT Numero_Cartao_Cidadao, Nome, Genero
		FROM teste AS T 
			INNER JOIN cliente AS C ON T.cliente = C.Numero_Cartao_Cidadao
		WHERE C.Localidade = localidade_x;
END;$$

-- Todas as marcações efetuadas
CREATE VIEW marcaoes_Efetuadas AS
	SELECT *
		FROM marcacao;

-- Criar um teste na BD
delimiter $$
CREATE PROCEDURE insereTeste 
	(IN dataRealizacao DATETIME, IN tipo VARCHAR(1), IN resultado VARCHAR(1), IN obs VARCHAR(128), IN posto INT, IN clie INT, IN func INT)
BEGIN
	DECLARE id INT DEFAULT 0;
    
    SELECT count(*) INTO id FROM teste;
	
    INSERT INTO teste
		VALUES
        (id+1,dataRealizacao,tipo,now(),resultado,obs,posto,clie,func);
END $$