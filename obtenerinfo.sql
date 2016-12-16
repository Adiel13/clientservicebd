CREATE OR REPLACE FUNCTION obtenerUsuario(token_sesion varchar(200), sistema_parametro smallint)
RETURNS VARCHAR(20) AS $$
	DECLARE 
		numero_filas smallint;
		usuariosesion varchar(20);
	BEGIN
		SELECT count(*) INTO numero_filas FROM  sesion s 
			WHERE	
				s.token = token_sesion AND
				s.sistema = sistema_parametro;
				
		IF numero_filas = 1 THEN 
            SELECT s.id_empleado INTO usuariosesion FROM  sesion s 
			 WHERE	
				s.token = token_sesion AND
				s.sistema = sistema_parametro;
		ELSE 
			usuariosesion = NULL;
		END IF;
	RETURN usuariosesion;
END;$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtener_empresa(token_sesion varchar(200), sistema_parametro smallint)
RETURNS VARCHAR(20) AS $$
	DECLARE 
		empresa varchar(20);
	BEGIN
		SELECT e.id_sucursal INTO empresa FROM usuario u INNER JOIN empleado_empresa e ON 
	           u.id_empleado = e.id_empleado
	       INNER JOIN sesion s  ON
    	       s.id_empleado = u.id_empleado
        WHERE
	        s.token = token_sesion AND 
            s.sistema = sistema_parametro;				
	RETURN empresa;
END;$$ LANGUAGE plpgsql;

