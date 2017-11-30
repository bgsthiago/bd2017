-- -----------------------------------------------------
-- Cria database
-- -----------------------------------------------------
CREATE DATABASE "projetoRodoviario"

-- -----------------------------------------------------
-- Tabela empresa
-- -----------------------------------------------------
CREATE TABLE empresa (
  cnpj        char(18) PRIMARY KEY,
  nome        varchar(60) NOT NULL UNIQUE,
  receita     float NOT NULL,
  pais_sede   varchar(26) NOT NULL
);

-- Cria um tipo <sexo> para restringir as opções de sexo
-- para Masculino (M) ou Feminino (F)
CREATE TYPE sexo AS ENUM ('M', 'F');

-- -----------------------------------------------------
-- Tabela funcionario
-- -----------------------------------------------------
CREATE TABLE funcionario (
  cpf       char(14) PRIMARY KEY,
  nome      varchar(80) NOT NULL,
  sexo      sexo NOT NULL,
  data_nasc date CHECK (data_nasc < '01-01-2001') NOT NULL,
  cnpj      char(18) REFERENCES empresa(cnpj) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Tabela telefone
-- -----------------------------------------------------
CREATE TABLE telefone (
  telefone    varchar(15) NOT NULL,
  cpf         char(14) REFERENCES funcionario(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (cpf, telefone)
);

-- -----------------------------------------------------
-- Tabela destino
-- -----------------------------------------------------
CREATE TABLE destino(
  cidade varchar(60) PRIMARY KEY,
  estado char(2) NOT NULL,
  valor float NOT NULL,
  cnpj char(18) REFERENCES empresa(cnpj) ON DELETE CASCADE ON UPDATE CASCADE
)

-- -----------------------------------------------------
-- Tabela viagem
-- -----------------------------------------------------
CREATE TABLE carro(
  placa varchar(8) PRIMARY KEY,
  ano char(4) NOT NULL,
  fabricante varchar(60) NOT NULL
)

-- -----------------------------------------------------
-- Tabela viagem
-- -----------------------------------------------------
CREATE TABLE viagem(
  data date NOT NULL,
  hora time NOT NULL,
  placa char(8) REFERENCES carro(placa) ON DELETE NO ACTION ON UPDATE CASCADE,
  cidade char(60) REFERENCES destino(cidade) ON DELETE NO ACTION ON UPDATE CASCADE,
  nro_passageiros integer NOT NULL CHECK (nro_passageiros > 0),
  PRIMARY KEY (data, hora, placa, cidade)
)

-- TO DO LIST:
-- AS REFERENCIAS DA TABELA viagem E SUA SUPERCHAVE (quase pronto)
-- ADICIONAR CODIGO DA VIAGEM PARA NÃO TER UMA SUPERCHAVE GIGANTESCA
