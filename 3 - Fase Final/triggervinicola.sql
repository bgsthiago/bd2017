UPDATE vinicola SET qt_vinhos = (SELECT count(vinho_id) FROM vinho WHERE vinicola.vinicola_id = vinho.vinicola_id); -- consulta correlata!

CREATE OR REPLACE FUNCTION atualiza_qtvinhos() RETURNS trigger AS $atualiza_qtvinhos$
	BEGIN
		IF (TG_OP = 'DELETE') THEN
			UPDATE vinicola
			SET qt_vinhos = qt_vinhos - 1
			WHERE OLD.vinicola_id = vinicola.vinicola_id;
		END IF;
		IF (TG_OP = 'INSERT') THEN
			UPDATE vinicola SET qt_vinhos = qt_vinhos +1
			WHERE NEW.vinicola_id = vinicola.vinicola_id;
		END IF;
		RETURN NEW;
	END;
$atualiza_qtvinhos$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_qtvinhos AFTER INSERT OR DELETE ON vinho
	FOR EACH ROW EXECUTE PROCEDURE atualiza_qtvinhos();
