CREATE SCHEMA biblioteca;  

CREATE TABLE biblioteca.pessoa(
	nome VARCHAR(50),
	ssn VARCHAR(50),
	endereco VARCHAR(50),
	telefone VARCHAR(50),
	CONSTRAINT pk_pessoa_ssn PRIMARY KEY(ssn)
);

CREATE TABLE biblioteca.candidato(
	ssn VARCHAR(50),
	CONSTRAINT pk_candidato_ssn PRIMARY KEY(ssn),
	CONSTRAINT fk_candidato_pessoa_ssn FOREIGN KEY(ssn)
		REFERENCES biblioteca.pessoa(ssn) ON DELETE CASCADE 
);

CREATE TABLE biblioteca.membro(
	ssn VARCHAR(50),
	ativo VARCHAR(50),
	regularizador VARCHAR(50),
	emprestimo_ativo VARCHAR(50),
	id_cargo VARCHAR(50) NOT null,
	CONSTRAINT pk_membro_ssn PRIMARY KEY(ssn),
	CONSTRAINT uk_membro_id_cargo UNIQUE(id_cargo),
	CONSTRAINT fk_membro_pessoa_ssn FOREIGN KEY(ssn)
		REFERENCES biblioteca.pessoa(ssn) ON DELETE CASCADE,
	CONSTRAINT fk_membro_cargo_id_cargo FOREIGN KEY(id_cargo)
		REFERENCES biblioteca.cargo(id_cargo) ON DELETE CASCADE
);

CREATE TABLE biblioteca.aprovado(
	candidato_ssn VARCHAR(50),
	membro_ssn VARCHAR(50),	
	CONSTRAINT pk_aprovado_candidato_ssn_membro_ssn PRIMARY KEY(candidato_ssn,membro_ssn),
	CONSTRAINT fk_aprovado_candidato_ssn FOREIGN KEY(candidato_ssn)
		REFERENCES biblioteca.candidato(ssn) ON DELETE CASCADE,
	CONSTRAINT fk_aprovado_membro_ssn FOREIGN KEY(membro_ssn)
		REFERENCES biblioteca.candidato(ssn) ON DELETE CASCADE
);

CREATE TABLE biblioteca.cargo(
	tempo_emprestimo DATE,
	tempo_carencia DATE,
	limite_emprestimo DATE,
	id_cargo VARCHAR(50),
	CONSTRAINT pk_cargo_id_cargo PRIMARY KEY(id_cargo)
);

CREATE TABLE biblioteca.cartao(
	numero int,
	foto VARCHAR(50),
	data_emissao DATE,
	validade DATE,
	data_aviso DATE,
	ativo VARCHAR(50),
	membro_ssn VARCHAR(50),
	CONSTRAINT pk_cartao_numero PRIMARY KEY(numero),
	CONSTRAINT fk_cartao_membro_ssn FOREIGN KEY(membro_ssn)
		REFERENCES biblioteca.membro(ssn) ON DELETE CASCADE
);

CREATE TABLE biblioteca.item(
	codigo int,
	interesse VARCHAR(50),
	estoque_disponivel int,
	estoque_destruido int,
	estoque_emprestado int,
	emprestavel int,
	id_catalogo VARCHAR(50) NOT null,
	CONSTRAINT pk_item_codigo PRIMARY KEY(codigo),
	CONSTRAINT pk_item_catalogo_id_catalogo FOREIGN KEY(id_catalogo)
		REFERENCES biblioteca.catalogo(id_catalogo) ON DELETE CASCADE
);

CREATE TABLE biblioteca.emprestimo(
	item_codigo int,
	membro_ssn VARCHAR(50),
	data_retirada DATE NOT null,
	data_inicio_carencia DATE NOT null,
	data_final DATE NOT null,
	devolvido VARCHAR(50) NOT null,
	CONSTRAINT pk_emprestimo_item_codigo_membro_ssn PRIMARY KEY(item_codigo,membro_ssn),
	CONSTRAINT fk_emprestimo_item_codigo FOREIGN KEY(item_codigo)
		REFERENCES biblioteca.item(codigo),
	CONSTRAINT fk_emprestimo_membro_ssn FOREIGN KEY(membro_ssn)
		REFERENCES biblioteca.membro(ssn)
);

CREATE TABLE biblioteca.catalogo(
	id_catalogo VARCHAR(50),
	CONSTRAINT pk_catalogo_id_catalogo PRIMARY KEY(id_catalogo)
);

CREATE TABLE biblioteca.livro(
	isbn VARCHAR(50),
	titulo VARCHAR(50),
	autor VARCHAR(50),
	edicao VARCHAR(50),
	area VARCHAR(50),
	descricao VARCHAR(100),
	CONSTRAINT pk_livro_isbn PRIMARY KEY(isbn)
);

CREATE TABLE biblioteca.e_um(
	livro_isbn VARCHAR(50),
	item_codigo int,
	CONSTRAINT pk_e_um_livro_isbn_item_codigo PRIMARY KEY(livro_isbn,item_codigo),
	CONSTRAINT fk_e_um_livro_isbn FOREIGN KEY(livro_isbn)
		REFERENCES biblioteca.livro(isbn) ON DELETE CASCADE,
	CONSTRAINT fk_e_um_item_codigo FOREIGN KEY(item_codigo)
		REFERENCES biblioteca.item(codigo) ON DELETE CASCADE
);
