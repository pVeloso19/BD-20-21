DELIMITER $$
	CREATE TRIGGER Genero_OK BEFORE INSERT ON cliente
    FOR EACH ROW 
    BEGIN
		IF(new.Genero <> 'F' AND new.Genero <> 'M')
        THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Genero escolhido é invalido, use F ou M';
		END IF;
	END $$
DELIMITER $$

DELIMITER $$
	CREATE TRIGGER Nascimento_OK BEFORE INSERT ON cliente
    FOR EACH ROW 
    BEGIN
		IF(new.Data_Nascimento > DATE(now()))
        THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de nascimento invalida.';
		END IF;
	END $$
DELIMITER $$

DELIMITER $$
	CREATE TRIGGER DataMarcacao_Ok BEFORE INSERT ON marcacao
    FOR EACH ROW 
    BEGIN
		DECLARE soma INT;
		SELECT	count(*) INTO soma 
			FROM marcacao
			WHERE marcacao.Data_De_Realizacao = new.Data_De_Realizacao AND marcacao.Posto = new.Posto;
		
        IF(soma > 0)
        THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de marcação Inválida.';
		END IF;
	END $$
DELIMITER $$

-- Teste Trigger's

INSERT INTO marcacao 
	VALUES
    (23,'2020-11-30 16:30:00','44-FH-82',4,1);

INSERT INTO cliente
	VALUES
    (11,'2021/12/14','Simão','M','Mafra','2640-465','Largo Coronel Brito Gorjão');
    
INSERT INTO cliente
	VALUES
    (11,'2000/12/14','Simão','T','Mafra','2640-465','Largo Coronel Brito Gorjão');
    

