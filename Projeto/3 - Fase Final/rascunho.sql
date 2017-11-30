SELECT cnpj, nome FROM empresa
  WHERE pais_sede != 'Brasil'

UPDATE empresa SET nome = 'Empresa Y' where cnpj = '54.705.902/0001-52'

SELECT cpf, nome FROM funcionario
  WHERE cnpj = '18.900.311/0001-72'

SELECT placa FROM viagem
  WHERE cidade = 'Samambaia' AND data = '2015-01-06' AND hora = '12:45:00'


SELECT cnpj, nome FROM empresa
  WHERE cnpj NOT IN (SELECT cnpj FROM funcionario);

SELECT cnpj FROM funcionarios


INSERT INTO empresa VALUES (2, 'TESTE', 0, 'br')

SELECT e.cnpj, COUNT(f.cnpj) FROM funcionario f, empresa e WHERE f.cnpj = e.cnpj GROUP BY e.cnpj;

SELECT cnpj, nome FROM empresa e, funcionario f
  WHERE (e.cnpj, f.cnpj)  NOT IN (SELECT e.cnpj, COUNT(f.cnpj) FROM funcionario f, empresa e WHERE f.cnpj = e.cnpj GROUP BY e.cnpj);


SELECT empresa.cnpj, empresa.nome, COUNT(funcionario.cnpj) AS "numero_de_funcinarios"
FROM empresa
  LEFT JOIN funcionario ON funcionario.cnpj = empresa.cnpj
GROUP BY empresa.cnpj ORDER BY "numero_de_funcinarios" desc;

SELECT empresa.nome, COUNT(destino.cnpj) AS "numero_de_destinos"
  FROM empresa
    LEFT JOIN destino ON destino.cnpj = empresa.cnpj
  GROUP BY empresa.cnpj ORDER BY "numero_de_destinos" desc;
