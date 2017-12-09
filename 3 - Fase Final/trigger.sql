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
				UPDATE empresa
				SET receita = receita + (new.nro_passageiros * d.valor) - (old.nro_passageiros * d2.valor)
				FROM destino d, destino d2
				WHERE d.cidade = new.cidade and d2.cidade = old.cidade and empresa.cnpj = d.cnpj;
			else
				raise exception 'A nova cidade não é realizada pela empresa que realiza essa rota.'; END IF;
			END IF;
		RETURN NEW;
	END;
$atualiza_receita$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_receita AFTER INSERT OR DELETE OR UPDATE ON viagem
FOR EACH ROW EXECUTE PROCEDURE atualiza_receita();
