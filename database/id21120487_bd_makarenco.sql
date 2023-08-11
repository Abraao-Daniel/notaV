
	create database id21120487_bd_makarenco;
	
	Use id21120487_bd_makarenco;

	create table tb_areaFormacao (
	id int primary key auto_increment,
	nome varchar(100) not null unique,
	abreviacao varchar(10) not null unique); 

	create table tb_curso(
	id int primary key auto_increment,
	nome varchar(100) not null unique,
	abreviacao varchar(10) not null,
	cod_areaFormacao int not null,
	foreign key(cod_areaFormacao) references tb_areaFormacao(id));
	
	create table tb_tipoSala(
	id int primary key auto_increment,
	nome varchar(50) not null unique);
	
	CREATE TABLE tb_SalaLocal(
	id int PRIMARY key auto_increment,
	nome VARCHAR(20) not NULL);
	
	create table tb_sala(
	id int primary key auto_increment,
	numero int not null,
	cod_tipoSala int not null,
	cod_salaLocal int not NULL,
	foreign key(cod_tipoSala) references tb_tipoSala(id),
	foreign key(cod_salaLocal) references tb_SalaLocal(id));
	
	create table tb_classe(
	id int primary key auto_increment,
	classe int not null);
	
	create table tb_aluno(
	id int UNIQUE auto_increment,
	numero_processo int primary key,
	nome varchar(100) not null);
	
     
                                                       
    create table tb_disciplina(
	id int primary key auto_increment,
	nome varchar(50) not null,
	abreviacao varchar(20) not null);
                                                       
                                                       
	create table tb_professor(
	id int primary key auto_increment,
	nome varchar(100) not null,
	numero_agente int not null,
	cod_disciplina int not null,
	foreign key(cod_disciplina) references tb_disciplina(id));

	create table tb_hora(
	id int primary key auto_increment,
	hora_inicio time not null,
	hora_fim time not null);
	
	create table tb_periodo(
	id int primary key auto_increment,
	nome varchar(10) not null unique,
	cod_horario int not null,
	foreign key(cod_horario) references tb_hora(id));
	
	create table tb_administrador(
	id int primary key auto_increment,
	cod_professor int not null,
	cod_areaFormacao int not null,
	email varchar(50) null,
	senha int not null,
	foreign key(cod_professor) references tb_professor(id),
	foreign key(cod_areaFormacao) references tb_areaFormacao(id));

		create table tb_trimestre(
	id int primary key auto_increment,
	nome varchar(50) not null,
	abreviacao varchar(25) not null);
	
	CREATE TABLE tb_AnoLectivo(
	id int PRIMARY KEY AUTO_INCREMENT,
	codigo VARCHAR(15) NOT NULL,
	inicio DATE NOT NULL,
	fim DATE NOT NULL);
	
	
	create table tb_notas(
	id int primary key auto_increment,
	numero_processo int not null,
	cod_disciplina int not null,
	PP int DEFAULT 0,
	Mac int DEFAULT 0,
	Pt int DEFAULT 0,
	cod_trimestre int not null,
	cod_anoLectivo int NOT Null,
	foreign key(numero_processo) references tb_aluno(numero_processo) ON DELETE CASCADE,
	foreign key(cod_disciplina) references tb_disciplina(id) ON DELETE CASCADE,
	foreign key(cod_trimestre) references tb_trimestre(id) ON DELETE CASCADE,
	foreign key(cod_anoLectivo) references tb_AnoLectivo(id) ON DELETE CASCADE);
	
		
	create table tb_turma(
	id int primary key auto_increment,
	nome varchar(15) not null,
	cod_sala int not null,
	cod_curso int not null,
	cod_classe int not null,
	cod_periodo int not null,
	cod_anoLectivo int NOT Null,
	Cod_Delegado int,
	Cod_Director int,
	foreign key(cod_sala) references tb_sala(id) ON DELETE CASCADE,
	foreign key(cod_curso) references tb_curso(id) ON DELETE CASCADE,
	foreign key(cod_classe) references tb_classe(id) ON DELETE CASCADE,
	foreign key(cod_periodo) references tb_periodo(id) ON DELETE CASCADE,
	foreign key(Cod_Delegado) references tb_aluno(numero_processo) ON DELETE CASCADE,
	foreign key(Cod_Director) references tb_professor(id) ON DELETE CASCADE,
	foreign key(cod_anoLectivo) references tb_AnoLectivo(id) ON DELETE CASCADE);
                                                       
    create table tb_aluno_turma(
	id int primary key auto_increment,
	cod_turma int not null,
	numero_processo int not null,
	foreign key(cod_turma) references tb_turma(id) ON DELETE CASCADE,
	foreign key(numero_processo) references tb_aluno(numero_processo) ON DELETE CASCADE);
	
	create table tb_turma_professor(
	id int primary key auto_increment,
	cod_professor int not null,
	cod_turma int not null,
	foreign key(cod_turma) references tb_turma(id) ON DELETE CASCADE,
	foreign key(cod_professor) references tb_professor(id) ON DELETE CASCADE);
                                                         
	create table tb_disciplina_professor(
	id int primary key auto_increment,
	cod_disciplina int not null,
	cod_professor int not null,
	foreign key(cod_disciplina) references tb_disciplina(id) ON DELETE CASCADE,
	foreign key(cod_professor) references tb_professor(id) ON DELETE CASCADE);
	
	create table tb_usuario_aluno(
	id int primary key auto_increment,
	numero_processo int not null,
	email varchar(50) not null unique,
	senha int not null,
	foreign key(numero_processo) references tb_aluno(numero_processo) ON DELETE CASCADE);
	
	create table tb_usuario_professor(
	id int primary key auto_increment,
	cod_professor int not null,
	email varchar(50) not null unique,
	senha int not null,
	foreign key(cod_professor) references tb_professor(id) ON DELETE CASCADE);
	
	CREATE TABLE tb_disciplina_curso_classe (
	id int PRIMARY key auto_increment,
	cod_disciplina int not null,
	cod_classe int not NULL,
	cod_curso int not null,
	foreign key(cod_disciplina) references tb_disciplina(id) ON DELETE CASCADE,
	foreign key(cod_curso) references tb_curso(id) ON DELETE CASCADE,
	foreign key(cod_classe) references tb_classe(id) ON DELETE CASCADE);
	

	CREATE TABLE tb_disciplinas_Gerais (
	id int PRIMARY key auto_increment,
	cod_disciplina int not null,
	cod_classe int,
	cod_areaFormacao int,
	foreign key(cod_disciplina) references tb_disciplina(id) ON DELETE CASCADE,
	foreign key(cod_areaFormacao) references tb_areaFormacao(id) ON DELETE CASCADE,
	foreign key(cod_classe) references tb_classe(id) ON DELETE CASCADE);
	
	
	/* Os Inserts da Basse de Dados*/
	INSERT into tb_areaFormacao VALUES
	(DEFAULT,'Informatica','INFO'),
	(DEFAULT,'Mecânica','MEC'),
	(DEFAULT,'Quimica','QI'),
	(DEFAULT,'Eletrecidade','ELEC'),
	(DEFAULT,'Construção Cívil','CIV');
	
	INSERT into tb_curso VALUES
	(DEFAULT,'Tecnico de Informatica','II',1),
	(DEFAULT,'Tecnico de Gestão de Sistemas Informáticos','IG',1),
	(DEFAULT,'Electrônica Idustrial e Automação','EA',4),
	(DEFAULT,'Electrônica e Telecomunicação','ET',4),
	(DEFAULT,'Eletrecidade e Instalações Eletrecidade','EI',4),
	(DEFAULT,'Energias Renovaveis','ER',4);
	
	
	INSERT into tb_tipoSala VALUES(DEFAULT, 'Sala de Aulas');
	
	INSERT into tb_SalaLocal VALUES
	(DEFAULT, 'Pavilhões'),
	(DEFAULT, 'Edíficio');
	
	INSERT INTO tb_sala VALUES
	(DEFAULT,'53',1,1),
	(DEFAULT,'54',1,1),
	(DEFAULT,'55',1,1),
	(DEFAULT,'56',1,1),
	(DEFAULT,'57',1,1),
	(DEFAULT,'58',1,1),
	(DEFAULT,'59',1,1),
	(DEFAULT,'60',1,1),
	(DEFAULT,'61',1,1),
	(DEFAULT,'64',1,1);
	
	INSERT INTO tb_classe VALUES
	(default,10),
	(default,11),
	(default,12),
	(default,13);
	
	INSERT into tb_aluno VALUES
	(DEFAULT,65932,'René Kemalandua'),
	(DEFAULT,65934,'Adalberto Jamba'),
	(DEFAULT,65935,'Abraão Daniel'),
	(DEFAULT,65936,'Divaldo Helder'),
	(DEFAULT,65937,'Domingos Morais'),
	(DEFAULT,65938,'Albano Mateus'),
	(DEFAULT,65939,'Fernando Afonso'),
	(DEFAULT,65910,'Victória Ventura'),
	(DEFAULT,65911,'Margarida Diamantino'),
	(DEFAULT,65912,'Eva Brandão'),
	(DEFAULT,65913,'Pedro Mendes'),
	(DEFAULT,65914,'Nelson Abreu'),
	(DEFAULT,65915,'Paulina Lelo'),
	(DEFAULT,65916,'Uganda Matari'),
	(DEFAULT,65917,'Emídio Quintas'),
	(DEFAULT,65918,'Álvaro Nsunda');
	
     
    	INSERT into tb_disciplina VALUES
	(DEFAULT,'Tecnicas e Linguagens de Programação','TLP'),
	(DEFAULT,'Tecnologias de Informação e Comunicação','TIC'),
	(DEFAULT,'Redes de Computadores','Redes'),
	(DEFAULT,'Matématica','MAT'),
	(DEFAULT,'Organização e Gestão Empresarial/Industrial','OGE/OGI'),
	(DEFAULT,'Inglês Tecnico','ING.TEC'),
	(DEFAULT,'Empreendedorismo','EMP'),
	(DEFAULT,'Física','FIS'),
	(DEFAULT,'Lingua Portuguesa','L.PORT'),
	(DEFAULT,'Projeto Tecnologico','PT'),
	(DEFAULT,'Lingua Inglesa','Inglês'),
	(DEFAULT,'Formação de Atitudes Integradoras','FAI'),
	(DEFAULT,'Educação Física','Ed.Física'),
	(DEFAULT,'Química Geral','Quimica'),
	(DEFAULT,'Informática','INFO'),
	(DEFAULT,'Eectrecidade e Eletrônica','ELECT-ELECT'),
	(DEFAULT,'Tecnologias de Comandos','Tec.Comandos'),
	(DEFAULT,'Praticas Oficinais e Laborais','POFL');
                                                 
	insert into tb_professor VALUES
	(default,'Lucas Pazito',1000, 1),
	(default,'Judson Paiva',1100, 2),
	(default,'Maria Nicolau',1110, 4),
	(default,'Edson Viegas',2111, 1),
	(default,'Acursio Cassongo',2211, 3),
	(default,'Luzia FlorBela',2221, 12),
	(default,'Sívio Santiago',2222, 1),
	(default,'Sebastião Freitas',3222, 4),
	(default,'Ilídio Octávio',3322, 2),
	(default,'João Pianga',3332, 9);
	
	INSERT into tb_hora VALUES
	(DEFAULT,'07:00','12:05'),
	(DEFAULT,'12:30','17:35'),
	(DEFAULT,'18:30','23:35');
	
	insert into tb_periodo VALUES
	(DEFAULT,'Manhã',1),
	(DEFAULT,'Tarde',2),
	(DEFAULT,'Noite',3);
	
	insert into tb_administrador VALUES
	(DEFAULT,1,1,'lucaspazito@gmail.com', 1234);
	
