CREATE SCHEMA universidade;  

CREATE TABLE universidade.pessoa(
	cpf VARCHAR(20),
	pnome VARCHAR(30),
	snome VARCHAR(30),
	dt_nasc DATE,
	sexo CHAR,
	rua VARCHAR(50),
	bairro VARCHAR(50),
	cidade VARCHAR(50),
	estado VARCHAR(50),
	CONSTRAINT pk_pessoa_cpf PRIMARY KEY(cpf)
);

CREATE TABLE universidade.pessoa_aluno(
	cpf_aluno VARCHAR(20),
	CONSTRAINT pk_pessoa_aluno_cpf_aluno PRIMARY KEY(cpf_aluno),
	CONSTRAINT fk_pessoa_aluno_pessoa_cpf FOREIGN KEY(cpf_aluno)
		REFERENCES universidade.pessoa(cpf) ON DELETE CASCADE
);

CREATE TABLE universidade.pessoa_professor(
	cpf_professor VARCHAR(20),
	categoria VARCHAR(50),
	salario NUMERIC(10,2),
	departamento_sigla VARCHAR(20) NOT null,
	CONSTRAINT pk_pessoa_professor_cpf_professor PRIMARY KEY(cpf_professor),
	CONSTRAINT fk_pessoa_professor_pessoa_cpf FOREIGN KEY(cpf_professor)
		REFERENCES universidade.pessoa(cpf) ON DELETE CASCADE,
	CONSTRAINT fk_pessoa_professor_departamento_sigla FOREIGN KEY(departamento_sigla)
		REFERENCES universidade.departamento(sigla) ON DELETE CASCADE
);

CREATE TABLE universidade.aluno_grad(
	cpf_aluno_grad VARCHAR(20),
	CONSTRAINT pk_aluno_grad_cpf_aluno_grad PRIMARY KEY(cpf_aluno_grad),
	CONSTRAINT fk_aluno_grad_pessoa_aluno_cpf_aluno FOREIGN KEY(cpf_aluno_grad)
		REFERENCES universidade.pessoa_aluno(cpf_aluno) ON DELETE CASCADE
);

CREATE TABLE universidade.aluno_pos(
	cpf_aluno_pos VARCHAR(20),
	CONSTRAINT pk_aluno_pos_cpf_aluno_pos PRIMARY KEY(cpf_aluno_pos),
	CONSTRAINT fk_aluno_pos_pessoa_aluno_cpf_aluno FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.pessoa_aluno(cpf_aluno) ON DELETE CASCADE 
);

CREATE TABLE universidade.curso(
	cod VARCHAR(20),
	nome VARCHAR(50) NOT null,
	CONSTRAINT pk_curso_cod PRIMARY KEY(cod),
	CONSTRAINT uk_curso_nome UNIQUE(nome)
);

CREATE TABLE universidade.curso_pos(
	cod_curso_pos VARCHAR(20),
	CONSTRAINT pk_curso_pos_cod_curso_pos PRIMARY KEY(cod_curso_pos),
	CONSTRAINT fk_curso_pos_curso_cod FOREIGN KEY(cod_curso_pos)
		REFERENCES universidade.curso(cod) ON DELETE CASCADE
);

CREATE TABLE universidade.curso_grad(
	cod_curso_grad VARCHAR(20),
	CONSTRAINT pk_curso_grad_cod_curso_grad PRIMARY KEY(cod_curso_grad),
	CONSTRAINT fk_curso_grad_curso_cod FOREIGN KEY(cod_curso_grad)
		REFERENCES universidade.curso(cod) ON DELETE CASCADE 
);

