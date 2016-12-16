CREATE TABLE empleado(
id_empleado VARCHAR(20) NOT NULL,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(150) NOT NULL,
fecha_nac date NOT NULL,
direccion VARCHAR(200) NOT NULL,
telefono INTEGER NULL,
celular INTEGER NOT NULL,

PRIMARY KEY (id_empleado)
);

CREATE TABLE rubro_empresa(
tipo_rubro SMALLINT NOT NULL,
descripcion VARCHAR(1000) NOT NULL,

PRIMARY KEY(tipo_rubro)
);

CREATE TABLE empresa(
id_empresa VARCHAR(20) NOT NULL,
nombre VARCHAR(200) NOT NULL,
acronimo VARCHAR(50) NULL,
tipo_rubro SMALLINT	NOT NULL,
direccion VARCHAR(200) NOT NULL,
telefono INTEGER NOT NULL,
fax INTEGER NULL,
correo VARCHAR(200) NOT NULL,

PRIMARY KEY(id_empresa),
FOREIGN KEY(tipo_rubro) REFERENCES rubro_empresa(tipo_rubro)
);

CREATE TABLE sucursal(
id_sucursal VARCHAR(20) NOT NULL,
id_empresa VARCHAR(20) NOT NULL,
direccion VARCHAR(200) NOT NULL,
departamento VARCHAR(200) NULL,
pais VARCHAR (50) NOT NULL,
fax INTEGER NULL,
telefono INTEGER NULL,
correo VARCHAR(200) NOT NULL,

PRIMARY KEY(id_sucursal),
FOREIGN KEY(id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE empleado_empresa(
id_sucursal VARCHAR(20) NOT NULL,
id_empleado VARCHAR(20) NOT NULL, 
fecha_contrato DATE NOT NULL,
fecha_fin_contrato DATE NULL,
activo SMALLINT NOT NULL,
puesto VARCHAR(200) NOT NULL,

PRIMARY KEY(id_sucursal, id_empleado),
FOREIGN KEY(id_sucursal) REFERENCES sucursal(id_sucursal),
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE permiso(
tipo_permiso SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,

PRIMARY KEY(tipo_permiso)
);

CREATE TABLE tipo_usuario(
tipo_usuario SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,

PRIMARY KEY(tipo_usuario)
);

CREATE TABLE tipo_usuario_permiso(
tipo_usuario SMALLINT NOT NULL,
tipo_permiso SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,

PRIMARY KEY(tipo_usuario, tipo_permiso),
FOREIGN KEY(tipo_usuario) REFERENCES tipo_usuario(tipo_usuario),
FOREIGN KEY(tipo_permiso) REFERENCES permiso(tipo_permiso)
);

CREATE TABLE usuario(
id_empleado VARCHAR(20) NOT NULL,
id_empresa VARCHAR(20) NOT NULL,
tipo_usuario SMALLINT NOT NULL,
contrasenia VARCHAR(40) NOT NULL,
palabra_clave VARCHAR(20) NULL,
activo SMALLINT NOT NULL,
fecha_registro DATE NOT NULL,

PRIMARY KEY(id_empleado, id_empresa, tipo_usuario),
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado),
FOREIGN KEY(id_empresa) REFERENCES empresa(id_empresa),
FOREIGN KEY(tipo_usuario) REFERENCES tipo_usuario(tipo_usuario)
);

CREATE TABLE sesion(
id_empleado VARCHAR(20) NOT NULL,
fecha_inicio TIMESTAMP NOT NULL,
token VARCHAR(200) NOT NULL,
fecha_fin TIMESTAMP NULL,
sistema SMALLINT NOT NULL,
    
PRIMARY KEY(id_empleado, fecha_inicio),
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado),
FOREIGN KEY(sistema) REFERENCES sistema(id_sistema)
);

CREATE TABLE bitacora_sesion(
id_empleado VARCHAR(20) NOT NULL,
fecha_inicio TIMESTAMP NOT NULL,
fecha_fin TIMESTAMP NULL,
sistema SMALLINT NOT NULL,
token varchar(200) NOT NULL
);

CREATE TABLE sistema(
id_sistema SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,
ubicacion VARCHAR(200) NOT NULL,

PRIMARY KEY(id_sistema)
);

CREATE TABLE sitio(
id_sitio SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,
ubicacion VARCHAR(200) NOT NULL,

PRIMARY KEY(id_sitio)
);

CREATE TABLE actividad(
id_empleado VARCHAR(200) NOT NULL,
sitio SMALLINT NOT NULL,
fecha DATE NOT NULL,
sistema SMALLINT NOT NULL,
descripcion VARCHAR(200) NULL,

PRIMARY KEY(id_empleado, sitio, fecha,sistema),
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado),
FOREIGN KEY(sitio) REFERENCES sitio(id_sitio),
FOREIGN KEY(sistema) REFERENCES sistema(id_sistema)
);

CREATE TABLE estado_venta(
estado_venta SMALLINT NOT NULL,
descripcion VARCHAR(200) NOT NULL,

PRIMARY KEY (estado_venta)
);

CREATE SEQUENCE id_venta START 0;

CREATE TABLE venta(
id_venta INTEGER NOT NULL,
id_empleado VARCHAR(20) NOT NULL,
id_sucursal VARCHAR(20) NOT NULL,
inicio_venta DATE NOT NULL,
fin_venta DATE NULL,
estado_venta SMALLINT NOT NULL,

PRIMARY KEY(id_venta),
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado),
FOREIGN KEY(id_sucursal) REFERENCES sucursal(id_sucursal),
FOREIGN KEY(estado_venta) REFERENCES estado_venta(estado_venta)
);


CREATE TABLE venta_satisfactoria(
id_venta INTEGER NOT NULL,
monto FLOAT NOT NULL,
cantidad SMALLINT NOT NULL,
producto VARCHAR(100) NOT NULL,
descripcion VARCHAR(100) NULL,

PRIMARY KEY(id_venta),
FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

CREATE TABLE venta_no_satisfactoria(
id_venta INTEGER NOT NULL,
razon VARCHAR(200) NOT NULL,
descripcion VARCHAR(200) NULL,

PRIMARY KEY(id_venta),
FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

CREATE TABLE bitacora_venta(
id_venta INTEGER NOT NULL,
id_empleado VARCHAR(20) NOT NULL,
id_empresa VARCHAR(20) NOT NULL,
inicio_venta DATE  NULL,
fin_venta DATE NULL,
estado_venta SMALLINT  NULL,
razon VARCHAR(200)  NULL,
descripcion VARCHAR(200) NULL,
monto FLOAT  NULL,
cantidad SMALLINT  NULL,
producto VARCHAR(100)  NULL
);
