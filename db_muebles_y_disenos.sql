
-- MÓDULO CLIENTES Y VENTAS

create database db_MUEBLES_DISEÑOS;

use db_MUEBLES_DISEÑOS;
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    correo VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(100)
);

CREATE TABLE cotizaciones (
    id_cotizacion INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha DATE,
    total_estimado DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_pedido DATE,
    estado_pedido VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE facturas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    fecha_factura DATE,
    total DECIMAL(10,2),
    medio_pago VARCHAR(50),
    estado_pago VARCHAR(30),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

CREATE TABLE detalle_factura (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_factura INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
);

-- MÓDULO INVENTARIO Y ALMACÉN
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio_unitario DECIMAL(10,2),
    stock_actual INT,
    stock_minimo INT,
    codigo_barras VARCHAR(50)
);

CREATE TABLE almacenes (
    id_almacen INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    ubicacion VARCHAR(100)
);

CREATE TABLE movimientos_inventario (
    id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    id_almacen INT,
    tipo_movimiento VARCHAR(20),
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_almacen) REFERENCES almacenes(id_almacen)
);

-- MÓDULO PRODUCCIÓN
CREATE TABLE ordenes_produccion (
    id_orden INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    fecha_inicio DATE,
    fecha_fin_estimada DATE,
    estado VARCHAR(30),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE materias_primas (
    id_materia INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    stock INT,
    unidad VARCHAR(20)
);

CREATE TABLE consumo_produccion (
    id_consumo INT PRIMARY KEY AUTO_INCREMENT,
    id_orden INT,
    id_materia INT,
    cantidad_usada DECIMAL(10,2),
    FOREIGN KEY (id_orden) REFERENCES ordenes_produccion(id_orden),
    FOREIGN KEY (id_materia) REFERENCES materias_primas(id_materia)
);

-- MÓDULO CALIDAD
CREATE TABLE inspecciones (
    id_inspeccion INT PRIMARY KEY AUTO_INCREMENT,
    id_orden INT,
    resultado VARCHAR(20),
    observaciones TEXT,
    fecha DATE,
    FOREIGN KEY (id_orden) REFERENCES ordenes_produccion(id_orden)
);

CREATE TABLE no_conformidades (
    id_nc INT PRIMARY KEY AUTO_INCREMENT,
    id_inspeccion INT,
    descripcion TEXT,
    accion_correctiva TEXT,
    FOREIGN KEY (id_inspeccion) REFERENCES inspecciones(id_inspeccion)
);

-- MÓDULO CONTABILIDAD
CREATE TABLE transacciones_financieras (
    id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(20),
    monto DECIMAL(12,2),
    descripcion TEXT,
    fecha DATE
);

CREATE TABLE cuentas_por_pagar (
    id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
    proveedor VARCHAR(100),
    monto_total DECIMAL(12,2),
    fecha_vencimiento DATE,
    estado VARCHAR(30)
);
