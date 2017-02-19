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
            INSERT INTO venta (id_venta, id_empleado, id_sucursal, inicio_venta, estado_venta) VALUES(idventa, vendedor, empresa, now(), 1);
            INSERT INTO bitacora_venta (id_venta, id_empleado, id_empresa, inicio_venta, estado_venta) VALUES(idventa, vendedor, empresa, now(), 1);
        ELSE 
            idventa = -1;
        END IF;
	RETURN idventa;
END;$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION finalizar_venta(ventaparam smallint)
RETURNS VARCHAR(20) AS $$
	DECLARE 
        numero_filas smallint;
	BEGIN
        SELECT count(*) INTO numero_filas FROM venta WHERE id_venta = ventaparam;
        IF numero_filas = 1 THEN
            UPDATE venta SET fin_venta = now(), estado_venta = 2 WHERE id_venta = ventaparam;
            UPDATE bitacora_venta SET fin_venta = now(), estado_venta = 2 WHERE id_venta = ventaparam;
        END IF;
	RETURN numero_filas;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION agregar_venta_satisfactoria(ventaparam smallint, monto float, cantidad smallint, producto varchar(100), descripcion varchar(100))
RETURNS SMALLINT AS $$
    DECLARE
        estado SMALLINT;
        numero_filas SMALLINT;
    BEGIN
        estado = -1;
        SELECT count(*) INTO numero_filas FROM venta WHERE id_venta = ventaparam;
            IF numero_filas = 1 THEN
                INSERT INTO venta_satisfactoria VALUES(ventaparam, monto, cantidad, producto, descripcion);
                UPDATE venta SET estado_venta = 3 WHERE id_venta = ventaparam;
                UPDATE bitacora_venta SET estado_venta = 2 WHERE id_venta = ventaparam;            
                estado = 1;
        END IF; 
        RETURN estado;
END; $$ LANGUAGE plpgsql;