/* =========================================================================== */
/* Produto:                                                                    */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "produto" e dos demais objetos      */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE produto (
                id_produto              VARCHAR2(10)           CONSTRAINT nn_func_id       NOT NULL,
                subclasse               VARCHAR2(150)          CONSTRAINT nn_prod_sub      NOT NULL,
                id_comercial            VARCHAR2(150)          CONSTRAINT nn_func_id_com   NOT NULL,
                nome_generico           VARCHAR2(150)          CONSTRAINT nn_prod_n_g      NOT NULL,
                nome_ordem_producao     VARCHAR2(150)          CONSTRAINT nn_prod_n_o_prod NOT NULL,
                nome_comercial          VARCHAR2(150)          CONSTRAINT nn_prod_n_com    NOT NULL,
                sigla                   VARCHAR2(2)            CONSTRAINT nn_prod_sigla    NOT NULL,
                controla_fator_calorico NUMBER(1)    DEFAULT 0 CONSTRAINT nn_prod_c_f_cal  NOT NULL,
                controla_osmolaridade   NUMBER(1)    DEFAULT 0 CONSTRAINT nn_prod_c_osmol  NOT NULL,
                osmolaridade            NUMBER(5,3)            CONSTRAINT nn_prod_osmol    NOT NULL,
                fator_calorico          NUMBER(5,3)            CONSTRAINT nn_prod_f_cal    NOT NULL
);

-- Primary key da tabela "produto":
ALTER TABLE produto ADD CONSTRAINT produto_pk
PRIMARY KEY (id_produto);

-- Constraints adicionais da tabela "funcionario":
ALTER TABLE produto ADD CONSTRAINT ck_prod_sigla
CHECK (sigla IN ('mL', 'mg', 'g', 'L'));

-- Comentários da tabela "produto":
COMMENT ON COLUMN produto.subclasse IS 'Subclasse do produto.';
COMMENT ON COLUMN produto.id_comercial IS 'Identificação comercial do produto.';
COMMENT ON COLUMN produto.nome_generico IS 'Nome genérico do produto.';
COMMENT ON COLUMN produto.nome_ordem_producao IS 'Nome para ordem de produção do produto.';
COMMENT ON COLUMN produto.nome_comercial IS 'Nome comercial do produto.';
COMMENT ON COLUMN produto.sigla IS 'Sigla da unidade (Exemplo: mg).';
COMMENT ON COLUMN produto.controla_fator_calorico IS 'Se possui um fator calórico. Deve ser 0 para não, 1 para sim.';
COMMENT ON COLUMN produto.controla_osmolaridade IS 'Se possui um osmolaridade. Deve ser 0 para não, 1 para sim.';
COMMENT ON COLUMN produto.osmolaridade IS 'Osmolaridade padrão do produto.';
COMMENT ON COLUMN produto.fator_calorico IS 'Caloria padrão do produto.';


/* =========================================================================== */
/* Funcionário:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "funcionario" e dos demais objetos  */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE funcionario (
                id_funcionario  NUMBER(10)             CONSTRAINT nn_func_id     NOT NULL,
                cpf             VARCHAR2(11)           CONSTRAINT nn_func_cpf    NOT NULL,
                nome_primeiro   VARCHAR2(30)           CONSTRAINT nn_func_nome_p NOT NULL,
                nome_meio       VARCHAR2(30)           CONSTRAINT nn_func_nome_m NOT NULL,
                nome_ultimo     VARCHAR2(30)           CONSTRAINT nn_func_nome_u NOT NULL,
                data_nascimento DATE                   CONSTRAINT nn_func_dt_nas NOT NULL,
                medico          NUMBER(1)    DEFAULT 0 CONSTRAINT nn_func_med    NOT NULL,
                administrador   NUMBER(1)    DEFAULT 0 CONSTRAINT nn_func_adm    NOT NULL
);

-- Primary key da tabela "funcionario":
ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk
PRIMARY KEY (id_funcionario);

-- Constraints adicionais da tabela "funcionario":
ALTER TABLE funcionario ADD CONSTRAINT ck_func_med
CHECK (medico IN (0, 1));

ALTER TABLE funcionario ADD CONSTRAINT ck_func_adm
CHECK (administrador IN (0, 1));

