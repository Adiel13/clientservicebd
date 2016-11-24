CREATE OR REPLACE FUNCTION inicio_sesion(usuario varchar(20), token varchar(32)) 
RETURNS RECORD AS $$
	DECLARE 
    	permiso RECORD;
        numero_filas smallint;
        tipo smallint;
	BEGIN
    	SELECT count(*) INTO numero_filas FROM usuario u
        	WHERE
            	u.id_empleado = usuario and 
                u.contrasenia = token;
                
		IF numero_filas = 1 THEN
        	SELECT u.tipo_usuario INTO tipo FROM usuario u 
            	WHERE             	
                	u.id_empleado = usuario AND 
                	u.contrasenia = token;
                    
			SELECT tu.tipo_permiso, tu.descripcion INTO permiso FROM tipo_usuario_permiso tu
            	WHERE
                	tu.tipo_usuario = tipo;            	
       	ELSE 
        	SELECT -1::smallint as codigo, 'Credenciales incorrectas.'::varchar(200) as descripcion INTO permiso;
		END IF;
        
    RETURN permiso;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_sesion(usuario varchar(20), sistema_parametro smallint) 
RETURNS VARCHAR(200) AS $$
	DECLARE 
		token VARCHAR(200);
		numero_filas smallint;
	BEGIN;
		SELECT count(*) INTO numero_filas FROM sesion c 
			WHERE 
				c.id_empleado = usuario AND 
				c.sistema = sistema_parametro;
				
		IF numero_filas = 1 THEN
			DELETE FROM sesion WHERE id_empleado = usuario;
		END IF;
		
		SELECT md5(usuario || sistema_parametro || now()) INTO token;
		
		INSERT INTO sesion values(usuario, now(), token, NULL, sistema_parametro);
		INSERT INTO bitacora_sesion values(usuario, now(), NULL, sistema_parametro, token );
		COMMIT;
	RETURN token;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_sesion(usuario varchar(200), token_sesion varchar(200), sistema_parametro smallint)
RETURNS SMALLINT AS $$
	DECLARE 
END;$$ LANGUAGE plpgsql;