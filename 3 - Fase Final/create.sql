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


------- trigger -----------
SELECT destino.cnpj, destino.cidade, destino.valor, viagem.nro_passageiros INTO aux FROM destino
  LEFT JOIN viagem ON (destino.cidade = viagem.cidade);

SELECT empresa.cnpj, empresa.nome, aux.cnpj, aux.cidade, aux.valor, aux.nro_passageiros FROM empresa
  LEFT JOIN aux ON (empresa.cnpj = aux.cnpj);


UPDATE empresa INNER JOIN B ON A.FK_TABELA_B = B.ID
         INNER JOIN C ON B.FK_TABELA_C = C.ID
         INNER JOIN (SELECT FK_TABELA_C, MAX( ID ) AS idMax
                     FROM B
                     GROUP BY FK_TABELA_C)
                    T ON C.ID = T.FK_TABELA_C
SET A.FK_TABELA_B = T.idMax;

UPDATE empresa
SET receita = 1200
FROM destino d
WHERE d.cidade = 'Guarulhos' and empresa.cnpj = d.cnpj

UPDATE empresa
SET receita = 120
FROM empresa e , destino d
WHERE d.cidade = 'Guarulhos'-- and e.cnpj = d.cnpj

SELECT cnpj FROM destino WHERE cidade = 'Guarulhos'

SELECT * from empresa

SELECT * FROM empresa e INNER JOIN destino d
ON (e.cnpj = d.cnpj)
WHERE d.cidade = 'Samambaia'

SELECT * FROM destino where cidade = 'Samambaia';

SELECT * FROM destino where cidade = 'Guarulhos';

"54.705.902/0001-52"


CREATE OR REPLACE FUNCTION atualiza_receita() RETURNS trigger AS $atualiza_receita$
declare
	cnt integer;
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			UPDATE empresa
			SET receita = receita + (new.nro_passageiros * d.valor)
			FROM destino d
			WHERE d.cidade = new.cidade and empresa.cnpj = d.cnpj;
		END IF;
		IF (TG_OP = 'DELETE') THEN
			UPDATE empresa
			SET receita = receita - (old.nro_passageiros * d.valor)
			FROM destino d
			WHERE d.cidade = old.cidade and empresa.cnpj = d.cnpj;
		END IF;
		IF (TG_OP = 'UPDATE') THEN

			IF (SELECT 1 FROM destino WHERE cidade = NEW.cidade and destino.cnpj = (SELECT cnpj FROM  destino WHERE  destino.cidade = OLD.cidade)) then

			-- SELECT 1 FROM destino WHERE cidade = new.cidade and destino.cnpj IN (SELECT empresa.cnpj FROM destino, empresa WHERE empresa.cnpj = destino.cnpj AND destino.cidade = old.cidade)) THEN
				UPDATE empresa
				SET receita = receita + (new.nro_passageiros * d.valor) - (old.nro_passageiros * d2.valor)
				FROM destino d, destino d2
				WHERE d.cidade = new.cidade and d2.cidade = old.cidade and empresa.cnpj = d.cnpj;
			END IF;
		END IF;
		RETURN NEW;
	END;
$atualiza_receita$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_receita AFTER INSERT OR DELETE OR UPDATE ON viagem
FOR EACH ROW EXECUTE PROCEDURE atualiza_receita();


SELECT 1 FROM destino WHERE cidade = 'Ceilandia' and destino.cnpj 
= (SELECT cnpj FROM  destino WHERE  destino.cidade = 'Guarulhos')



drop TRIGGER atualiza_receita2 ON viagem;

INSERT INTO viagem VALUES ('2017-10-22', '9:0:00','ZVV-2015','Guarulhos', 1);

UPDATE viagem SET cidade = 'Samambaia' WHERE data = '2017-10-22' AND placa = 'ZVV-2015';

DELETE from viagem WHERE data = '2017-10-22' AND placa = 'ZVV-2015';

SELECT * from viagem WHERE data = '2017-10-22' AND placa = 'ZVV-2015';

SELECT cpf, funcionario.nome FROM funcionario, empresa
WHERE (empresa.nome = 'Empresa A' AND funcionario.cnpj = empresa.cnpj);

SELECT count(*) INTO cnt 
FROM (SELECT 1 FROM destino WHERE cidade = 'Samambaia' and destino.cnpj = (SELECT cnpj FROM  destino WHERE  destino.cidade = 'Guarulhos')) AS aux
