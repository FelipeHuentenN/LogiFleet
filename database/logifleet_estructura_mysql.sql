-- LogiFleet: estructura de base de datos compatible con MySQL 8.x
-- Generado a partir del DDL original de Oracle SQL Developer Data Modeler.
-- Crea los 25 modelos, claves primarias y relaciones (claves foráneas).
-- Ejecutar este archivo antes de logifleet_datos_mysql.sql.
-- Si la base de datos aún no existe, ejecutar primero: CREATE DATABASE logifleet_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; USE logifleet_db;

CREATE TABLE IF NOT EXISTS `alerta` (
id_alerta                     INTEGER NOT NULL,
    tipo_alerta                   VARCHAR(30) NOT NULL,
    mensaje_alerta                VARCHAR(200) NOT NULL,
    fecha_alerta                  TIMESTAMP NOT NULL,
    estado_alerta                 VARCHAR(15) NOT NULL,
    vehiculo_id_vehiculo          INTEGER NOT NULL,
    alerta_id_documento           INTEGER,
    plan_mantencion_id_plan_mant  INTEGER,
    PRIMARY KEY (id_alerta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `carga_combustible` (
id_carga_comb           INTEGER NOT NULL,
    fecha_carga_comb        TIMESTAMP NOT NULL,
    litros_carga_comb       DECIMAL(10, 2) NOT NULL,
    precio_litros_comb      DECIMAL(10, 2) NOT NULL,
    costo_carga_comb        DECIMAL(10, 2) NOT NULL,
    odometro_carga_comb     DECIMAL(10, 2) NOT NULL,
    conductor_id_conductor  INTEGER NOT NULL,
    vehiculo_id_vehiculo    INTEGER NOT NULL,
    PRIMARY KEY (id_carga_comb)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cliente` (
id_cliente          INTEGER NOT NULL,
    rut_cli             VARCHAR(12) NOT NULL,
    nombre_cli          VARCHAR(100) NOT NULL,
    apellido_cli        VARCHAR(100) NOT NULL,
    email_cli           VARCHAR(120),
    teléfono_cli        VARCHAR(20),
    activo_cli          CHAR(1) NOT NULL,
    empresa_id_empresa  INTEGER NOT NULL,
    PRIMARY KEY (id_cliente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `comuna` (
id_comuna         INTEGER NOT NULL,
    nombre_comuna     VARCHAR(80),
    region_id_region  INTEGER NOT NULL,
    PRIMARY KEY (id_comuna)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `conductor` (
id_conductor                INTEGER NOT NULL,
    clase_licencia_conductor    VARCHAR(5) NOT NULL,
    fecha_vencimiento_licencia  DATE NOT NULL,
    telefono_conductor          VARCHAR(15) NOT NULL,
    estado_conductor            VARCHAR(20) NOT NULL,
    usuario_id_usuario          INTEGER NOT NULL,
    PRIMARY KEY (id_conductor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `detalle_orden` (
id_detalle_orden              INTEGER NOT NULL,
    cantidad_orden                INTEGER NOT NULL,
    peso_total_kg_orden           DECIMAL(10, 2) NOT NULL,
    producto_id_producto          INTEGER NOT NULL,
    orden_despacho_id_orden_desp  INTEGER NOT NULL,
    PRIMARY KEY (id_detalle_orden)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `direccion` (
id_direccion        INTEGER NOT NULL,
    calle               VARCHAR(200) NOT NULL,
    numero_calle        INTEGER NOT NULL,
    referencia          VARCHAR(30),
    comuna_id_comuna    INTEGER NOT NULL,
    cliente_id_cliente  INTEGER NOT NULL,
    PRIMARY KEY (id_direccion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `documento_vehiculo` (
id_documento_vehiculo   INTEGER NOT NULL,
    fecha_emision_docu      DATE NOT NULL,
    fecha_vencimiento_docu  DATE NOT NULL,
    archivo_url_docu        VARCHAR(80),
    id_tipo_documento       INTEGER NOT NULL,
    vehiculo_id_vehiculo    INTEGER NOT NULL,
    PRIMARY KEY (id_documento_vehiculo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `empresa` (
id_empresa          INTEGER NOT NULL,
    rut_emp             VARCHAR(12) NOT NULL,
    razón_social        VARCHAR(100) NOT NULL,
    email_emp           VARCHAR(120) NOT NULL,
    teléfono_emp        VARCHAR(20),
    direccion_emp       VARCHAR(120),
    activa_emp          CHAR(1) NOT NULL,
    fecha_registro_emp  DATE NOT NULL,
    PRIMARY KEY (id_empresa)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `estado_orden` (
id_estado_ord  INTEGER NOT NULL,
    nombre_orden   VARCHAR(10) NOT NULL,
    flujo_orden    DECIMAL(1, 0) NOT NULL,
    PRIMARY KEY (id_estado_ord)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `estado_ruta` (
id_estado_ruta  INTEGER NOT NULL,
    nombre_ruta     VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_estado_ruta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `historial_estado_orden` (
id_historial_orden            INTEGER NOT NULL,
    fechayhora_orden              TIMESTAMP NOT NULL,
    comentario_historial_orden    VARCHAR(40),
    usuario_id_usuario            INTEGER NOT NULL,
    estado_orden_id_estado_ord    INTEGER NOT NULL,
    orden_despacho_id_orden_desp  INTEGER NOT NULL,
    PRIMARY KEY (id_historial_orden)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `mantencion` (
id_mantencion                 INTEGER NOT NULL,
    clasificacion_mant            VARCHAR(10) NOT NULL,
    fecha_mant                    DATE NOT NULL,
    odometro_vehiculo_mant        DECIMAL(10, 1) NOT NULL,
    costo_mant                    DECIMAL(10, 2) NOT NULL,
    taller_mant                   VARCHAR(20),
    descripcion_mantencion        VARCHAR(30),
    vehiculo_id_vehiculo          INTEGER NOT NULL,
    tipo_mantencion_id_tipo_mant  INTEGER NOT NULL,
    PRIMARY KEY (id_mantencion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `orden_despacho` (
id_orden_desp               INTEGER NOT NULL,
    numero_despacho             VARCHAR(15) NOT NULL,
    prioridad_despacho          VARCHAR(20) NOT NULL,
    fecha_creacion_desp         TIMESTAMP(0) NOT NULL,
    fecha_estimada_desp         TIMESTAMP(0) NOT NULL,
    fecha_entrega_desp          TIMESTAMP(0),
    motivo_rechazo              VARCHAR(80),
    observaciones_desp          VARCHAR(80),
    empresa_id_empresa          INTEGER NOT NULL,
    cliente_id_cliente          INTEGER NOT NULL,
    estado_orden_id_estado_ord  INTEGER NOT NULL,
    direccion_id_direccion      INTEGER NOT NULL,
    PRIMARY KEY (id_orden_desp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `parada_ruta` (
id_parada                     INTEGER NOT NULL,
    secuencia_parada              INTEGER NOT NULL,
    hora_parada                   TIMESTAMP,
    hora_entrega_parada           TIMESTAMP,
    resultado_parada              VARCHAR(20),
    orden_despacho_id_orden_desp  INTEGER NOT NULL,
    ruta_id_ruta                  INTEGER NOT NULL,
    PRIMARY KEY (id_parada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `plan_mantencion` (
id_plan_mant                  INTEGER NOT NULL,
    cada_km                       VARCHAR(10),
    cada_dias                     DECIMAL(10, 2),
    km_ultimo_mant                DECIMAL(10, 1) NOT NULL,
    fecha_ultimo_mant             DATE,
    vehiculo_id_vehiculo          INTEGER NOT NULL,
    tipo_mantencion_id_tipo_mant  INTEGER NOT NULL,
    PRIMARY KEY (id_plan_mant)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `producto` (
id_producto         INTEGER NOT NULL,
    sku_producto        DECIMAL(30, 0) NOT NULL,
    nombre_prod         VARCHAR(50) NOT NULL,
    peso_prod           DECIMAL(10, 2) NOT NULL,
    volm3_prod          DECIMAL(8, 3),
    empresa_id_empresa  INTEGER NOT NULL,
    PRIMARY KEY (id_producto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `region` (
id_region      INTEGER NOT NULL,
    nombre_region  VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_region)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `rol` (
id_rol           INTEGER NOT NULL,
    nombre_rol       VARCHAR(50) NOT NULL,
    descripción_rol  VARCHAR(120),
    PRIMARY KEY (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ruta` (
id_ruta                     INTEGER NOT NULL,
    fecha_ruta                  TIMESTAMP NOT NULL,
    hora_inicio_ruta            TIMESTAMP,
    hora_fin_ruta               TIMESTAMP,
    km_inicial_ruta             INTEGER,
    km_final_ruta               INTEGER,
    distancia_ruta              DECIMAL(8, 2),
    costo_ruta                  DECIMAL(10, 2),
    empresa_id_empresa          INTEGER NOT NULL,
    estado_ruta_id_estado_ruta  INTEGER NOT NULL,
    conductor_id_conductor      INTEGER NOT NULL,
    vehiculo_id_vehiculo        INTEGER NOT NULL,
    PRIMARY KEY (id_ruta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tipo_documento` (
id_tipo_documento  INTEGER NOT NULL,
    nombre_documento   VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_tipo_documento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tipo_mantencion` (
id_tipo_mant      INTEGER NOT NULL,
    nombre_mant       VARCHAR(30) NOT NULL,
    descripcion_mant  VARCHAR(30),
    PRIMARY KEY (id_tipo_mant)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tipo_vehiculo` (
id_tipo_vehiculo  INTEGER NOT NULL,
    nombre_vehiculo   VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_tipo_vehiculo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `usuario` (
id_usuario          INTEGER NOT NULL,
    nombre_us           VARCHAR(100) NOT NULL,
    apellido_us         VARCHAR(100) NOT NULL,
    email_us            VARCHAR(120) NOT NULL,
    password_hash       VARCHAR(255) NOT NULL,
    activo_us           CHAR(1) NOT NULL,
    fecha_creacion_us   DATE NOT NULL,
    rol_id_rol          INTEGER NOT NULL,
    empresa_id_empresa  INTEGER NOT NULL,
    PRIMARY KEY (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `vehiculo` (
id_vehiculo                     INTEGER NOT NULL,
    patente_vehiculo                VARCHAR(10) NOT NULL,
    marca_vehiculo                  VARCHAR(30) NOT NULL,
    modelo_vehiculo                 VARCHAR(20) NOT NULL,
    año_vehiculo                    INTEGER NOT NULL,
    capacidad_kg_vehiculo           INTEGER NOT NULL,
    tipo_combustible_vehiculo       VARCHAR(10) NOT NULL,
    odometro_actual_vehiculo        DECIMAL(8, 1) NOT NULL,
    estado_vehiculo                 VARCHAR(20) NOT NULL,
    empresa_id_empresa              INTEGER NOT NULL,
    tipo_vehiculo_id_tipo_vehiculo  INTEGER NOT NULL,
    PRIMARY KEY (id_vehiculo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Relaciones (claves foráneas)
ALTER TABLE `alerta` ADD CONSTRAINT `alerta_documento_fk` FOREIGN KEY (alerta_id_documento) REFERENCES `documento_vehiculo` (id_documento_vehiculo);
ALTER TABLE `alerta` ADD CONSTRAINT `alerta_plan_mantencion_fk` FOREIGN KEY (plan_mantencion_id_plan_mant) REFERENCES `plan_mantencion` (id_plan_mant);
ALTER TABLE `alerta` ADD CONSTRAINT `alerta_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `carga_combustible` ADD CONSTRAINT `carga_combustible_conductor_fk` FOREIGN KEY (conductor_id_conductor) REFERENCES `conductor` (id_conductor);
ALTER TABLE `carga_combustible` ADD CONSTRAINT `carga_combustible_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `cliente` ADD CONSTRAINT `cliente_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `comuna` ADD CONSTRAINT `comuna_region_fk` FOREIGN KEY (region_id_region) REFERENCES `region` (id_region);
ALTER TABLE `conductor` ADD CONSTRAINT `conductor_usuario_fk` FOREIGN KEY (usuario_id_usuario) REFERENCES `usuario` (id_usuario);
ALTER TABLE `detalle_orden` ADD CONSTRAINT `detalle_orden_fk` FOREIGN KEY (orden_despacho_id_orden_desp) REFERENCES `orden_despacho` (id_orden_desp);
ALTER TABLE `detalle_orden` ADD CONSTRAINT `detalle_orden_producto_fk` FOREIGN KEY (producto_id_producto) REFERENCES `producto` (id_producto);
ALTER TABLE `direccion` ADD CONSTRAINT `direccion_cliente_fk` FOREIGN KEY (cliente_id_cliente) REFERENCES `cliente` (id_cliente);
ALTER TABLE `direccion` ADD CONSTRAINT `direccion_comuna_fk` FOREIGN KEY (comuna_id_comuna) REFERENCES `comuna` (id_comuna);
ALTER TABLE `documento_vehiculo` ADD CONSTRAINT `documento_vehiculo_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `historial_estado_orden` ADD CONSTRAINT `hist_estado_fk` FOREIGN KEY (estado_orden_id_estado_ord) REFERENCES `estado_orden` (id_estado_ord);
ALTER TABLE `historial_estado_orden` ADD CONSTRAINT `hist_orden_fk` FOREIGN KEY (orden_despacho_id_orden_desp) REFERENCES `orden_despacho` (id_orden_desp);
ALTER TABLE `historial_estado_orden` ADD CONSTRAINT `hist_usuario_fk` FOREIGN KEY (usuario_id_usuario) REFERENCES `usuario` (id_usuario);
ALTER TABLE `documento_vehiculo` ADD CONSTRAINT `id_tipo_documento` FOREIGN KEY (id_tipo_documento) REFERENCES `tipo_documento` (id_tipo_documento);
ALTER TABLE `mantencion` ADD CONSTRAINT `mantencion_tipo_mantencion_fk` FOREIGN KEY (tipo_mantencion_id_tipo_mant) REFERENCES `tipo_mantencion` (id_tipo_mant);
ALTER TABLE `mantencion` ADD CONSTRAINT `mantencion_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `orden_despacho` ADD CONSTRAINT `orden_despacho_cliente_fk` FOREIGN KEY (cliente_id_cliente) REFERENCES `cliente` (id_cliente);
ALTER TABLE `orden_despacho` ADD CONSTRAINT `orden_despacho_direccion_fk` FOREIGN KEY (direccion_id_direccion) REFERENCES `direccion` (id_direccion);
ALTER TABLE `orden_despacho` ADD CONSTRAINT `orden_despacho_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `orden_despacho` ADD CONSTRAINT `orden_despacho_estado_orden_fk` FOREIGN KEY (estado_orden_id_estado_ord) REFERENCES `estado_orden` (id_estado_ord);
ALTER TABLE `parada_ruta` ADD CONSTRAINT `parada_ruta_orden_despacho_fk` FOREIGN KEY (orden_despacho_id_orden_desp) REFERENCES `orden_despacho` (id_orden_desp);
ALTER TABLE `parada_ruta` ADD CONSTRAINT `parada_ruta_ruta_fk` FOREIGN KEY (ruta_id_ruta) REFERENCES `ruta` (id_ruta);
ALTER TABLE `plan_mantencion` ADD CONSTRAINT `plan_mantencion_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `plan_mantencion` ADD CONSTRAINT `plan_tipomant_fk` FOREIGN KEY (tipo_mantencion_id_tipo_mant) REFERENCES `tipo_mantencion` (id_tipo_mant);
ALTER TABLE `producto` ADD CONSTRAINT `producto_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `ruta` ADD CONSTRAINT `ruta_conductor_fk` FOREIGN KEY (conductor_id_conductor) REFERENCES `conductor` (id_conductor);
ALTER TABLE `ruta` ADD CONSTRAINT `ruta_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `ruta` ADD CONSTRAINT `ruta_estado_ruta_fk` FOREIGN KEY (estado_ruta_id_estado_ruta) REFERENCES `estado_ruta` (id_estado_ruta);
ALTER TABLE `ruta` ADD CONSTRAINT `ruta_vehiculo_fk` FOREIGN KEY (vehiculo_id_vehiculo) REFERENCES `vehiculo` (id_vehiculo);
ALTER TABLE `usuario` ADD CONSTRAINT `usuario_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `usuario` ADD CONSTRAINT `usuario_rol_fk` FOREIGN KEY (rol_id_rol) REFERENCES `rol` (id_rol);
ALTER TABLE `vehiculo` ADD CONSTRAINT `vehiculo_empresa_fk` FOREIGN KEY (empresa_id_empresa) REFERENCES `empresa` (id_empresa);
ALTER TABLE `vehiculo` ADD CONSTRAINT `vehiculo_tipo_vehiculo_fk` FOREIGN KEY (tipo_vehiculo_id_tipo_vehiculo) REFERENCES `tipo_vehiculo` (id_tipo_vehiculo);