INSERT INTO tb_AnoLectivo VALUES
	(DEFAULT,"2020/2021","2020-09-05","2021-07-15"),
	(DEFAULT,"2021/2022","2021-09-05","2022-07-15"),
	(DEFAULT,"2022/2023","2022-09-05","2023-07-15");
                                                 
	insert into tb_turma VALUES
	(default,'IG10A',3,2,1,1,1,Default,Default),
	(default,'IG10B',1,2,1,2,1,Default,Default),
	(default,'IG11A',2,2,2,1,1,Default,Default),
	(default,'IG11B',6,2,2,2,1,Default,Default),
	(default,'IG12A',3,2,3,2,1,Default,Default),
	(default,'IG12B',4,2,4,3,1,Default,Default),
	(default,'IG13A',3,2,4,3,1,Default,Default),
	(default,'IG13B',4,2,3,2,1,Default,Default),
	(DEFAULT, 'II10A',5,1,1,1,1,Default,Default),
	(DEFAULT, 'II10B',7,1,1,2,1,Default,Default),
	(DEFAULT, 'II11A',7,1,2,1,1,Default,Default),
	(DEFAULT, 'II11B',8,1,2,2,1,Default,Default),
	(DEFAULT, 'II12A',7,1,3,2,1,Default,Default),
	(DEFAULT, 'II12B',9,1,3,2,1,Default,Default),
	(DEFAULT, 'II13A',7,1,4,3,1,Default,Default),
	(DEFAULT, 'II12B',9,1,4,3,1,Default,Default),
	(default,'EA10A',5,3,1,1,1, Default,Default),
	(default,'EA10B',7,3,1,2,1, Default,Default),
	(default,'EA11A',9,3,2,1,1, Default,Default),
	(default,'EA11B',6,3,2,2,1, Default,Default),
	(default,'EA12A',1,3,3,2,1, Default,Default),
	(default,'EA12B',4,3,4,3,1, Default,Default),
	(default,'EA13A',9,3,4,3,1, Default,Default),
	(default,'EA13B',4,3,3,2,1, Default,Default),
	(DEFAULT, 'ET10A',5,4,1,1,1,Default,Default),
	(DEFAULT, 'ET10B',7,4,1,2,1,Default,Default),
	(DEFAULT, 'ET11A',7,4,2,1,1,Default,Default),
	(DEFAULT, 'ET11B',8,4,2,2,1,Default,Default),
	(DEFAULT, 'ET12A',7,4,3,2,1,Default,Default),
	(DEFAULT, 'ET12B',9,4,3,2,1,Default,Default),
	(DEFAULT, 'ET13A',7,4,4,3,1,Default,Default),
	(DEFAULT, 'ET12B',9,4,4,3,2,Default,Default);
	
	insert into tb_aluno_turma VALUES
	(DEFAULT,5,65932),
	(DEFAULT,5,65934),
	(DEFAULT,5,65935),
	(DEFAULT,5,65936),
	(DEFAULT,5,65937),
	(DEFAULT,5,65938),
	(DEFAULT,5,65939),
	(DEFAULT,5,65910),
	(DEFAULT,5,65911),
	(DEFAULT,5,65912),
	(DEFAULT,5,65913),
	(DEFAULT,5,65914),
	(DEFAULT,5,65915),
	(DEFAULT,5,65916),
	(DEFAULT,5,65917),
	(DEFAULT,5,65918);
	
	insert into tb_turma_professor VALUES
	(DEFAULT,1,5),
	(DEFAULT,1,6),
	(DEFAULT,3,5),
	(DEFAULT,3,13);
	

	
	insert into tb_disciplina_professor VALUES
	(DEFAULT,1,1),
	(DEFAULT,2,1),
	(DEFAULT,4,3),
	(DEFAULT,9,10);
	
	INSERT into tb_disciplina_curso_classe VALUES
	(DEFAULT,1,3,2),
	(DEFAULT,2,3,2),
	(DEFAULT,3,3,2),
	(DEFAULT,16,1,3),
	(DEFAULT,17,1,3),
	(DEFAULT,18,1,3);
                                                 
                                                 	
	INSERT INTO tb_trimestre VALUES
	(DEFAULT,'1º Trimestre',' I'),
	(DEFAULT,'2º Trimestre',' II'),
	(DEFAULT,'2º Trimestre',' III');
	
	INSERT into tb_notas VALUES
	(DEFAULT,65932,1,19,20,18,1,3),
	(DEFAULT,65934,1,13,14,15,1,3),
	(DEFAULT,65935,1,16,17,18,1,3),
	(DEFAULT,65936,1,19,20,15,1,3),
	(DEFAULT,65937,1,10,11,12,1,3),
	(DEFAULT,65938,1,16,11,14,1,3),
	(DEFAULT,65939,1,15,19,16,1,3),
	(DEFAULT,65910,1,10,11,12,1,3),
	(DEFAULT,65911,1,10,11,12,1,3),
	(DEFAULT,65912,1,10,11,12,1,3),
	(DEFAULT,65913,1,10,11,12,1,3),
	(DEFAULT,65914,1,10,11,12,1,3),
	(DEFAULT,65915,1,10,11,12,1,3),
	(DEFAULT,65916,1,10,11,12,1,3),
	(DEFAULT,65917,1,10,11,12,1,3),
	(DEFAULT,65918,1,10,11,12,1,3),
	(DEFAULT,65932,2,18,17,19,1,3),
	(DEFAULT,65934,2,15,13,14,1,3),
	(DEFAULT,65935,2,18,16,17,1,3),
	(DEFAULT,65936,2,15,19,20,1,3),
	(DEFAULT,65937,2,12,10,11,1,3),
	(DEFAULT,65938,2,14,16,11,1,3),
	(DEFAULT,65939,2,16,15,19,1,3),
	(DEFAULT,65910,2,12,10,11,1,3),
	(DEFAULT,65911,2,16,10,11,1,3),
	(DEFAULT,65912,2,15,10,11,1,3),
	(DEFAULT,65913,2,10,10,11,1,3),
	(DEFAULT,65914,2,10,12,11,1,3),
	(DEFAULT,65915,2,10,15,11,1,3),
	(DEFAULT,65916,2,10,18,11,1,3),
	(DEFAULT,65917,2,10,15,11,1,3),
	(DEFAULT,65918,2,10,12,11,1,3),
	(DEFAULT,65932,3,15,16,17,1,3),
	(DEFAULT,65934,3,14,13,15,1,3),
	(DEFAULT,65935,3,17,16,18,1,3),
	(DEFAULT,65936,3,20,19,15,1,3),
	(DEFAULT,65937,3,11,10,12,1,3),
	(DEFAULT,65938,3,11,16,14,1,3),
	(DEFAULT,65939,3,19,15,16,1,3),
	(DEFAULT,65910,3,11,10,12,1,3),
	(DEFAULT,65911,3,11,10,16,1,3),
	(DEFAULT,65912,3,11,10,15,1,3),
	(DEFAULT,65913,3,11,10,10,1,3),
	(DEFAULT,65914,3,11,12,10,1,3),
	(DEFAULT,65915,3,11,15,10,1,3),
	(DEFAULT,65916,3,11,18,10,1,3),
	(DEFAULT,65917,3,11,15,10,1,3),
	(DEFAULT,65918,3,11,12,10,1,3);

	

	
	INSERT INTO tb_disciplinas_Gerais VALUES
	(DEFAULT,4,1,DEFAULT),
	(DEFAULT,4,2,DEFAULT),
	(DEFAULT,4,3,DEFAULT),
	(DEFAULT,8,1,DEFAULT),
	(DEFAULT,8,2,DEFAULT),
	(DEFAULT,8,3,1),
	(DEFAULT,9,1,DEFAULT),
	(DEFAULT,9,2,DEFAULT),
	(DEFAULT,11,1,DEFAULT),
	(DEFAULT,11,2,DEFAULT),
	(DEFAULT,12,1,DEFAULT),
	(DEFAULT,12,2,DEFAULT),
	(DEFAULT,13,1,DEFAULT),
	(DEFAULT,13,2,DEFAULT),
	(DEFAULT,14,1,DEFAULT),
	(DEFAULT,14,2,DEFAULT),
	(DEFAULT,15,1,2),
	(DEFAULT,15,2,2),
	(DEFAULT,15,1,3),
	(DEFAULT,15,2,3),
	(DEFAULT,15,1,4),
	(DEFAULT,15,2,4),
	(DEFAULT,7,1,DEFAULT),
	(DEFAULT,7,2,DEFAULT),
	(DEFAULT,7,3,DEFAULT),
	(DEFAULT,6,3,DEFAULT),
	(DEFAULT,10,3,DEFAULT),
	(DEFAULT,10,4,DEFAULT),
	(DEFAULT,5,3,DEFAULT);
	
	/* Alteraçoes na bd */
	
	ALTER TABLE tb_aluno ADD sexo VARCHAR(10);
	
	UPDATE tb_aluno SET sexo = "feminino" WHERE id = 8 ;
	UPDATE tb_aluno SET sexo = "feminino" WHERE id = 9 ;
	UPDATE tb_aluno SET sexo = "feminino" WHERE id = 10;
	UPDATE tb_aluno SET sexo = "feminino" WHERE id = 13;
	UPDATE tb_aluno SET sexo = "feminino" WHERE id = 14;
	
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 1 ;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 2 ;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 3;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 4;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 5;
								
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 6 ;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 7 ;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 11;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 12;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 15;
	UPDATE tb_aluno SET sexo = "masculino" WHERE id = 16;
	
	ALTER TABLE tb_aluno_turma ADD numeroAlunoTurma int;
	
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 1 WHERE numero_processo = 65935;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 2 WHERE numero_processo = 65934;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 3 WHERE numero_processo = 65932;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 4 WHERE numero_processo = 65938;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 6 WHERE numero_processo = 65918;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 16 WHERE numero_processo = 65937;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 21 WHERE numero_processo = 65939;
	
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 19 WHERE numero_processo = 65912;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 37 WHERE numero_processo = 65914;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 35 WHERE numero_processo = 65910;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 34 WHERE numero_processo = 65916;
	
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 18 WHERE numero_processo = 65917;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 14 WHERE numero_processo = 65936;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 32 WHERE numero_processo = 65913;
	UPDATE tb_aluno_turma SET numeroAlunoTurma = 31 WHERE numero_processo = 65915;
	
	UPDATE tb_turma SET cod_sala = 10 where id = 5;
	update tb_aluno set sexo = "M" where sexo = "masculino";
	update tb_aluno set sexo = "F" where sexo = "feminino";
	
	UPDATE tb_turma SET cod_classe = 4 WHERE id = 8;
	UPDATE tb_turma SET cod_classe = 4 WHERE id = 24;
	
	UPDATE tb_turma SET cod_classe = 3 WHERE id = 6;
	UPDATE tb_turma SET cod_classe = 3 WHERE id = 22;
	
	UPDATE tb_turma SET nome = "ET13B" WHERE id = 32;
	UPDATE tb_turma SET nome = "II13B" WHERE id = 16;
	
	UPDATE tb_turma SET cod_anoLectivo = 1 WHERE cod_curso = 1 AND cod_classe = 1;
	UPDATE tb_turma SET cod_anoLectivo = 1 WHERE cod_curso = 2 AND cod_classe = 1;
	
	UPDATE tb_turma SET cod_anoLectivo = 2 WHERE cod_curso = 1 AND cod_classe = 2;
	UPDATE tb_turma SET cod_anoLectivo = 2 WHERE cod_curso = 2 AND cod_classe = 2;
	
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 1 AND cod_classe = 3;
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 2 AND cod_classe = 3;
	
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 1 AND cod_classe = 4;
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 2 AND cod_classe = 4;
	
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 3 ;
	UPDATE tb_turma SET cod_anoLectivo = 3 WHERE cod_curso = 4 ;
	
	
	/* Inserindo as notas do aluno 65932*/
	INSERT into tb_notas VALUES
	(DEFAULT,65932,1,18,17,19,2,3),
	(DEFAULT,65932,1,17,16,18,3,3),
	(DEFAULT,65932,2,17,17,17,2,3),
	(DEFAULT,65932,2,18,18,15,3,3),
	(DEFAULT,65932,3,15,13,13,2,3),
	(DEFAULT,65932,3,16,15,10,3,3),
	(DEFAULT,65932,4,12,18,8,1,3),
	(DEFAULT,65932,4,11,10,8,2,3),
	(DEFAULT,65932,4,10,16,8,3,3),
	(DEFAULT,65932,6,12,18,17,1,3),
	(DEFAULT,65932,6,15,14,17,2,3),
	(DEFAULT,65932,6,15,12,15,3,3),
	(DEFAULT,65932,7,12,13,10,1,3),
	(DEFAULT,65932,7,15,10,11,2,3),
	(DEFAULT,65932,7,13,12,14,3,3),
	(DEFAULT,65932,8,12,10,11,1,3),
	(DEFAULT,65932,8,13,14,12,2,3),
	(DEFAULT,65932,8,13,12,14,3,3),
	(DEFAULT,65932,10,17,15,14,1,3),
	(DEFAULT,65932,10,16,14,14,2,3),
	(DEFAULT,65932,10,13,12,15,3,3),
	(DEFAULT,65932,5,12,14,10,1,3),
	(DEFAULT,65932,5,10,11,12,2,3),
	(DEFAULT,65932,5,20,20,20,3,3);
	
	/*Outros inserts*/
	INSERT into tb_aluno VALUES
	(DEFAULT,70526,'Ayoub Kemalandua','M');

	insert into tb_aluno_turma VALUES
	(DEFAULT,17,70526,3);