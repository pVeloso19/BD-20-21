-- Agendar um novo teste
select * from marcacao;
CALL agendar_Teste('2021-01-28 16:15:00','AB-78-NA',1,3);

-- DESMARCAR TESTE 11
select * from marcacao;
CALL desmarcar_Teste(11);

-- REMARCAR TESTE 6
select * from marcacao;
CALL remarcar_Teste(6, '2021-01-29 16:20:00','21-SK-81',3,6);

-- Ver os resultados de todos os testes emitidos (NOME|RES)
SELECT * FROM vista_Resultados_Testes;

-- Saber resultado e o dono do teste 1
CALL resultado_e_dono_Teste(1);

-- saber o laboratório e o funcionario que analisou o Teste 1
CALL lab_e_funcionario_Teste(1);

-- saber o posto em que se realizou o teste 1
CALL posto_Teste(1);

-- Identificar os dados da Pessoa a quem pertence o Teste 1
CALL dadosPessoa_Teste(1);

-- Listar todos os Testes realizados no Laboratório 1
CALL testes_Laboratorio(1);

-- Listar todos os Testes realizados pelo Funcionário 1
CALL testes_Funcionario(1);

-- Obter as marcações entre dia 27 e 29
CALL marcacoes_Periodo('2021-01-27 00:00:00', '2021-01-29 00:00:00');

-- Listar as pessoas infetadas (Nome|GENERO)
SELECT * FROM pessoas_infetadas;

-- Apresentar valores relativos ao número de pessoas infetadas (Genero Masculino)
CALL infetadas_genero('M');

-- Apresentar valores relativos ao número de pessoas infetadas entre os 20 e 65 anos
CALL infetadas_faixaEtaria(20, 65);

-- número total de testes realizados no posto 4
CALL numero_testesGerais_Posto(4);

-- numero de testes realizados no posto 2 que deram positivo
CALL numero_testesResult_Posto(2, 'P');

-- numero de testes analisados pelo laboratorio 1
CALL numero_testesGerais_Laboratorio(1);

-- numero de testes positivos analisados pelo laboratorio 1
CALL numero_testesResult_Laboratorio(1,'P');

-- todas as pessoas que realizaram um teste a covid
CALL pessoas_tipoTeste('C');

-- todas as pessoas que realizaram um teste de imunidade
CALL  pessoas_tipoTeste('I');

-- Verificar quem realizou um teste à covid entre 2020-11-30 16:30:00 e 2020-11-30 17:00:00
CALL pessoas_tipoTeste_Periodo('C','2020-11-30 16:30:00', '2020-11-30 17:00:00');

-- Listar todas as pessoas que obtiveram um resultado para testes no posto 1
CALL pessoas_testePosto(1);

-- Listar todas as pessoas de Mafra que realizaram testes
CALL pessoas_TesteLocalidade('Mafra');

-- Ver todas as marcações realizadas 
SELECT * FROM marcaoes_Efetuadas;

-- Ver todas as marcações ainda validas
SELECT * FROM marcacao
	WHERE date(Data_De_Realizacao) >= current_date();

-- Insere um teste 
select * from teste;
CALL insereTeste ('2020-11-30 16:40:00','C','N',NULL,7,10,1);