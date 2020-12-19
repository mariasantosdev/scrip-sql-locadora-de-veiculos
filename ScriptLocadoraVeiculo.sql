create database tcmada;
use tcmada;




create table funcionario (
	cod_func int auto_increment,
	nome_func varchar(100) not null,
	telefone_func char (11) NOT NULL,
	email_func varchar (50),
	senha_func varchar (15) NOT NULL,
    tipo_acesso bit not null,
    cargo varchar(30),
    primary key (cod_func));
        insert into funcionario value
(null,'administrador', '11964551358', 'mariaeduardasrodolfo@gmail.com', 'teste123', 1, 'analista de sistemas');

    create table cliente (
	cod_cliente int auto_increment,
	nome_cliente varchar (60) NOT NULL,
	cpf_cliente varchar (14),
	CNH_cliente varchar (11) ,
	telefone_cliente varchar (11) ,
	email_cliente varchar (50),
	data_nasc_cliente datetime,
    primary key (cod_cliente));
    SELECT * FROM cliente;
        insert into cliente value
(null, 'Maria Santos', '12345678911','17586580642', '98765432119','dudinhaflamengo','1980-10-10');
insert into cliente (cod_cliente,nome_cliente,data_nasc_cliente,telefone_cliente)
values(null,'João Anastácio Perreira','2016-10-12','965446780');

    create table GrupoDeVeiculos (
	cod_GrupoDeVeiculos  int auto_increment,
	nome_grupo varchar (20) NOT NULL,
	valor_caucao_veiculo float(8),
	ar_condicionado bit NOT NULL,
	direcao_hidraulica bit NOT NULL,
	vidro_eletrico bit NOT NULL,
	trava_eletrica bit NOT NULL,
	portas char (1) NOT NULL,
	motor varchar (20) NOT NULL,
	cambio varchar (10) NOT NULL,
	valor_diaria float (23) not null,
  primary key (cod_GrupoDeVeiculos));
  
  INSERT INTO GrupoDeVeiculos VALUES
(null,'GRUPO A',72,1,1,1,1,4,2 ,'automatico', '100.50');

 create table veiculo (
	cod_veiculo int auto_increment,
    combustivel varchar (10) NOT NULL,
	placa_veiculo varchar (7) NOT NULL,
	chassi_veiculo varchar (17) NOT NULL,
	marca_veiculo varchar (15) NOT NULL,
	modelo_veiculo varchar (20) NOT NULL,
	ano_veiculo int (4) NOT NULL,
	cor_veiculo varchar (10) NOT NULL,
	status_veiculo bit NOT NULL,
    cod_GrupoDeVeiculos int,
	  primary key (cod_veiculo), 
      foreign key (cod_GrupoDeVeiculos) references GrupoDeVeiculos (cod_GrupoDeVeiculos));
      INSERT INTO veiculo VALUES
(null, 'flex','ASD2899', '12789690575287286','FORD','FORD FIESTA',2019, 'Preto', 1, 1);
select * from veiculo;
        create table reserva (
	cod_reserva int auto_increment,
	data_retirada date NOT NULL,
	data_devolucao date NOT NULL,
	valtotal_reserva double NOT NULL,
	status_reserva varchar(100),
    cod_GrupoDeVeiculos int,
    cod_cliente int,
    primary key (cod_reserva),
         foreign key (cod_cliente) references cliente (cod_cliente),
          foreign key (cod_GrupoDeVeiculos) references GrupoDeVeiculos (cod_GrupoDeVeiculos));
          INSERT INTO reserva Values
(null,'2019-12-07', '2019-12-14', 150.99, 'Em andamento', (SELECT cod_cliente FROM cliente WHERE cpf_cliente = '12345678911'), (SELECT cod_GrupoDeVeiculos FROM GrupoDeVeiculos WHERE nome_grupo = 'GRUPO A'));
          select * from reserva; 
          
          create table Locacao (
	cod_locacao int auto_increment,
	seguro_locacao bit NOT NULL,
	data_retirada date NOT NULL,
	devolucao_prevista date NOT NULL,
	valtotal_locacao double NOT NULL,
	status_locacao bit NOT NULL,
	devolucao_efetuada date,
    cod_reserva int,
    cod_GrupoDeVeiculos int,
    cod_veiculo int,
    cod_pagamento int,
    cod_cliente int,
    cod_func int,
    primary key (cod_locacao),
         foreign key (cod_reserva) references reserva (cod_reserva),
          foreign key (cod_GrupoDeVeiculos) references GrupoDeVeiculos (cod_GrupoDeVeiculos),
         foreign key (cod_veiculo) references veiculo (cod_veiculo),
          foreign key (cod_cliente) references cliente (cod_cliente),
          foreign key (cod_func) references funcionario (cod_func));
          
          
		create table Endereco (
	cod_endereco int  auto_increment,
	lodradouro varchar (40) NOT NULL,
	numero varchar (10) NOT NULL,
	complemento varchar (100),
	bairro varchar (20) NOT NULL,
	cidade varchar (30) NOT NULL,
	estado varchar (20) NOT NULL,
	cep varchar (8) NOT NULL,
	pais Varchar (20) NOT NULL,
	cod_cliente int,
    primary key (cod_endereco),
          foreign key (cod_cliente) references cliente (cod_cliente));
          INSERT INTO Endereco
VALUES
(null,'RUA São Jeronumo da serra',63, 'casa 4','Vila Jaguara', 'São Paulo', 'São Paulo', '04862000', 'Brasil', (SELECT cod_cliente FROM cliente WHERE cpf_cliente = '12345678911'));
          select * from endereco;
          create table Pagamento (
	cod_pagamento int auto_increment,
	num_cartao varchar (16) NOT NULL,
	validade_cartao datetime NOT NULL,
    cvv_cartao int(4),
	num_parcelas int (2) NOT NULL,
	valtotal_pagamento float (8) NOT NULL,
	cod_locacao int,
    cod_cliente int,
    tipo_pagamento varchar(10),
    primary key (cod_pagamento),
	       foreign key (cod_locacao) references Locacao (cod_locacao));
           select * from Pagamento;