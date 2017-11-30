-- -----------------------------------------------------
-- a) recurar o nome e cnpjde todas empresas inativas
-- -----------------------------------------------------
SELECT cnpj, nome FROM empresa
  WHERE cnpj NOT IN (SELECT cnpj FROM funcionario);

-- -----------------------------------------------------
-- b) recuperar nome e cpnj de todas as empresas estrangeiras
-- -----------------------------------------------------
SELECT cnpj, nome FROM empresa
  WHERE pais_sede != 'Brasil'

-- -----------------------------------------------------
-- c) recuperar nome e cpnj de empresas ordenando decrescentemente pela sua quantidade de funcionarios.
-- -----------------------------------------------------
SELECT empresa.cnpj, empresa.nome, COUNT(funcionario.cnpj) AS "numero_de_funcinarios"
FROM empresa
  LEFT JOIN funcionario ON funcionario.cnpj = empresa.cnpj
GROUP BY empresa.cnpj ORDER BY "numero_de_funcinarios" desc;

-- -----------------------------------------------------
-- d) calcular a receita de cada empresa através do custo x número de passageiros
-- -----------------------------------------------------


-- -----------------------------------------------------
-- e) recuperar a lista com todos funcionarios de uma empreas
-- -----------------------------------------------------
SELECT cpf, nome FROM funcionario
  WHERE cnpj = <cnpj>

-- -----------------------------------------------------
-- f) recuperar a lista com todos funcionarios de uma empreas
-- -----------------------------------------------------
SELECT placa FROM viagem
  WHERE cidade = <cidade> AND data = <data> AND hora = <hora>

-- -----------------------------------------------------
-- g) relatório de número de destinos de uma certa empresa
-- -----------------------------------------------------
SELECT empresa.nome, COUNT(destino.cnpj) AS "numero_de_destinos"
  FROM empresa
    LEFT JOIN destino ON destino.cnpj = empresa.cnpj
  GROUP BY empresa.cnpj ORDER BY "numero_de_destinos" desc;