-- Comentários da tabela "funcionario":
COMMENT ON TABLE funcionario IS 'armazena dados getais do funcionario';
COMMENT ON COLUMN funcionario.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN funcionario.cpf IS 'CPF do funcionário. Somente números.';
COMMENT ON COLUMN funcionario.nome_primeiro IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN funcionario.nome_meio IS 'Nome do meio do funcionário.';
COMMENT ON COLUMN funcionario.nome_ultimo IS 'Último nome do funcionário.';
COMMENT ON COLUMN funcionario.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN funcionario.medico IS 'Identifica se o funcionário é um médico. (0 para não, 1 para sim).';
COMMENT ON COLUMN funcionario.administrador IS '0 para não administrador
1 para administrador';


/* =========================================================================== */
/* Usuários:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "usuarios" e dos demais objetos     */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE usuarios (
                username             VARCHAR2             CONSTRAINT nn_usuar_user      NOT NULL,
                id_funcionario       NUMBER(10)           CONSTRAINT nn_usuar_id        NOT NULL,
                permissao_prescrever NUMBER(1)  DEFAULT 0 CONSTRAINT nn_usuar_perm_pres NOT NULL,
                permissao_alterar    NUMBER(1)  DEFAULT 0 CONSTRAINT nn_usuar_perm_alt  NOT NULL,
                senha                VARCHAR2(8)          CONSTRAINT nn_usuar_senha     NOT NULL
);

-- Primary key da tabela "usuarios":
ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk
PRIMARY KEY (username);

-- Constraints adicionais da tabela "funcionario":
ALTER TABLE usuarios ADD CONSTRAINT ck_usuar_perm_pres
CHECK (permissao_prescrever IN (0, 1));

ALTER TABLE usuarios ADD CONSTRAINT ck_usuar_perm_alt
CHECK (permissao_alterar IN (0, 1));

-- Comentários da tabela "usuarios":
COMMENT ON COLUMN usuarios.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN usuarios.permissao_prescrever IS 'Permissão para prescrever. (0 para não, 1 para sim).';
COMMENT ON COLUMN usuarios.permissao_alterar IS '0 padrao para não alterar
1 para alterar';
COMMENT ON COLUMN usuarios.senha IS 'Senha do usuário.';


/* =========================================================================== */
/* Pode alterar:                                                               */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "pode_alterar" e dos demais objetos */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE pode_alterar (
                id_alteracao   VARCHAR2(10) CONSTRAINT nn_pode_al_id_a  NOT NULL,
                id_funcionario NUMBER(10)   CONSTRAINT nn_pode_al_id_f  NOT NULL,
                data_alteracao DATE         CONSTRAINT nn_pode_al_dt_al NOT NULL
);

-- Primary key da tabela "usuarios":
ALTER TABLE pode_alterar ADD CONSTRAINT pode_alterar_pk
PRIMARY KEY (id_alteracao, id_funcionario);

-- Comentários da tabela "pode_alterar":
COMMENT ON COLUMN pode_alterar.id_alteracao IS 'PK que identifica uma alteração.';
COMMENT ON COLUMN pode_alterar.id_funcionario IS 'Esse id serve para identificar o funcionario';


/* =========================================================================== */
/* Médico:                                                                     */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "medico" e dos demais objetos */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE medico (
                id_funcionario NUMBER(10)    nn_hop_  NOT NULL,
                crm            VARCHAR2(12)  nn_med_crm NOT NULL,
                especialidade  VARCHAR2(100) nn_med_crm NOT NULL
);

-- Primary key da tabela "usuarios":
ALTER TABLE medico ADD CONSTRAINT medico_pk
PRIMARY KEY (id_funcionario, crm);

-- Comentários da tabela "medico":
COMMENT ON COLUMN medico.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN medico.crm IS 'CRM do médico. 10 dígitos e 2 letras do Estado.';
COMMENT ON COLUMN medico.especialidade IS 'Especialidade do médico.';


/* =========================================================================== */
/* Hospital:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "hospital" e dos demais objetos     */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE hospital (
                id_hospital   NUMBER(10)    CONSTRAINT nn_hosp_id      NOT NULL,
                CNPJ          VARCHAR2(14)  CONSTRAINT nn_hosp_cnpj    NOT NULL,
                numero_imovel VARCHAR2      CONSTRAINT nn_hosp_num_imo NOT NULL,
                razao_social  VARCHAR2(200) CONSTRAINT nn_hosp_raz_soc NOT NULL,
                cidade        VARCHAR2(100) CONSTRAINT nn_hosp_cid     NOT NULL,
                rua           VARCHAR2(100) CONSTRAINT nn_hosp_rua     NOT NULL,
                numero        VARCHAR2(5)   CONSTRAINT nn_hosp_num     NOT NULL,
                estado        VARCHAR2(2)   CONSTRAINT nn_hosp_est     NOT NULL,
                cep           VARCHAR2(8)   CONSTRAINT nn_hosp_cep     NOT NULL
);

