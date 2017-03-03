CREATE OR REPLACE FUNCTION crear_accion(token_sesion varchar(200), mensaje text, tipo smallint, sistemaparametro smallint, vendedor varchar(20))
RETURNS VARCHAR(20) AS $$
	DECLARE 
		admin varchar(20);
        empresa varchar(20);
        estado smallint;
	BEGIN
        SELECT obtenerusuario(token_sesion, sistemaparametro::smallint) AS usuario INTO admin;
        
        IF admin IS NOT NULL THEN
            INSERT INTO accion_empleado(id_tipo, mensaje, id_empleado, id_gerente) values(tipo, mensaje, vendedor, admin);
            estado = 1;
        ELSE 
            estado = -1;
        END IF;
	RETURN estado;
END;$$ LANGUAGE plpgsql;