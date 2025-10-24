create database tobiolife;

use tobiolife;

-- Tabla: clientes
CREATE TABLE clientes (
    cli_id VARCHAR(20) PRIMARY KEY,
    cli_clasificacion VARCHAR(50),
    cli_exp_previa BOOLEAN
);

-- Tabla: categoria_producto
CREATE TABLE categoria_producto (
    cp_id VARCHAR(20) PRIMARY KEY,
    cp_nombre VARCHAR(100)
);

-- Tabla: aromas
CREATE TABLE aromas (
    aro_id VARCHAR(20) PRIMARY KEY,
    aro_nombre VARCHAR(100)
);

-- Tabla: productos
CREATE TABLE productos (
    pro_id VARCHAR(20) PRIMARY KEY,
    pro_tipo VARCHAR(50),
    pro_peso DECIMAL(10,2),
    pro_unidad VARCHAR(20),
    pro_especificacion TEXT,
    cp_id VARCHAR(20),
    FOREIGN KEY (cp_id) REFERENCES categoria_producto(cp_id)
);

-- Tabla: categoria_opcion
CREATE TABLE categoria_opcion (
    co_id VARCHAR(20) PRIMARY KEY,
    co_nombre VARCHAR(100),
    co_descripcion TEXT
);

-- Tabla: catalogo (opciones de productos)
CREATE TABLE catalogo (
    opc_id VARCHAR(20) PRIMARY KEY,
    opc_nombre VARCHAR(100),
    opc_precio DECIMAL(10,2),
    opc_vigente BOOLEAN,
    co_id VARCHAR(20),
    FOREIGN KEY (co_id) REFERENCES categoria_opcion(co_id)
);

-- Tabla: pedidos
CREATE TABLE pedidos (
    ped_id VARCHAR(20) PRIMARY KEY,
    ped_ciudad VARCHAR(100),
    ped_inicial INT,
    cli_id VARCHAR(20),
    FOREIGN KEY (cli_id) REFERENCES clientes(cli_id)
);

CREATE TABLE ordenes (
    ord_id VARCHAR(20) PRIMARY KEY,
    ped_id VARCHAR(20),
    opc_id VARCHAR(20),
    ord_cantidad INT,
    FOREIGN KEY (ped_id) REFERENCES pedidos(ped_id),
    FOREIGN KEY (opc_id) REFERENCES catalogo(opc_id)
);

CREATE TABLE detalle_ordenes (
    ord_id VARCHAR(20),
    pro_id VARCHAR(20),
    aro_id VARCHAR(20),
    pro_cantidad INT,
    
    PRIMARY KEY (ord_id, pro_id, aro_id),
    
    FOREIGN KEY (ord_id) REFERENCES ordenes(ord_id),
    FOREIGN KEY (pro_id) REFERENCES productos(pro_id),
    FOREIGN KEY (aro_id) REFERENCES aromas(aro_id)
);