-- Primary key da tabela "hospital":
ALTER TABLE hospital ADD CONSTRAINT hospital_pk
PRIMARY KEY (id_hospital);

-- Comentários da tabela "hospital":
COMMENT ON COLUMN hospital.id_hospital IS 'id para identificar hospital';
COMMENT ON COLUMN hospital.CNPJ IS 'CPNJ do hospital. Somente números.';
COMMENT ON COLUMN hospital.razao_social IS 'Razão social do hospital.';
COMMENT ON COLUMN hospital.rua IS 'Nome da da rua.';
COMMENT ON COLUMN hospital.numero IS 'Número da instituição.';
COMMENT ON COLUMN hospital.cidade_1 IS 'Cidade onde está localizado o hospital.';
COMMENT ON COLUMN hospital.estado IS 'Estado onde está localizado o hospital. (Sigla)';
COMMENT ON COLUMN hospital.cep IS 'CEP do hospital. Apenas os números.';


/* =========================================================================== */
/* Paciente:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "Paciente" e dos demais objetos     */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE paciente (
                id_paciente   NUMBER(10)   NOT NULL,
                id_hospital   NUMBER(10)   NOT NULL,
                nome_primeiro VARCHAR2(30) NOT NULL,
                nome_meio     VARCHAR2(30) NOT NULL,
                nome_ultimo   VARCHAR2(30) NOT NULL,
                nascimento    DATE         NOT NULL,
                peso          NUMBER(5,2)  NOT NULL,
                leito         VARCHAR2(10) NOT NULL,
                secao         VARCHAR2(10) NOT NULL
);

-- Primary key da tabela "paciente":
ALTER TABLE paciente ADD CONSTRAINT paciente_pk
PRIMARY KEY (id_paciente);

-- Comentários da tabela "paciente":
COMMENT ON COLUMN Paciente.id_paciente IS 'PK que identifica o paciente.';
COMMENT ON COLUMN Paciente.id_hospital IS 'id para identificar hospital';
COMMENT ON COLUMN Paciente.nome_primeiro IS 'Primeiro nome do paciente.';
COMMENT ON COLUMN Paciente.nome_meio IS 'Nome do meio do paciente.';
COMMENT ON COLUMN Paciente.nome_ultimo IS 'Último nome do paciente';
COMMENT ON COLUMN Paciente.nascimento IS 'Data de nascimento do paciente.';
COMMENT ON COLUMN Paciente.peso IS 'Peso do paciente em quiilogramas.';
COMMENT ON COLUMN Paciente.leito IS 'Leito do hospital que o paciente se encontra.';
COMMENT ON COLUMN Paciente.secao IS 'Seção do hospital que o paciente se encontra.';


/* =========================================================================== */
/* Prescrição:                                                                 */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "prescricao" e dos demais objetos   */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE prescricao (
                id_prescricao         NUMBER(10)    NOT NULL,
                id_funcionario        NUMBER(10)    NOT NULL,
                crm                   VARCHAR2(12)  NOT NULL,
                id_paciente           NUMBER(10)    NOT NULL,
                observacao            VARCHAR2(500) NOT NULL,
                data_prescricao       DATE          NOT NULL,
                tipo_dieta            VARCHAR2(100) NOT NULL,
                volume_calorico_total NUMBER(5,3)   NOT NULL,
                volume_total_produtos NUMBER(6,3)   NOT NULL
);

-- Primary key da tabela "prescricao":
ALTER TABLE prescricao ADD CONSTRAINT prescricao_pk
PRIMARY KEY (id_prescricao);

-- Comentários da tabela "prescricao":
COMMENT ON COLUMN prescricao.id_prescricao IS 'id para identificar a prescrição';
COMMENT ON COLUMN prescricao.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN prescricao.crm IS 'CRM do médico. 10 dígitos e 2 letras do Estado.';
COMMENT ON COLUMN prescricao.id_paciente IS 'id que identifica o paciente';
COMMENT ON COLUMN prescricao.observacao IS 'observação do medico';
COMMENT ON COLUMN prescricao.tipo_dieta IS 'dieta do paciente';
COMMENT ON COLUMN prescricao.volume_calorico_total IS 'Volume total das calorias dos produtos, em quilocalorias.';
COMMENT ON COLUMN prescricao.volume_total_produtos IS 'Volume total de produtos em mililitros.';


/* =========================================================================== */
/* Histórico:                                                                  */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "historico" e dos demais objetos   */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* =========================================================================== */

