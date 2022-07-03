create schema produto;

--drop sequence id_seq_comentario
--drop sequence id_seq_preco
--drop sequence id_seq_armazenamento
--drop sequence id_seq_camera
--drop sequence id_seq_iphone
--drop sequence id_seq_site
--drop sequence id_seq_avaliacao


--drop sequence id_seq_comentario_fk
--drop sequence id_seq_preco_fk
--drop sequence id_seq_armazenamento_fk
--drop sequence id_seq_camera_fk
--drop sequence id_seq_iphone_fk
--drop sequence id_seq_site_fk
--drop sequence id_seq_avaliacao_fk



--alter table produto.iphone alter column nota type text;
create sequence id_seq_iphone;
create sequence id_seq_iphone_fk;
create table produto.iphone(
	bateria text,
	peso text,
	dimensao_produto text,
	imagem_iphone text,
	cor text NOT null,
	garantia text NOT null,
	itens_inclusos text,
	conectividade text NOT null,
	tipo_chip text,
	processador text NOT null,
	sistema_operacional text NOT null,
	resolucao_tela text NOT null,
	tamanho_tela text NOT null,
	modelo text NOT null,
	titulo text NOT null,
	id_iphone int default nextval('id_seq_iphone'),
		constraint pk_iphone primary key(id_iphone)
);

create sequence id_seq_avaliacao;
create sequence id_seq_avaliacao_fk;
create table produto.avaliacao(
	nota_avaliacao numeric,
	id_avaliacao int default nextval('id_seq_avaliacao'),
	id_iphone int default nextval('id_seq_avaliacao_fk'),
	constraint pk_avaliacao primary key(id_avaliacao),
	constraint fk_avaliacao foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade
);

create sequence id_seq_site;
create sequence id_seq_site_fk;
create table produto.site(
	url_site text,
	nome_site text,
	id_site int default nextval('id_seq_site'),
	id_iphone int default nextval('id_seq_site_fk'),
	constraint pk_site primary key(id_site),
	constraint fk_site foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade
);


create sequence id_seq_comentario;
create sequence id_seq_comentario_fk;
create table produto.comentario(
	descricao_comentario1 text,
	descricao_comentario2 text,
	descricao_comentario3 text,
	data_do_comentario1 text,
	data_do_comentario2 text,
	data_do_comentario3 text,
	id_comentario int default nextval('id_seq_comentario'),
	id_iphone int default nextval('id_seq_comentario_fk'),
	constraint pk_comentario primary key(id_comentario),
	constraint fk_comentario foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade
);


--alter table produto.preco alter column data_preco type text; 
create sequence id_seq_preco;
create sequence id_seq_preco_fk;
create table produto.preco(
	data_preco text,
	preco_antigo numeric, 
	preco_atual numeric,
	id_preco int default nextval('id_seq_preco'),
	id_iphone int default nextval('id_seq_preco_fk'),
	id_site int,
	constraint pk_preco primary key(id_preco),
	constraint fk_preco foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade,
	constraint fk_preco_site foreign key(id_site)
		references produto.site(id_site) on delete cascade
);

create sequence id_seq_armazenamento;
create sequence id_seq_armazenamento_fk;
create table produto.armazenamento(
	capacidade_armazenamento text,
	id_armazenamento int default nextval('id_seq_armazenamento'),
	id_iphone int default nextval('id_seq_armazenamento_fk'),
	constraint pk_id_armazenamento primary key(id_armazenamento),
	constraint fk_armazenamento foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade
);

create sequence id_seq_camera;
create sequence id_seq_camera_fk;
create table produto.camera(
	resolucao_camera text,
	id_camera int default nextval('id_seq_camera'),
	id_iphone int default nextval('id_seq_camera_fk'),
	constraint pk_camera primary key(id_camera),
	constraint fk_camera foreign key(id_iphone)
		references produto.iphone(id_iphone) on delete cascade
);
