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