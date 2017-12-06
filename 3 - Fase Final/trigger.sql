CREATE OR REPLACE FUNCTION atualiza_receita() RETURNS trigger AS $atualiza_receita$
$BODY$DECLARE
	BEGIN
		IF (TG_OP = 'INSERT') THEN
			UPDATE empresa
      SET receita =  final.receita + (destino.valor * viagem.nro_passageiros)
      WHERE empresa.cnpj = destino.cnpj;
		END IF;
		RETURN NEW;
	END;
$atualiza_receita$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_receita AFTER INSERT ON viagem
	FOR EACH ROW EXECUTE PROCEDURE atualiza_receita();


-- DROP FUNCTION stackoverflow."calcReceita"();

CREATE OR REPLACE FUNCTION stackoverflow."calcReceita"(p_cnpj CHARACTER)
  RETURNS real AS
$BODY$DECLARE
     v_receita stackoverflow.empresa.receita%TYPE;

    BEGIN
        /**
            SELECT SUM(d.valor) INTO v_receita
            FROM stackoverflow.destino d
            WHERE cnpj = p_cnpj
            GROUP BY d.cnpj;
        */
            SELECT SUM(receita_produto) INTO v_receita
            FROM  (
                SELECT (d.valor * v.nro_passageiro) AS "receita_produto"
                FROM stackoverflow.destino d
                INNER JOIN stackoverflow.viagem v USING (cidade)
                WHERE cnpj = p_cnpj
            ) AS tb_soma_receita;

        UPDATE stackoverflow.empresa
        SET receita=v_receita
        WHERE cnpj=p_cnpj;

     RETURN v_receita;
    END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION stackoverflow."calcReceita"()
  OWNER TO postgres;

/** Aqui chama a procedure. */
SELECT stackoverflow."calcReceita"('00881753000153');
