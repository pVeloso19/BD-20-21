# SGBD de uma clínica de testagem à Covid-19
## BD-20-21

> Trabalho realizado no âmbito da disciplina de Base de Dados (2020/21) na Universidade do Minho.
>
> Numa realidade marcada pela pandemia do vírus covid-19, é imperativo que os Estados consigam rastrear e monitorizar os doentes infetados pelo vírus. Neste contexto, as bases de dados têm um papel fundamental. Neste trabalho, serão apresentados os modelos para construção de um sistema de gestão de bases de dados para uma clínica de realização de testes à covid-19, que tem que gerir marcações, postos de recolha e laboratórios de análise, bem como o registo dos clientes e seus dados. 
>
> Assim, foram identificadas várias entidades a colocar na base de dados: cliente, marcação, clínica, teste, posto, laboratório, funcionário e horário. Um cliente realiza uma marcação para realização do teste numa clínica. Na altura de marcação, deve ficar registado o posto onde a colheita será efetuada, bem como a hora e data de realização. Após a colheita, o material é enviado para um laboratório, onde um funcionário o irá analisar e emitir um resultado. A associação do cliente ao resultado e posto de colheita, deve ficar registada na BD. 
>
> Um cliente é identificado pelos atributos número de cartão de cidadão (chave primária), data de nascimento, nome, género, morada (composto por rua, localidade e código postal), e por um ou mais contactos (atributo multivalorado). A marcação apresenta um identificador, uma data de realização e, no caso de os testes serem realizados no modo drive-in, a entidade deve ainda ter associada uma matrícula do veículo do cliente, sendo, portanto, este um campo de preenchimento opcional. O posto, apresenta um identificador, um nome, morada, contacto e email. O horário, além do identificador, deve ter um dia, horário de funcionamento da parte da manhã e tarde associados. A entidade teste é caracterizada por um identificador, tipo de teste (monitorização, imunidade e à covid-19), datas de realização e análise, resultado (positivo, negativo ou inconclusivo) e observações, sendo estas opcionais. O laboratório, tal como a clínica, tem um identificador e um nome, e ainda um tipo (interno ou externo, no caso de ser próprio da clínica ou subcontratado). Nestas entidades o identificador é sempre a chave primária. Por fim, o funcionário apresenta um código (chave primária) e um nome. 
>
> Com base nestas entidades e nas possíveis relações entre elas, resumidas num Diagrama de Entidades-Relacionamentos, desenvolveu-se um modelo lógico, que criou tabelas para cada entidade. Este modelo, depois de validado, foi implementado usando o MySQL.
>
> O resultado deste trabalho pode ser evidenciado no [relatório](https://github.com/pVeloso19/BD-20-21/blob/main/Relatorio_BD-ClinicaTestagemCovid.pdf) elaborado.

###### Nota Final 15/20
