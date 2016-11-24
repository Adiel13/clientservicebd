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
		numero_filas smallint;
		activo smallint;
	BEGIN
		SELECT count(*) INTO numero_filas FROM  sesion s 
			WHERE	
				s.id_empleado = usuario AND
				s.token = token_sesion AND
				s.sistema = sistema_parametro;
				
		IF numero_filas = 1 THEN 
			activo = 1;
		ELSE 
			activo = 0;
		END IF;
	RETURN activo;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cerrar_sesion (usuario varchar(200), token_sesion varchar(200), sistema_parametro smallint)
RETURNS SMALLINT AS $$
	DECLARE
		valido smallint;
		numero_filas smallint;
	BEGIN
		SELECT count(*) INTO numero_filas FROM  sesion s 
			WHERE	
				s.id_empleado = usuario AND
				s.token = token_sesion AND
				s.sistema = sistema_parametro;
				
		IF numero_filas = 1 THEN 
			DELETE FROM sesion 
				WHERE 
					sesion.id_empleado = usuario AND
					sesion.token = token_sesion AND
					sesion.sistema = sistema_parametro;
			UPDATE bitacora_sesion SET fecha_fin = now() WHERE
				bitacora_sesion.token = token_sesion;
			valido = 1;
		ELSE 
			valido = 0;
		END IF;			
	RETURN valido;
END;$$ LANGUAGE plpgsql;