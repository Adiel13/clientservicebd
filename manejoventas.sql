CREATE OR REPLACE FUNCTION crear_venta(token_sesion varchar(200), sistemaparametro smallint)
RETURNS VARCHAR(20) AS $$
	DECLARE 
		idventa smallint;
		vendedor varchar(20);
        empresa varchar(20);
	BEGIN
        SELECT obtenerusuario(token_sesion, sistemaparametro::smallint) AS usuario INTO vendedor;
        SELECT obtener_empresa(token_sesion, sistemaparametro::smallint) AS empresares INTO empresa;
        
        IF vendedor IS NOT NULL THEN
            SELECT nextval('id_venta') INTO idventa;    
            INSERT INTO venta (id_venta, id_empleado, id_empresa, inicio_venta, estado_venta) VALUES(idventa, vendedor, empresa, now(), 1);
        ELSE 
            idventa = -1;
        END IF;
	RETURN idventa;
END;$$ LANGUAGE plpgsql;