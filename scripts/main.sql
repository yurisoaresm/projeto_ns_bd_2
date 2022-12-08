PROMPT 
PROMPT Insira a senha para o esquema NutriSolution como parâmetro 1:
DEFINE pass     = &1
PROMPT 
PROMPT Insira a senha do seu SYS como parâmetro 2:
DEFINE pass_sys = &2
PROMPT 
PROMPT Insira a string de conexão ao pdb como parâmetro 3 (exemplo: localhost:1521/xepdb1): 
DEFINE connect_string     = &3 
PROMPT


/* ======================================================= */
/* Limpeza geral                                           */
/* ------------------------------------------------------- */
/* Remove o usuário, o esquema e todos os objetos          */
/* relacionados de forma automática antes de executar      */
/* o script.                                               */
/* ======================================================= */

DROP DATABASE nutrisolution CASCADE
DROP USER nutrisolution CASCADE;


/* ======================================================= */
/* Criação do usuário                                      */
/* ======================================================= */

-- Cria o usuário "elmasri" com a senha de entrada:
CREATE USER nutrisolution IDENTIFIED BY &pass
                          DEFAULT TABLESPACE users
                          QUOTA UNLIMITED ON users
                          TEMPORARY TABLESPACE temp
                          ACCOUNT UNLOCK 
                          ENABLE EDITIONS 
;

-- Concede funções/permisões (ROLES) ao usuário criado:
GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO nutrisolution;

GRANT AUTHENTICATEDUSER, CONNECT, CREATE DATABASE LINK, RESOURCE, UNLIMITED TABLESPACE TO nutrisolution;

CONNECT sys/&pass_sys@&connect_string AS SYSDBA;
GRANT execute ON sys.dbms_stats TO nutrisolution;

CONNECT nutrisolution/&pass@&connect_string


/* ======================================================= */
/* Criação da estrutura do banco                           */
/* ------------------------------------------------------- */
/* Cria as tabelas, constraints, indexes, e outros objetos */
/* do esquema elmasri.                                     */
/* ======================================================= */

-- Criação das tabelas e objetos relacionados  (sequences, triggers, ...)
@ns_tables

-- Inserção de dados nas tabelas
@ns_inserts
