

/* =========================================================================== */
/* INSERÇÃO DE DADOS NAS TABELAS DO PROJETO:                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a inserção dos dados nas tabelas do projeto.            */
/* =========================================================================== */

-- Insere dados na tabela "hospital":
Prompt **** Inserindo dados na tabela hospital:
INSERT INTO hospital (cnpj, numero_imovel, razao_social, rua, numero, cidade, estado, cep) VALUES (
  '26442309000176', '22222222', 'HUCAM', 'Flores Arcanjo', '222', 'Vila Velha', 'ES', '27938420'
);
INSERT INTO hospital (cnpj, numero_imovel, razao_social, rua, numero, cidade, estado, cep) VALUES (
  '23242309000176', '333333333', 'São Lucas', 'Praia do Canto', '333', 'Vila Velha', 'ES', '29737420'
);


-- Insere dados na tabela "paciente":
Prompt **** Inserindo dados na tabela paciente:
INSERT INTO paciente (id_hospital, nome_primeiro, nome_meio, nome_ultimo, nascimento, peso, leito, secao ) VALUES (
  '1', 'Pedro', 'Lima', 'Jamaica', '01-jan-2001', 50.36, 'BB101', 'A1'
);

INSERT INTO paciente (id_hospital, nome_primeiro, nome_meio, nome_ultimo, nascimento, peso, leito, secao ) VALUES (
  '2', 'Antônio', 'Fagundes', 'Janela', '20-jul-1999', 50.36, 'ZZ 13', 'X10'
);

-- Insere dados na tabela "funcionario":
Prompt **** Inserindo dados na tabela funcionario:
INSERT INTO funcionario (cpf, nome_primeiro, nome_meio, nome_ultimo, data_nascimento, medico, administrador) VALUES (
  '21111111112', 'Rogério', 'Atolo', 'Forró', '24-nov-1999', 1, 0
);

INSERT INTO funcionario (cpf, nome_primeiro, nome_meio, nome_ultimo, data_nascimento, medico, administrador) VALUES (
  '11111111112', 'Roberto', 'Bastos', 'Souza', '24-nov-2001', 0, 1
);

-- Insere dados na tabela "medico":
Prompt **** Inserindo dados na tabela medico:
INSERT INTO medico (id_funcionario, crm, especialidade) VALUES (
  '1', '0000000000ES', 'Neurologista'
);

-- Insere dados na tabela "trabalha_em":
Prompt **** Inserindo dados na tabela trabalha_em:
INSERT INTO trabalha_em (id_funcionario, id_hospital) VALUES (
  '1', '1'
);
INSERT INTO trabalha_em (id_funcionario, id_hospital) VALUES (
  '2', '1'
);

-- Insere dados na tabela "produto":
Prompt **** Inserindo dados na tabela produto:
INSERT INTO produto (subclasse, id_comercial, nome_generico, nome_ordem_producao, nome_comercial, sigla, controla_fator_calorico, controla_osmolaridade, osmolaridade, fator_calorico ) VALUES (
  'Aminoácidos', 'Aminoplasmal 10% Poliaminoácidos - Frasco 1000 mL - Laboratórios B. Braun', 'Aminoácido 10% Adulto', 'Aminoácido 10% Adulto', 'Aminoplasmal 10% - Laboratórios B. Braun','mL', 1, 1, 0.99, 0.4
);
INSERT INTO produto (subclasse, id_comercial, nome_generico, nome_ordem_producao, nome_comercial, sigla, controla_fator_calorico, controla_osmolaridade, osmolaridade, fator_calorico ) VALUES (
  'Aminoácidos', 'Aminosteril Hepa 8% - Frasco 500 mL - Fresenius', 'Aminoácido Hepatopata 8%', 'Aminoácido Hepatopata 8%- 500 mL', 'Aminosteril Hepa 8% - Fresenius', 'mL', 1, 1, 0.77, 0.32
);