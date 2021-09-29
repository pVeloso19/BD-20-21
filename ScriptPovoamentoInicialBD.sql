USE `clinicabd`;

INSERT INTO clinica
	(id,nome)
	VALUES 
    (1,'Synlabhealth II');

INSERT INTO posto
	(Id,Localidade,Codigo_Postal,Rua,Nome,email,Clinica)
    VALUES
    (1,'Almeirim','2080-141','Rua General Humberto Delgado','Posto de Análises Clínicas do Almeirim',NULL,1),
    (2,'Amadora','2700-458','Largo Doutor Dário Gandra Nunes','Posto de Análises Clínicas da Amadora','posto.venteira@synlab.pt',1),
    (3,'Barreiro','2830-003','Avenida do Bocage','Posto de Análises Clínicas do Barreiro',NULL,1),
    (4,'Braga','4710-102','Rua Ambrósio Santos','Posto de Análises Clínicas de Braga','posto.ambrosio-santos@synlab.pt',1),
    (5,'Coimbra','3020-479','Praceta Professor Robalo Cordeiro','Posto de Análises Clínicas de Coimbra','laboratorio.coimbra@synlab.pt',1),
    (6,'Covilhã','6200-506','Av.ª Infante D. Henrique','Posto de Análises Clínicas da Covilhã',NULL,1),
    (7,'Évora','7005-259','Praceta Horta do Bispo','Posto de Análises Clínicas de Évora','laboratorio.evora@synlab.pt',1);
    
INSERT INTO contactoposto
	(Telefone,Posto)
    VALUES
    ('243592604',1),
    ('914155759',2),
    ('910728308',3),
    ('253248805',4),
    ('227860743',4),
    ('935465241',4),
    ('239701512',5),
    ('275313383',6),
    ('266759590',7);
    
INSERT INTO laboratorio
	(Id,Nome,Tipo,Clinica)
    VALUES
    (1,'Hemobiolab','E',1),
    (2,'AVELAB','E',1),
    (3,'Hormofuncional','E',1),
    (4,'Cintramédica','E',1),
    (5,'Labocentro','I',1);

INSERT INTO funcionario
	(Codigo_Funcionario,Nome,Laboratorio)
    VALUES
    (1,'Adelino',1),
    (2,'Alfredo',1),
    (3,'Alexandre',1),
		(4,'Dinis',2),
        (5,'Duarte',2),
			(6,'Emílio',3),
            (7,'Gilberto',3),
            (8,'Gustavo',3),
				(9,'Inácio',4),
					(10,'Leopoldo',5),
                    (11,'Marcelo',5),
                    (12,'Mauro',5);

INSERT INTO cliente
	VALUES
    (1,'1972/12/14','Simão','M','Mafra','2640-465','Largo Coronel Brito Gorjão'),
    (2,'1967/12/27','Telmo','M','Lourinhã','2534-500','Praça José Máximo da Costa'),
    (3,'2000/11/06','Tiago','M','Almeirim','2080-142','Rua dos 3 Vales'),
    (4,'1953/06/23','Vasco','M','Amadora','2700-459','Largo Doutor Dário Gandra Nunes'),
    (5,'1953/12/09','Raul','M','Amadora','2700-457','Rua Real Fábrica do Vidro'),
    (6,'1933/12/12','Ana','F','Barreiro','2830-703','R. Prof. Francisco Gentil'),
    (7,'1982/12/17','Augusta','F','Braga','4710-112','Rua S. Tomás de Aquino'),
    (8,'1980/12/07','Carlota','F','Coimbra','3020-458','Largo Coronel Brito Gorjão'),
    (9,'1980/12/22','Cristina','F','Covilhã','6200-512','Rua Dr. António José de Almeida'),
    (10,'1962/12/03','Eva','F','Évora','7005-250','Rua Assis Leão');

INSERT INTO contactocliente
	(Telefone,Cliente)
    VALUES
    ('930551476',1),
    ('961773477',2),
    ('968895013',3),
    ('961773477',4),
    ('918851034',5),
    ('935465241',6),
    ('966148612',7),
    ('930568014',8),
    ('930570152',8),
    ('935465241',10);
    
INSERT INTO horario
	(Id,Inicio_Manha,Fim_Manha,Inicio_Tarde,Fim_Tarde,Dia)
    VALUES
    (1,NULL,NULL,'14:30:00','19:00:00','Segunda-Feira'),
    (2,NULL,NULL,'14:00:00','18:30:00','Terça-Feira'),
    (3,NULL,NULL,'14:00:00','18:30:00','Quarta-Feira'),
    (4,NULL,NULL,'14:00:00','18:30:00','Quinta-Feira'),
    (5,NULL,NULL,'14:00:00','18:30:00','Sexta-Feira'),
    (6,'09:30:00','12:30:00',NULL,NULL,'Sábado-Feira'),
    (7,NULL,NULL,NULL,NULL,'Domingo-Feira'),
    (8,'10:00:00','13:00:00',NULL,NULL,'Domingo-Feira');

INSERT INTO postooperahorario 
	(Posto,Horario)
    VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (1,7),
		(2,1),
        (2,2),
        (2,3),
        (2,4),
        (2,5),
        (2,6),
        (2,7),
			(3,1),
            (3,2),
            (3,3),
            (3,4),
            (3,5),
            (3,6),
            (3,8),	
				(4,1),
                (4,2),
                (4,3),
                (4,4),
                (4,5),
                (4,6),
                (4,8),
					(5,1),
                    (5,2),
                    (5,3),
                    (5,4),
                    (5,5),
                    (5,6),
                    (5,7),
						(6,1),
                        (6,2),
                        (6,3),
                        (6,4),
                        (6,5),
                        (6,6),
                        (6,7),
							(7,1),
                            (7,2),
                            (7,3),
                            (7,4),
                            (7,5),
                            (7,6),
                            (7,8);

INSERT INTO marcacao 
	VALUES
    (1,'2020-11-30 16:30:00','44-FH-82',4,1),
    (2,'2020-11-30 16:40:00','43-SL-56',4,2),
    (3,'2020-11-30 16:40:00','82-SP-75',1,3),
    (4,'2020-11-30 16:40:00','73-RI-57',2,4),
    (5,'2020-11-30 16:50:00','18-SI-97',2,5),
    (6,'2020-11-30 16:40:00','21-SK-81',3,6),
    (7,'2020-11-30 16:50:00','37-SL-19',4,7),
    (8,'2020-11-30 16:40:00',NULL,5,8),
    (9,'2020-11-30 16:40:00',NULL,6,9),
    (10,'2020-11-30 16:40:00',NULL,7,10);

INSERT INTO teste
	VALUES
	(1,'2020-11-30 16:34:00','C','2020-12-01 10:30:00','P',NULL,4,1,1),
    (2,'2020-11-30 16:47:00','C','2020-12-01 10:30:00','N',NULL,4,2,2),
    (3,'2020-11-30 16:44:00','C','2020-12-01 10:30:00','P',NULL,1,3,3),
    (4,'2020-11-30 16:41:00','C','2020-12-01 11:30:00','I','Baixa concentração de globolos vermelhos',2,4,1),
    (5,'2020-11-30 16:52:00','I','2020-12-01 10:30:00','P',NULL,2,5,4);
    

