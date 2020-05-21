CREATE OR REPLACE FUNCTION pmieducar.audita_matricula() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO modules.auditoria_geral VALUES(1, 3, 'TRIGGER_MATRICULA', TO_JSON(OLD.*),NULL,NOW(),OLD.cod_matricula ,nextval('modules.auditoria_geral_id_seq'),current_query());
            RETURN OLD;
        END IF;
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO modules.auditoria_geral VALUES(1, 2, 'TRIGGER_MATRICULA', TO_JSON(OLD.*),TO_JSON(NEW.*),NOW(),NEW.cod_matricula,nextval('modules.auditoria_geral_id_seq'),current_query());
            RETURN NEW;
        END IF;
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO modules.auditoria_geral VALUES(1, 1, 'TRIGGER_MATRICULA', NULL,TO_JSON(NEW.*),NOW(),NEW.cod_matricula,nextval('modules.auditoria_geral_id_seq'),current_query());
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$;