CREATE TABLE universidade.orienta(
	cpf_professor VARCHAR(20),
	cpf_aluno_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	CONSTRAINT pk_orienta_cpf_aluno_pos_curso_pos PRIMARY KEY(cpf_aluno_pos,cod_curso_pos),
	CONSTRAINT fk_orienta_pessoa_professor_cpf_professor FOREIGN KEY(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE,
	CONSTRAINT fk_orienta_aluno_pos_cpf_aluno_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE,
	CONSTRAINT fk_orienta_curso_pos_cod_curso_pos FOREIGN KEY(cod_curso_pos)
		REFERENCES universidade.curso_pos(cod_curso_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.banca(
	cpf_professor VARCHAR(20),
	cpf_aluno_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	CONSTRAINT pk_banca_cpf_professor_cpf_aluno_pos_cod_curso_pos PRIMARY KEY(cpf_professor,cpf_aluno_pos,cod_curso_pos),
	CONSTRAINT fk_banca_pessoa_professor_cpf_professor FOREIGN KEY(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE,
	CONSTRAINT fk_banca_aluno_pos_cpf_aluno_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE,
	CONSTRAINT fk_banca_curso_pos_cod_curso_pos FOREIGN KEY(cod_curso_pos)
		REFERENCES universidade.curso_pos(cod_curso_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.agencia(
	sigla VARCHAR(10),
	nome VARCHAR(20),
	CONSTRAINT pk_agencia_sigla PRIMARY KEY(sigla),
	CONSTRAINT uk_agencia_nome UNIQUE(nome)
);

CREATE TABLE universidade.bolsa(
	numero_processo VARCHAR(20),
	bolsa_sigla VARCHAR(20),
	CONSTRAINT pk_bolsa_numero_processo_bolsa_sigla PRIMARY KEY(numero_processo,bolsa_sigla),
	CONSTRAINT fk_bolsa_agencia_silga FOREIGN KEY(bolsa_sigla)
		REFERENCES universidade.agencia(sigla) ON DELETE CASCADE
);

CREATE TABLE universidade.bolsista(
	cpf_aluno_pos VARCHAR(20),
	cpf_professor VARCHAR(20),
	id_bolsista VARCHAR(20),
	CONSTRAINT pk_bolsista_id_bolsiata PRIMARY KEY(id_bolsista),
	CONSTRAINT fk_bolsista_aluno_pos_cpf_aluno_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE,
	CONSTRAINT fk_bolsista_pessoa_professor_cpf_professor foreign key(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE
);

CREATE TABLE universidade.atribuida(
	numero_processo VARCHAR(20),
	bolsa_sigla VARCHAR(20),
	id_bolsista VARCHAR(20),
	CONSTRAINT pk_atribuita_numero_processo_bolsa_sigla_id_bolsista PRIMARY KEY(numero_processo,bolsa_sigla,id_bolsista),
	CONSTRAINT fk_atribuita_bolsa_numero_processo_bolsa_sigla FOREIGN KEY(numero_processo,bolsa_sigla)
		REFERENCES universidade.bolsa(numero_processo,bolsa_sigla) ON DELETE CASCADE,
	CONSTRAINT fk_atribuita_bolsista_id_bolsista FOREIGN KEY(id_bolsista)
		REFERENCES universidade.bolsista(id_bolsista) ON DELETE CASCADE
);

CREATE TABLE universidade.professor_grad(
	cpf_professor VARCHAR(20),
	cpf_aluno_pos VARCHAR(20),
	id_professor_grad VARCHAR(20),
	CONSTRAINT pk_professor_grad_id_professor_grad PRIMARY KEY(id_professor_grad),
	CONSTRAINT fk_professor_grad_pessoa_professor_cpf_professor FOREIGN KEY(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE,
	CONSTRAINT fk_professor_grad_aluno_pos_cpf_aluno_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.centro(
	sigla VARCHAR(10),
	nome VARCHAR(20) NOT null,
	CONSTRAINT pk_centro_sigla PRIMARY KEY(sigla),
	CONSTRAINT uk_centro_nome UNIQUE(nome)
);

CREATE TABLE universidade.departamento(
	sigla VARCHAR(10),
	centro_sigla VARCHAR(10) NOT null,
	nome VARCHAR(20) NOT null,
	CONSTRAINT pk_departamento_sigla PRIMARY KEY(sigla),
	CONSTRAINT uk_departamento_nome UNIQUE(nome),
	CONSTRAINT fk_departamento_centro_sigla FOREIGN KEY(centro_sigla)
		REFERENCES universidade.centro(sigla) ON DELETE CASCADE
);

CREATE TABLE universidade.chefia(
	periodo_inicio VARCHAR(20),
	periodo_fim VARCHAR(20),
	departamento_sigla VARCHAR(10),
	cpf_professor VARCHAR(20) NOT null,
	CONSTRAINT pk_chefia_periodo_inicio_periodo_fim_departamento_sigla PRIMARY KEY(periodo_inicio,periodo_fim,departamento_sigla),
	CONSTRAINT fk_chefia_departamento_sigla FOREIGN KEY(departamento_sigla)
		REFERENCES universidade.departamento(sigla) ON DELETE CASCADE,
	CONSTRAINT fk_chefia_pessoa_professor_cpf_professor FOREIGN KEY(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE
);

CREATE TABLE universidade.oferece(
	departamento_sigla VARCHAR(10),
	curso_cod VARCHAR(20),
	CONSTRAINT pk_oferece_departamento_sigla_curso_cod PRIMARY KEY(departamento_sigla,curso_cod),
	CONSTRAINT fk_oferece_departamento_sigla FOREIGN KEY(departamento_sigla)
		REFERENCES universidade.departamento(sigla) ON DELETE CASCADE,
	CONSTRAINT fk_oferece_curso_cod FOREIGN KEY(curso_cod)
		REFERENCES universidade.curso(cod) ON DELETE CASCADE
);

CREATE TABLE universidade.disciplina(
	cod VARCHAR(20),
	nome VARCHAR(20),
	ementa VARCHAR(30),
	CONSTRAINT pk_disciplina_cod PRIMARY KEY(cod)
);

CREATE TABLE universidade.disciplina_pos(
	cod_pos VARCHAR(20),
	CONSTRAINT pk_disciplina_pos_cod_pos PRIMARY KEY(cod_pos),
	CONSTRAINT fk_disciplina_pos_disciplina_cod FOREIGN KEY(cod_pos)
		REFERENCES universidade.disciplina(cod) ON DELETE CASCADE
);

CREATE TABLE universidade.disciplina_grad(
	cod_grad VARCHAR(20),
	CONSTRAINT pk_disciplina_grad_cod_grad PRIMARY KEY(cod_grad),
	CONSTRAINT fk_disciplina_grad_disciplina_cod FOREIGN KEY(cod_grad)
		REFERENCES universidade.disciplina(cod) ON DELETE CASCADE 
);

CREATE TABLE universidade.disc_curso_pos(
	cod_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	CONSTRAINT pk_disc_curso_pos_cod_pos_cod_curso_pos PRIMARY KEY(cod_pos,cod_curso_pos),
	CONSTRAINT fk_disc_curso_pos_disciplina_pos_cod_pos FOREIGN KEY(cod_pos)
		REFERENCES universidade.disciplina_pos(cod_pos) ON DELETE CASCADE,
	CONSTRAINT fk_disc_curso_pos_curso_pos_cod_curso_pos FOREIGN KEY(cod_curso_pos)
		REFERENCES universidade.curso_pos(cod_curso_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.disc_curso_grad(
	cod_grad VARCHAR(20),
	cod_curso_grad VARCHAR(20),
	CONSTRAINT pk_disc_curso_grad_cod_grad_cod_curso_grad PRIMARY KEY(cod_grad,cod_curso_grad),
	CONSTRAINT fk_disc_curso_grad_disciplina_grad_cod_grad FOREIGN KEY(cod_grad)
		REFERENCES universidade.disciplina_grad(cod_grad) ON DELETE CASCADE,
	CONSTRAINT fk_disc_curso_grad_curso_grad_cod_curso_grad FOREIGN KEY(cod_curso_grad)
		REFERENCES universidade.curso_grad(cod_curso_grad) ON DELETE CASCADE
);

CREATE TABLE universidade.oferta_pos(
	ano DATE,
	semestre VARCHAR(20),
	cod_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	cpf_professor VARCHAR(20) NOT null,
	CONSTRAINT pk_oferta_pos_ano_semestre_cod_pos_cod_curso_pos PRIMARY KEY(ano,semestre,cod_pos,cod_curso_pos),
	CONSTRAINT fk_oferta_pos_disc_curso_pos_cod_pos_cod_curso_pos FOREIGN KEY(cod_pos,cod_curso_pos)
		REFERENCES universidade.disc_curso_pos(cod_pos,cod_curso_pos) ON DELETE CASCADE,
	CONSTRAINT fk_oferta_pos_pessoa_professor_cpf_professor FOREign key(cpf_professor)
		REFERENCES universidade.pessoa_professor(cpf_professor) ON DELETE CASCADE
);

CREATE TABLE universidade.oferta_grad(
	ano DATE,
	semestre VARCHAR(20),
	cod_grad VARCHAR(20),
	cod_curso_grad VARCHAR(20),
	id_professor_grad VARCHAR (20) NOT null,
	CONSTRAINT pk_oferta_grad_ano_semestre_cod_grad_cod_curso_grad PRIMARY KEY(ano,semestre,cod_grad,cod_curso_grad),
	CONSTRAINT fk_oferta_grad_disc_curso_grad_cod_grad_cod_curso_grad FOREIGN KEY(cod_grad,cod_curso_grad)
		REFERENCES universidade.disc_curso_grad(cod_grad,cod_curso_grad) ON DELETE CASCADE,
	CONSTRAINT fk_oferta_grad_professor_grad_id_professor_grad FOREign key(id_professor_grad)
		REFERENCES universidade.professor_grad(id_professor_grad) ON DELETE CASCADE
);

CREATE TABLE universidade.cursa(
	oferta_ano_pos DATE,
	oferta_semestre_pos VARCHAR(20),
	cod_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	cpf_aluno_pos VARCHAR(20),
	media_final NUMERIC(4,2),
	status VARCHAR(50),
	CONSTRAINT pk_cursa_oferta_ano_pos_oferta_semestre_pos_cod_pos_cod_curso_pos_cpf_aluno_pos PRIMARY KEY(oferta_ano_pos,oferta_semestre_pos,cod_pos,cod_curso_pos,cpf_aluno_pos),
	CONSTRAINT fk_cursa_oferta_pos_ano_semestre_cod_pos_cod_curso_pos FOREIGN KEY(oferta_ano_pos,oferta_semestre_pos,cod_pos,cod_curso_pos)
		REFERENCES universidade.oferta_pos(ano,semestre,cod_pos,cod_curso_pos) ON DELETE CASCADE,
	CONSTRAINT fk_cursa_alunos_pos_cpf_alunos_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.avaliacao(
	num int,
	data_ DATE,
	descricao VARCHAR(20),
	regular_exame VARCHAR(20),
	ano_pos DATE,
	semestre_pos VARCHAR(20),
	cod_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	CONSTRAINT pk_avaliacao_num_ano_pos_semestre_pos_cod_pos_cod_curso_pos PRIMARY KEY(num,ano_pos,semestre_pos,cod_pos,cod_curso_pos),
	CONSTRAINT fk_avaliacao_oferta_pos_ano_semestre_cod_pos_cod_curso_pos FOREIGN KEY(ano_pos,semestre_pos,cod_pos,cod_curso_pos)
		REFERENCES universidade.oferta_pos(ano,semestre,cod_pos,cod_curso_pos) ON DELETE CASCADE
);

CREATE TABLE universidade.faz(
	avaliacao_num int,
	ano_pos date,
	semestre_pos VARCHAR(20),
	cod_pos VARCHAR(20),
	cod_curso_pos VARCHAR(20),
	cpf_aluno_pos VARCHAR(20),
	nota NUMERIC(4,2),
	CONSTRAINT pk_faz_avaliacao_num_ano_pos_semestre_pos_cod_pos_cod_curso_pos_cpf_aluno_pos PRIMARY KEY(avaliacao_num,ano_pos,semestre_pos,cod_pos,cod_curso_pos,cpf_aluno_pos),
	CONSTRAINT fk_faz_avaliacao_num_ano_pos_semestre_pos_cod_pos_cod_curso_pos FOREIGN KEY(avaliacao_num,ano_pos,semestre_pos,cod_pos,cod_curso_pos)
		REFERENCES universidade.avaliacao(num,ano_pos,semestre_pos,cod_pos,cod_curso_pos) ON DELETE CASCADE,
	CONSTRAINT fk_faz_aluno_pos_cpf_aluno_pos FOREIGN KEY(cpf_aluno_pos)
		REFERENCES universidade.aluno_pos(cpf_aluno_pos) ON DELETE CASCADE
);
