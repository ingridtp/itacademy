create database tobiolife_analytics;

use tobiolife_analytics;

-- Tabla: clientes
CREATE TABLE clientes (
    cli_id VARCHAR(20) PRIMARY KEY,
    cli_clasificacion VARCHAR(50),
    cli_exp_previa BOOLEAN
);

-- Tabla: aromas
CREATE TABLE aromas (
    aro_id VARCHAR(20) PRIMARY KEY,
    aro_nombre VARCHAR(100)
);

-- Tabla: categoria_opcion
CREATE TABLE categoria_opcion (
    co_id VARCHAR(20) PRIMARY KEY,
    co_nombre VARCHAR(100),
    co_descripcion TEXT
);

-- Tabla: categoria_producto
CREATE TABLE categoria_producto (
    cp_id VARCHAR(20) PRIMARY KEY,
    cp_nombre VARCHAR(100)
);

-- Tabla: pedidos
CREATE TABLE pedidos (
    ped_id VARCHAR(20) PRIMARY KEY,
    ped_ciudad VARCHAR(100),
    ped_inicial INT
);

-- Tabla: catalogo
CREATE TABLE catalogo (
    opc_id VARCHAR(20) PRIMARY KEY,
    opc_nombre VARCHAR(100),
    opc_precio DECIMAL(10,2),
    opc_vigente BOOLEAN
);

-- Tabla: productos
CREATE TABLE productos (
    pro_id VARCHAR(20) PRIMARY KEY,
    pro_tipo VARCHAR(50),
    pro_peso DECIMAL(10,2),
    pro_unidad VARCHAR(20),
    pro_especificacion TEXT
);

-- Tabla: ordenes
CREATE TABLE ordenes (
    ord_id VARCHAR(20) PRIMARY KEY,
    ord_cantidad INT
);

-- Tabla: tabla_hechos (tabla de hechos del modelo estrella)
CREATE TABLE tabla_hechos (
    ped_id VARCHAR(20),
    cli_id VARCHAR(20),
    ord_id VARCHAR(20),
    opc_id VARCHAR(20),
    co_id VARCHAR(20),
    pro_id VARCHAR(20),
    cp_id VARCHAR(20),
    aro_id VARCHAR(20),
    pro_cantidad INT,

    PRIMARY KEY (ped_id, cli_id, ord_id, opc_id, co_id, pro_id, cp_id, aro_id),

    FOREIGN KEY (ped_id) REFERENCES pedidos(ped_id),
    FOREIGN KEY (cli_id) REFERENCES clientes(cli_id),
    FOREIGN KEY (ord_id) REFERENCES ordenes(ord_id),
    FOREIGN KEY (opc_id) REFERENCES catalogo(opc_id),
    FOREIGN KEY (co_id) REFERENCES categoria_opcion(co_id),
    FOREIGN KEY (pro_id) REFERENCES productos(pro_id),
    FOREIGN KEY (cp_id) REFERENCES categoria_producto(cp_id),
    FOREIGN KEY (aro_id) REFERENCES aromas(aro_id)
);





