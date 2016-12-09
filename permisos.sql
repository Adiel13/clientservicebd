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