CREATE TABLE historico (
                id_historico   NUMBER(10)   NOT NULL,
                id_alteracao   VARCHAR2(10) NOT NULL,
                id_funcionario NUMBER(10)   NOT NULL,
                id_prescricao  NUMBER(10)   NOT NULL
);

-- Primary key da tabela "historico":
ALTER TABLE historico ADD CONSTRAINT historico_pk
PRIMARY KEY (id_historico);

-- Comentários da tabela "historico":
COMMENT ON COLUMN historico.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN historico.id_prescricao IS 'id para identificar a prescrição';


/* =========================================================================== */
/* Produto Solicitado:                                                         */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "produto_solicitado" e dos demais   */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* =========================================================================== */

CREATE TABLE produto_solicitado (
                id_prescricao NUMBER(10)   NOT NULL,
                id_produto    VARCHAR2(10) NOT NULL,
                unidade       VARCHAR2(10) NOT NULL,
                volume        NUMBER(6,3)  NOT NULL
);

-- Primary key da tabela "produto_solicitado":
ALTER TABLE produto_solicitado ADD CONSTRAINT produto_solicitado_pk
PRIMARY KEY (id_prescricao, id_produto);

-- Comentários da tabela "produto_solicitado":
COMMENT ON COLUMN produto_solicitado.id_prescricao IS 'id para identificar a prescrição';
COMMENT ON COLUMN produto_solicitado.unidade IS 'Unidade usada do produto (Exemplo: miligrama).';
COMMENT ON COLUMN produto_solicitado.volume IS 'Volume';


/* =========================================================================== */
/* Trabalha em:                                                                */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "trabalha_em" e dos demais          */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* =========================================================================== */

CREATE TABLE trabalha_em (
                id_funcionario NUMBER(10) NOT NULL,
                id_hospital    NUMBER(10) NOT NULL
);

-- Primary key da tabela "trabalha_em":
ALTER TABLE trabalha_em ADD CONSTRAINT trabalha_em_pk
PRIMARY KEY (id_funcionario, id_hospital);

-- Comentários da tabela "trabalha_em":
COMMENT ON COLUMN trabalha_em.id_funcionario IS 'Esse id serve para identificar o funcionario';
COMMENT ON COLUMN trabalha_em.id_hospital IS 'id para identificar hospital';


ALTER TABLE produto_solicitado ADD CONSTRAINT PRODUTO_LISTA_PRODUTOS_FK
FOREIGN KEY (id_produto)
REFERENCES produto (id_produto)
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT FUNCIONARIO_TRABALHA_EM_FK
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
NOT DEFERRABLE;

ALTER TABLE medico ADD CONSTRAINT FUNCIONARIO_MEDICO_FK
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
NOT DEFERRABLE;

ALTER TABLE pode_alterar ADD CONSTRAINT FUNCIONARIO_PODE_ALTERAR_FK
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
NOT DEFERRABLE;

ALTER TABLE usuarios ADD CONSTRAINT FUNCIONARIO_USUARIOS_FK
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
NOT DEFERRABLE;

ALTER TABLE historico ADD CONSTRAINT PODE_ALTERAR_HISTORICO_FK
FOREIGN KEY (id_alteracao, id_funcionario)
REFERENCES pode_alterar (id_alteracao, id_funcionario)
NOT DEFERRABLE;

ALTER TABLE prescricao ADD CONSTRAINT MEDICO_PRESCRICAO_FK
FOREIGN KEY (id_funcionario, crm)
REFERENCES medico (id_funcionario, crm)
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT HOSPITAL_TRABALHA_EM_FK
FOREIGN KEY (id_hospital)
REFERENCES hospital (id_hospital)
NOT DEFERRABLE;

ALTER TABLE Paciente ADD CONSTRAINT HOSPITAL_PACIENTE_FK
FOREIGN KEY (id_hospital)
REFERENCES hospital (id_hospital)
NOT DEFERRABLE;

ALTER TABLE prescricao ADD CONSTRAINT PACIENTE_PRESCRICAO_FK
FOREIGN KEY (id_paciente)
REFERENCES Paciente (id_paciente)
NOT DEFERRABLE;

ALTER TABLE produto_solicitado ADD CONSTRAINT PRESCRICAO_LISTA_PRODUTOS_FK
FOREIGN KEY (id_prescricao)
REFERENCES prescricao (id_prescricao)
NOT DEFERRABLE;

ALTER TABLE historico ADD CONSTRAINT PRESCRICAO_HISTORICO_FK
FOREIGN KEY (id_prescricao)
REFERENCES prescricao (id_prescricao)
NOT DEFERRABLE;