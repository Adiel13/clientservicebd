CREATE USER usrlogin PASSWORD 'l0g1n';

GRANT SELECT ON TABLE usuario TO usrlogin;
GRANT SELECT ON TABLE tipo_usuario TO usrlogin;
GRANT SELECT ON TABLE tipo_usuario_permiso TO usrlogin;
GRANT SELECT ON TABLE permiso TO usrlogin;
GRANT EXECUTE ON FUNCTION inicio_sesion(usuario varchar(20), token varchar(32))  to usrlogin;
GRANT INSERT, UPDATE, DELETE, SELECT ON TABLE sesion TO usrlogin;
GRANT INSERT, UPDATE, SELECT ON TABLE bitacora_sesion TO usrlogin;
GRANT EXECUTE ON FUNCTION crear_sesion(usuario varchar(20), sistema_parametro smallint) TO usrlogin;


CREATE USER usrconsulta PASSWORD 'c0nsult4';
GRANT SELECT ON TABLE empleado TO usrconsulta;
GRANT SELECT ON TABLE empresa TO usrconsulta;
GRANT SELECT ON TABLE empleado_empresa TO usrconsulta;
GRANT SELECT ON TABLE usuario TO usrconsulta;
GRANT SELECT ON TABLE tipo_usuario TO usrconsulta;

CREATE USER usrventa PASSWORD 'v3nt4';
GRANT SELECT ON TABLE empleado TO usrventa;
GRANT SELECT ON TABLE empresa TO usrventa;
GRANT SELECT ON TABLE empleado_empresa TO usrventa;
GRANT SELECT ON TABLE usuario TO usrventa;
GRANT SELECT ON TABLE sesion TO usrventa;
GRANT INSERT, UPDATE, DELETE, SELECT ON TABLE venta TO usrventa;
GRANT INSERT, UPDATE, SELECT ON TABLE bitacora_venta TO usrventa;
GRANT INSERT, UPDATE, SELECT, DELETE ON TABLE venta_satisfactoria TO usrventa;
GRANT INSERT, UPDATE, SELECT, DELETE ON TABLE venta_no_satisfactoria TO usrventa;
GRANT EXECUTE ON FUNCTION crear_venta(token_sesion varchar(200), sistemaparametro smallint) TO usrventa;
GRANT EXECUTE ON FUNCTION obtener_empresa(token_sesion varchar(200), sistema_parametro smallint) TO usrventa;
GRANT EXECUTE ON FUNCTION obtenerUsuario(token_sesion varchar(200), sistema_parametro smallint) TO usrventa;
GRANT ALL ON id_venta TO usrventa;
GRANT EXECUTE ON  FUNCTION finalizar_venta(ventaparam smallint) TO usrventa;