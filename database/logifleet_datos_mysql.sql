-- =====================================================================
-- Datos de prueba - Proyecto APT (Plataforma de gestión logística)
-- Base: MySQL (script de carga de datos convertido desde Oracle)
--
-- Cómo usarlo: ejecutar en MySQL Workbench sobre el
-- esquema donde ya están creados los modelos necesarios y vacíos. Los IDs se insertan
-- de forma explícita.
-- Las tablas se cargan en orden de dependencia (primero catálogos, al final
-- alertas), respetando las claves foráneas.
--
-- Fecha de referencia de los datos: 27-10-2026 (las rutas "En curso" son de hoy).
-- Todos los correos, teléfonos y RUT son ficticios.
-- =====================================================================
-- ---------------------------------------------------------------------
-- LIMPIEZA (descomentar solo si necesitas volver a cargar los datos)
-- ---------------------------------------------------------------------
-- DELETE FROM alerta;
-- DELETE FROM parada_ruta;
-- DELETE FROM ruta;
-- DELETE FROM historial_estado_orden;
-- DELETE FROM detalle_orden;
-- DELETE FROM orden_despacho;
-- DELETE FROM carga_combustible;
-- DELETE FROM mantencion;
-- DELETE FROM plan_mantencion;
-- DELETE FROM documento_vehiculo;
-- DELETE FROM vehiculo;
-- DELETE FROM producto;
-- DELETE FROM direccion;
-- DELETE FROM cliente;
-- DELETE FROM conductor;
-- DELETE FROM usuario;
-- DELETE FROM estado_ruta;
-- DELETE FROM estado_orden;
-- DELETE FROM tipo_mantencion;
-- DELETE FROM tipo_documento;
-- DELETE FROM tipo_vehiculo;
-- DELETE FROM empresa;
-- DELETE FROM rol;
-- DELETE FROM comuna;
-- DELETE FROM region;
-- COMMIT;


-- ---------------------------------------------------------------------
-- Catálogos y datos base
-- ---------------------------------------------------------------------
-- region (5)
INSERT INTO region (id_region, nombre_region) VALUES (1, 'Región Metropolitana de Santiago');
INSERT INTO region (id_region, nombre_region) VALUES (2, 'Valparaíso');
INSERT INTO region (id_region, nombre_region) VALUES (3, 'Biobío');
INSERT INTO region (id_region, nombre_region) VALUES (4, 'O''Higgins');
INSERT INTO region (id_region, nombre_region) VALUES (5, 'Maule');
-- comuna (12)
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (1, 'Santiago', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (2, 'Maipú', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (3, 'Puente Alto', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (4, 'Las Condes', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (5, 'Pudahuel', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (6, 'San Bernardo', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (7, 'Quilicura', 1);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (8, 'Valparaíso', 2);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (9, 'Viña del Mar', 2);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (10, 'Concepción', 3);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (11, 'Rancagua', 4);
INSERT INTO comuna (id_comuna, nombre_comuna, region_id_region) VALUES (12, 'Talca', 5);
-- rol (3)
INSERT INTO rol (id_rol, nombre_rol, descripción_rol) VALUES (1, 'Administrador', 'Gestiona usuarios, flota y reportes');
INSERT INTO rol (id_rol, nombre_rol, descripción_rol) VALUES (2, 'Despachador', 'Crea órdenes y planifica rutas');
INSERT INTO rol (id_rol, nombre_rol, descripción_rol) VALUES (3, 'Conductor', 'Ejecuta rutas y registra entregas');
-- empresa (2)
INSERT INTO empresa (id_empresa, rut_emp, razón_social, email_emp, teléfono_emp, direccion_emp, activa_emp, fecha_registro_emp) VALUES (1, '76.412.380-8', 'Distribuidora Los Aromos SpA', 'contacto@losaromos.example.com', '+56 2 2555 0101', 'Av. Industrial 1450, Quilicura', 'S', '2026-09-01');
INSERT INTO empresa (id_empresa, rut_emp, razón_social, email_emp, teléfono_emp, direccion_emp, activa_emp, fecha_registro_emp) VALUES (2, '77.208.915-5', 'Comercial Rinconada Ltda.', 'ventas@rinconada.example.com', '+56 2 2555 0202', 'Camino a Melipilla 8800, Maipú', 'S', '2026-09-08');
-- tipo_vehiculo (4)
INSERT INTO tipo_vehiculo (id_tipo_vehiculo, nombre_vehiculo) VALUES (1, 'Camioneta');
INSERT INTO tipo_vehiculo (id_tipo_vehiculo, nombre_vehiculo) VALUES (2, 'Furgón');
INSERT INTO tipo_vehiculo (id_tipo_vehiculo, nombre_vehiculo) VALUES (3, 'Camión 3/4');
INSERT INTO tipo_vehiculo (id_tipo_vehiculo, nombre_vehiculo) VALUES (4, 'Camión');
-- tipo_documento (3)
INSERT INTO tipo_documento (id_tipo_documento, nombre_documento) VALUES (1, 'Permiso de circulación');
INSERT INTO tipo_documento (id_tipo_documento, nombre_documento) VALUES (2, 'Revisión técnica');
INSERT INTO tipo_documento (id_tipo_documento, nombre_documento) VALUES (3, 'Seguro obligatorio SOAP');
-- tipo_mantencion (5)
INSERT INTO tipo_mantencion (id_tipo_mant, nombre_mant, descripcion_mant) VALUES (1, 'Cambio de aceite', 'Aceite y filtro de motor');
INSERT INTO tipo_mantencion (id_tipo_mant, nombre_mant, descripcion_mant) VALUES (2, 'Revisión de frenos', 'Pastillas, discos y líquido');
INSERT INTO tipo_mantencion (id_tipo_mant, nombre_mant, descripcion_mant) VALUES (3, 'Cambio de neumáticos', 'Rotación o reemplazo');
INSERT INTO tipo_mantencion (id_tipo_mant, nombre_mant, descripcion_mant) VALUES (4, 'Mantención general', 'Revisión completa del vehículo');
INSERT INTO tipo_mantencion (id_tipo_mant, nombre_mant, descripcion_mant) VALUES (5, 'Reparación correctiva', 'Falla no programada');
-- estado_orden (4)
INSERT INTO estado_orden (id_estado_ord, nombre_orden, flujo_orden) VALUES (1, 'Preparando', 1);
INSERT INTO estado_orden (id_estado_ord, nombre_orden, flujo_orden) VALUES (2, 'En ruta', 2);
INSERT INTO estado_orden (id_estado_ord, nombre_orden, flujo_orden) VALUES (3, 'Entregado', 3);
INSERT INTO estado_orden (id_estado_ord, nombre_orden, flujo_orden) VALUES (4, 'Rechazado', 3);
-- estado_ruta (4)
INSERT INTO estado_ruta (id_estado_ruta, nombre_ruta) VALUES (1, 'Planificada');
INSERT INTO estado_ruta (id_estado_ruta, nombre_ruta) VALUES (2, 'En curso');
INSERT INTO estado_ruta (id_estado_ruta, nombre_ruta) VALUES (3, 'Finalizada');
INSERT INTO estado_ruta (id_estado_ruta, nombre_ruta) VALUES (4, 'Cancelada');

-- ---------------------------------------------------------------------
-- Usuarios, conductores, clientes y direcciones
-- ---------------------------------------------------------------------
-- usuario (10)
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (1, 'Valentina', 'Soto', 'valentina.soto@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-01', 1, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (2, 'Rodrigo', 'Pizarro', 'rodrigo.pizarro@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-01', 2, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (3, 'Jorge', 'Contreras', 'jorge.contreras@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-02', 3, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (4, 'Marcela', 'Vidal', 'marcela.vidal@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-02', 3, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (5, 'Cristián', 'Araya', 'cristian.araya@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-03', 3, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (6, 'Patricio', 'Henríquez', 'patricio.henriquez@losaromos.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'N', '2026-09-03', 3, 1);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (7, 'Daniela', 'Fuentes', 'daniela.fuentes@rinconada.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-08', 1, 2);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (8, 'Andrés', 'Lagos', 'andres.lagos@rinconada.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-08', 2, 2);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (9, 'Héctor', 'Salinas', 'hector.salinas@rinconada.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-09', 3, 2);
INSERT INTO usuario (id_usuario, nombre_us, apellido_us, email_us, password_hash, activo_us, fecha_creacion_us, rol_id_rol, empresa_id_empresa) VALUES (10, 'Ignacio', 'Bravo', 'ignacio.bravo@rinconada.example.com', 'HASH_DE_PRUEBA_REEMPLAZAR', 'S', '2026-09-09', 3, 2);
-- conductor (6)
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (1, 'A4', '2028-03-15', '+56955501101', 'En ruta', 3);
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (2, 'A3', '2027-07-22', '+56955501102', 'Disponible', 4);
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (3, 'A4', '2026-11-20', '+56955501103', 'Disponible', 5);
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (4, 'A2', '2026-09-30', '+56955501104', 'Inactivo', 6);
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (5, 'A4', '2029-01-10', '+56955502201', 'En ruta', 9);
INSERT INTO conductor (id_conductor, clase_licencia_conductor, fecha_vencimiento_licencia, telefono_conductor, estado_conductor, usuario_id_usuario) VALUES (6, 'A3', '2027-12-05', '+56955502202', 'Disponible', 10);
-- cliente (10)
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (1, '15.931.211-9', 'Camila', 'Rojas', 'camila.rojas@example.com', '+56955503301', 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (2, '16.662.422-3', 'Matías', 'Soto', 'matias.soto@example.com', '+56955503302', 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (3, '17.393.633-8', 'Fernanda', 'Muñoz', 'fernanda.munoz@example.com', NULL, 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (4, '18.124.844-0', 'Sebastián', 'Carrasco', 'sebastian.carrasco@example.com', '+56955503304', 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (5, '18.856.055-5', 'Javiera', 'Tapia', 'javiera.tapia@example.com', '+56955503305', 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (6, '19.587.266-K', 'Nicolás', 'Espinoza', 'nicolas.espinoza@example.com', '+56955503306', 'N', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (7, '20.318.477-8', 'Paula', 'Guzmán', 'paula.guzman@example.com', '+56955503307', 'S', 1);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (8, '21.049.688-2', 'Tomás', 'Valdés', 'tomas.valdes@example.com', '+56955504408', 'S', 2);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (9, '21.780.899-5', 'Antonia', 'Reyes', 'antonia.reyes@example.com', '+56955504409', 'S', 2);
INSERT INTO cliente (id_cliente, rut_cli, nombre_cli, apellido_cli, email_cli, teléfono_cli, activo_cli, empresa_id_empresa) VALUES (10, '22.512.110-9', 'Benjamín', 'Cortés', 'benjamin.cortes@example.com', '+56955504410', 'S', 2);
-- direccion (15)
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (1, 'Av. Apoquindo', 4500, 'Local 12', 4, 1);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (2, 'Av. Portales', 1840, 'Esq. calle Eyzaguirre', 6, 2);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (3, 'Los Alerces', 335, NULL, 2, 3);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (4, 'Av. Concha y Toro', 2250, 'Oficina 3', 3, 4);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (5, 'San Pablo', 8120, 'Bodega al fondo', 5, 5);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (6, 'Av. Libertad', 780, NULL, 9, 5);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (7, 'Av. Los Carrera', 410, NULL, 10, 6);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (8, 'Av. Libertador Bernardo O''Higgins', 1200, 'Piso 4', 1, 7);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (9, 'Av. Vicuña Mackenna', 3900, NULL, 3, 7);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (10, 'Av. Pajaritos', 3050, 'Local 7', 2, 8);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (11, 'Av. Brasil', 2600, NULL, 8, 9);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (12, 'Camino Lo Boza', 1450, 'Galpón 2', 5, 9);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (13, 'Calle Larga', 645, NULL, 7, 1);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (14, 'Av. San Martín', 1120, 'Frente a la plaza', 11, 10);
INSERT INTO direccion (id_direccion, calle, numero_calle, referencia, comuna_id_comuna, cliente_id_cliente) VALUES (15, 'Av. Los Industriales', 880, NULL, 7, 10);

-- ---------------------------------------------------------------------
-- Productos y flota
-- ---------------------------------------------------------------------
-- producto (10)
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (1, 7801234500001, 'Aceite vegetal caja 12x900 ml', 11.5, 0.012, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (2, 7801234500002, 'Arroz grado 1 saco 25 kg', 25, 0.035, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (3, 7801234500003, 'Agua mineral pack 6x1,5 L', 9.2, 0.011, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (4, 7801234500004, 'Fideos caja 20x400 g', 8.3, 0.02, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (5, 7801234500005, 'Detergente líquido bidón 5 L', 5.4, 0.007, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (6, 7801234500006, 'Azúcar saco 25 kg', 25, 0.032, 1);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (7, 7801234500007, 'Cemento saco 25 kg', 25, 0.018, 2);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (8, 7801234500008, 'Pintura látex balde 20 L', 28.5, 0.024, 2);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (9, 7801234500009, 'Fierro estriado 8 mm barra 12 m', 4.74, NULL, 2);
INSERT INTO producto (id_producto, sku_producto, nombre_prod, peso_prod, volm3_prod, empresa_id_empresa) VALUES (10, 7801234500010, 'Adhesivo cerámico saco 25 kg', 25, 0.017, 2);
-- vehiculo (8)
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (1, 'LKPR-37', 'Hyundai', 'Porter', 2022, 1000, 'Diésel', 64210, 'En ruta', 1, 1);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (2, 'PBXD-81', 'Foton', 'Aumark', 2021, 3500, 'Diésel', 91350, 'Disponible', 1, 3);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (3, 'TFGH-22', 'Mercedes-Benz', 'Sprinter', 2020, 1800, 'Diésel', 118400, 'Disponible', 1, 2);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (4, 'RSVT-46', 'Chevrolet', 'N300', 2023, 750, 'Bencina', 28900, 'Disponible', 1, 2);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (5, 'GYZC-59', 'Isuzu', 'NPR', 2019, 4500, 'Diésel', 131200, 'En mantención', 1, 4);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (6, 'HDKB-73', 'JAC', 'X200', 2022, 2000, 'Diésel', 45400, 'En ruta', 2, 3);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (7, 'WJTL-18', 'Hyundai', 'HD78', 2021, 3500, 'Diésel', 77720, 'Disponible', 2, 3);
INSERT INTO vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, año_vehiculo, capacidad_kg_vehiculo, tipo_combustible_vehiculo, odometro_actual_vehiculo, estado_vehiculo, empresa_id_empresa, tipo_vehiculo_id_tipo_vehiculo) VALUES (8, 'XCFD-64', 'Kia', 'Frontier', 2018, 1200, 'Diésel', 141640, 'Disponible', 2, 1);
-- documento_vehiculo (24)
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (1, '2026-03-20', '2027-03-31', '/docs/vehiculos/LKPR37_permiso_2026.pdf', 1, 1);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (2, '2026-05-18', '2027-05-18', '/docs/vehiculos/LKPR37_revision_tecnica_2026.pdf', 2, 1);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (3, '2026-03-24', '2027-03-31', '/docs/vehiculos/LKPR37_soap_2026.pdf', 3, 1);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (4, '2026-03-20', '2027-03-31', '/docs/vehiculos/PBXD81_permiso_2026.pdf', 1, 2);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (5, '2026-02-10', '2027-02-10', '/docs/vehiculos/PBXD81_revision_tecnica_2026.pdf', 2, 2);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (6, '2026-03-24', '2027-03-31', '/docs/vehiculos/PBXD81_soap_2026.pdf', 3, 2);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (7, '2026-03-20', '2027-03-31', '/docs/vehiculos/TFGH22_permiso_2026.pdf', 1, 3);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (8, '2025-11-12', '2026-11-12', '/docs/vehiculos/TFGH22_revision_tecnica_2026.pdf', 2, 3);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (9, '2026-03-24', '2027-03-31', '/docs/vehiculos/TFGH22_soap_2026.pdf', 3, 3);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (10, '2026-03-20', '2027-03-31', '/docs/vehiculos/RSVT46_permiso_2026.pdf', 1, 4);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (11, '2026-08-30', '2027-08-30', '/docs/vehiculos/RSVT46_revision_tecnica_2026.pdf', 2, 4);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (12, '2026-03-24', '2027-03-31', '/docs/vehiculos/RSVT46_soap_2026.pdf', 3, 4);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (13, '2026-03-20', '2027-03-31', '/docs/vehiculos/GYZC59_permiso_2026.pdf', 1, 5);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (14, '2026-01-22', '2027-01-22', '/docs/vehiculos/GYZC59_revision_tecnica_2026.pdf', 2, 5);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (15, '2026-03-24', '2027-03-31', NULL, 3, 5);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (16, '2026-03-20', '2027-03-31', '/docs/vehiculos/HDKB73_permiso_2026.pdf', 1, 6);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (17, '2026-06-04', '2027-06-04', '/docs/vehiculos/HDKB73_revision_tecnica_2026.pdf', 2, 6);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (18, '2026-03-24', '2027-03-31', '/docs/vehiculos/HDKB73_soap_2026.pdf', 3, 6);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (19, '2026-03-20', '2027-03-31', '/docs/vehiculos/WJTL18_permiso_2026.pdf', 1, 7);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (20, '2026-03-15', '2027-03-15', '/docs/vehiculos/WJTL18_revision_tecnica_2026.pdf', 2, 7);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (21, '2026-03-24', '2027-03-31', '/docs/vehiculos/WJTL18_soap_2026.pdf', 3, 7);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (22, '2026-03-20', '2027-03-31', '/docs/vehiculos/XCFD64_permiso_2026.pdf', 1, 8);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (23, '2025-10-20', '2026-10-20', '/docs/vehiculos/XCFD64_revision_tecnica_2026.pdf', 2, 8);
INSERT INTO documento_vehiculo (id_documento_vehiculo, fecha_emision_docu, fecha_vencimiento_docu, archivo_url_docu, id_tipo_documento, vehiculo_id_vehiculo) VALUES (24, '2026-03-24', '2027-03-31', '/docs/vehiculos/XCFD64_soap_2026.pdf', 3, 8);

-- ---------------------------------------------------------------------
-- Mantenimiento y combustible
-- ---------------------------------------------------------------------
-- plan_mantencion (13)
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (1, '10000', 180, 59800, '2026-08-12', 1, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (2, '10000', 180, 82000, '2026-05-28', 2, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (3, '10000', 180, 115600, '2026-08-30', 3, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (4, '10000', 180, 21500, '2026-04-18', 4, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (5, '10000', 180, 120000, '2026-04-03', 5, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (6, '10000', 180, 41300, '2026-09-02', 6, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (7, '10000', 180, 70200, '2026-07-15', 7, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (8, '10000', 180, 136500, '2026-08-05', 8, 1);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (9, '20000', 365, 52300, '2026-03-20', 1, 2);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (10, '20000', 365, 105000, '2026-02-14', 3, 2);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (11, '20000', 365, 60000, '2026-01-25', 7, 2);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (12, '40000', 730, 80500, '2026-05-02', 2, 3);
INSERT INTO plan_mantencion (id_plan_mant, cada_km, cada_dias, km_ultimo_mant, fecha_ultimo_mant, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (13, '40000', 730, 130000, '2026-03-10', 8, 3);
-- mantencion (16)
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (1, 'Preventiva', '2026-02-10', 50400, 68900, 'AutoService Central', 'Aceite y filtro', 1, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (2, 'Preventiva', '2026-03-20', 52300, 148500, 'Frenos y Más', 'Pastillas delanteras', 1, 2);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (3, 'Preventiva', '2026-08-12', 59800, 72500, 'AutoService Central', 'Aceite y filtro', 1, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (4, 'Preventiva', '2026-05-02', 80500, 412000, 'Neumáticos Pacífico', '4 neumáticos nuevos', 2, 3);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (5, 'Preventiva', '2026-05-28', 82000, 85900, 'Taller Mecánico Sur', 'Aceite y filtros', 2, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (6, 'Preventiva', '2026-02-14', 105000, 186000, 'Frenos y Más', 'Discos y pastillas', 3, 2);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (7, 'Correctiva', '2026-07-09', 112000, 389000, 'Taller Hermanos Ríos', 'Cambio de embrague', 3, 5);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (8, 'Preventiva', '2026-08-30', 115600, 94800, 'Diesel Center', 'Aceite y filtros', 3, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (9, 'Preventiva', '2026-04-18', 21500, 59900, 'AutoService Central', 'Aceite y filtro', 4, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (10, 'Preventiva', '2026-04-03', 120000, 98700, 'Diesel Center', 'Aceite y filtros', 5, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (11, 'Correctiva', '2026-10-22', 131200, 652000, 'Taller Hermanos Ríos', 'Falla bomba inyectora', 5, 5);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (12, 'Preventiva', '2026-09-02', 41300, 79900, 'Taller Mecánico Sur', 'Aceite y filtros', 6, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (13, 'Preventiva', '2026-01-25', 60000, 163500, 'Frenos y Más', 'Pastillas y líquido', 7, 2);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (14, 'Preventiva', '2026-07-15', 70200, 88400, 'Diesel Center', 'Aceite y filtros', 7, 1);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (15, 'Preventiva', '2026-03-10', 130000, 395000, 'Neumáticos Pacífico', 'Rotación y 2 neumáticos', 8, 3);
INSERT INTO mantencion (id_mantencion, clasificacion_mant, fecha_mant, odometro_vehiculo_mant, costo_mant, taller_mant, descripcion_mantencion, vehiculo_id_vehiculo, tipo_mantencion_id_tipo_mant) VALUES (16, 'Preventiva', '2026-08-05', 136500, 74900, 'Taller Mecánico Sur', 'Aceite y filtro', 8, 1);
-- carga_combustible (13)
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (1, '2026-09-18 17:30:00', 38.5, 1052, 40502, 62184, 1, 1);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (2, '2026-10-09 17:45:00', 41.2, 1068, 44001.6, 63526, 1, 1);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (3, '2026-10-24 18:10:00', 40, 1074, 42960, 64130, 2, 1);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (4, '2026-10-10 18:05:00', 62, 1068, 66216, 90472, 2, 2);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (5, '2026-10-25 17:40:00', 58.4, 1074, 62721.6, 91245, 2, 2);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (6, '2026-10-02 16:50:00', 53.2, 1052, 55966.4, 117179, 3, 3);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (7, '2026-10-18 17:15:00', 55, 1068, 58740, 117939, 3, 3);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (8, '2026-10-21 17:30:00', 33.1, 1285, 42533.5, 28678, 3, 4);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (9, '2026-10-11 10:20:00', 70.4, 1060, 74624, 130591, 2, 5);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (10, '2026-10-19 16:45:00', 48, 1071, 51408, 44719, 5, 6);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (11, '2026-10-05 17:20:00', 49.9, 1059, 52844.1, 76085, 6, 7);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (12, '2026-10-26 18:00:00', 52.7, 1075, 56652.5, 77694, 6, 7);
INSERT INTO carga_combustible (id_carga_comb, fecha_carga_comb, litros_carga_comb, precio_litros_comb, costo_carga_comb, odometro_carga_comb, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (13, '2026-10-15 17:35:00', 60.3, 1066, 64279.8, 140912, 5, 8);

-- ---------------------------------------------------------------------
-- Órdenes de despacho
-- ---------------------------------------------------------------------
-- orden_despacho (28)
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (1, 'OD-2026-0001', 'Media', '2026-10-12 16:13:00', '2026-10-14 18:00:00', '2026-10-14 09:42:00', NULL, NULL, 1, 3, 3, 3);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (2, 'OD-2026-0002', 'Alta', '2026-10-13 15:26:00', '2026-10-14 18:00:00', '2026-10-14 11:28:00', NULL, 'Llamar antes de llegar', 1, 2, 3, 2);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (3, 'OD-2026-0003', 'Baja', '2026-10-12 14:39:00', '2026-10-14 18:00:00', NULL, 'Cliente ausente en el domicilio', NULL, 1, 1, 4, 1);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (4, 'OD-2026-0004', 'Media', '2026-10-19 13:52:00', '2026-10-21 18:00:00', '2026-10-21 09:30:00', NULL, NULL, 1, 5, 3, 5);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (5, 'OD-2026-0005', 'Alta', '2026-10-20 12:05:00', '2026-10-21 18:00:00', '2026-10-21 11:12:00', NULL, 'Descargar en bodega trasera', 1, 4, 3, 4);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (6, 'OD-2026-0006', 'Alta', '2026-10-26 11:18:00', '2026-10-27 18:00:00', '2026-10-27 09:35:00', NULL, NULL, 1, 7, 3, 8);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (7, 'OD-2026-0007', 'Media', '2026-10-25 10:31:00', '2026-10-27 18:00:00', NULL, NULL, NULL, 1, 1, 2, 13);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (8, 'OD-2026-0008', 'Media', '2026-10-25 09:44:00', '2026-10-27 18:00:00', NULL, NULL, 'Entregar en horario de la tarde', 1, 2, 2, 2);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (9, 'OD-2026-0009', 'Alta', '2026-10-18 16:57:00', '2026-10-19 18:00:00', '2026-10-19 10:14:00', NULL, NULL, 1, 7, 3, 9);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (10, 'OD-2026-0010', 'Media', '2026-10-17 15:10:00', '2026-10-19 18:00:00', '2026-10-19 13:20:00', NULL, NULL, 1, 4, 3, 4);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (11, 'OD-2026-0011', 'Baja', '2026-10-24 14:23:00', '2026-10-26 18:00:00', '2026-10-26 10:25:00', NULL, NULL, 1, 5, 3, 5);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (12, 'OD-2026-0012', 'Media', '2026-10-24 13:36:00', '2026-10-26 18:00:00', NULL, 'Producto no corresponde al pedido', NULL, 1, 3, 4, 3);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (13, 'OD-2026-0013', 'Alta', '2026-10-21 12:49:00', '2026-10-22 18:00:00', '2026-10-22 09:55:00', NULL, 'Llamar antes de llegar', 1, 1, 3, 1);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (14, 'OD-2026-0014', 'Media', '2026-10-20 11:02:00', '2026-10-22 18:00:00', '2026-10-22 12:30:00', NULL, NULL, 1, 7, 3, 8);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (15, 'OD-2026-0015', 'Media', '2026-10-24 10:15:00', '2026-10-26 18:00:00', '2026-10-26 10:12:00', NULL, NULL, 1, 2, 3, 2);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (16, 'OD-2026-0016', 'Baja', '2026-10-24 09:28:00', '2026-10-26 18:00:00', '2026-10-26 13:25:00', NULL, NULL, 1, 4, 3, 4);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (17, 'OD-2026-0017', 'Alta', '2026-10-26 16:41:00', '2026-10-28 18:00:00', NULL, NULL, NULL, 1, 3, 1, 3);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (18, 'OD-2026-0018', 'Media', '2026-10-27 15:54:00', '2026-10-28 18:00:00', NULL, NULL, NULL, 1, 5, 1, 5);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (19, 'OD-2026-0019', 'Baja', '2026-10-26 14:07:00', '2026-10-29 18:00:00', NULL, NULL, NULL, 1, 7, 1, 9);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (20, 'OD-2026-0020', 'Alta', '2026-10-22 13:20:00', '2026-10-23 18:00:00', '2026-10-23 09:20:00', NULL, NULL, 2, 8, 3, 10);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (21, 'OD-2026-0021', 'Media', '2026-10-21 12:33:00', '2026-10-23 18:00:00', '2026-10-23 12:41:00', NULL, NULL, 2, 9, 3, 12);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (22, 'OD-2026-0022', 'Media', '2026-10-25 11:46:00', '2026-10-27 18:00:00', '2026-10-27 10:20:00', NULL, NULL, 2, 10, 3, 15);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (23, 'OD-2026-0023', 'Alta', '2026-10-26 10:59:00', '2026-10-27 18:00:00', NULL, NULL, 'Descargar en bodega trasera', 2, 8, 2, 10);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (24, 'OD-2026-0024', 'Media', '2026-10-18 09:12:00', '2026-10-20 18:00:00', '2026-10-20 10:44:00', NULL, NULL, 2, 9, 3, 12);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (25, 'OD-2026-0025', 'Baja', '2026-10-18 16:25:00', '2026-10-20 18:00:00', NULL, 'Dirección incorrecta o inexistente', NULL, 2, 10, 4, 15);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (26, 'OD-2026-0026', 'Alta', '2026-10-25 15:38:00', '2026-10-26 18:00:00', '2026-10-26 09:50:00', NULL, NULL, 2, 8, 3, 10);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (27, 'OD-2026-0027', 'Media', '2026-10-24 14:51:00', '2026-10-26 18:00:00', '2026-10-26 12:48:00', NULL, NULL, 2, 9, 3, 12);
INSERT INTO orden_despacho (id_orden_desp, numero_despacho, prioridad_despacho, fecha_creacion_desp, fecha_estimada_desp, fecha_entrega_desp, motivo_rechazo, observaciones_desp, empresa_id_empresa, cliente_id_cliente, estado_orden_id_estado_ord, direccion_id_direccion) VALUES (28, 'OD-2026-0028', 'Baja', '2026-10-27 13:04:00', '2026-10-29 18:00:00', NULL, NULL, NULL, 2, 10, 1, 15);
-- detalle_orden (38)
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (1, 10, 115, 1, 1);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (2, 5, 41.5, 4, 1);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (3, 8, 200, 2, 2);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (4, 12, 110.4, 3, 3);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (5, 4, 21.6, 5, 3);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (6, 6, 150, 6, 4);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (7, 6, 69, 1, 5);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (8, 10, 92, 3, 5);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (9, 4, 100, 2, 6);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (10, 8, 66.4, 4, 6);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (11, 10, 54, 5, 7);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (12, 5, 57.5, 1, 8);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (13, 3, 75, 6, 8);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (14, 12, 300, 2, 9);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (15, 15, 124.5, 4, 10);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (16, 6, 32.4, 5, 10);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (17, 20, 184, 3, 11);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (18, 8, 92, 1, 12);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (19, 10, 250, 6, 13);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (20, 12, 64.8, 5, 14);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (21, 6, 49.8, 4, 14);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (22, 6, 150, 2, 15);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (23, 15, 138, 3, 16);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (24, 12, 138, 1, 17);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (25, 4, 100, 6, 18);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (26, 4, 100, 2, 18);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (27, 10, 83, 4, 19);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (28, 40, 1000, 7, 20);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (29, 6, 171, 8, 21);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (30, 30, 750, 10, 22);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (31, 20, 94.8, 9, 23);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (32, 50, 1250, 7, 24);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (33, 4, 114, 8, 25);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (34, 20, 500, 10, 25);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (35, 24, 600, 10, 26);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (36, 30, 142.2, 9, 27);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (37, 2, 57, 8, 27);
INSERT INTO detalle_orden (id_detalle_orden, cantidad_orden, peso_total_kg_orden, producto_id_producto, orden_despacho_id_orden_desp) VALUES (38, 20, 500, 7, 28);
-- historial_estado_orden (73)
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (1, '2026-10-12 16:13:00', 'Orden creada', 2, 1, 1);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (2, '2026-10-14 08:05:00', 'Salida a ruta', 3, 2, 1);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (3, '2026-10-14 09:42:00', 'Entrega confirmada por el cliente', 3, 3, 1);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (4, '2026-10-13 15:26:00', 'Orden creada', 2, 1, 2);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (5, '2026-10-14 08:05:00', 'Salida a ruta', 3, 2, 2);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (6, '2026-10-14 11:28:00', 'Entrega confirmada por el cliente', 3, 3, 2);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (7, '2026-10-12 14:39:00', 'Orden creada', 2, 1, 3);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (8, '2026-10-14 08:05:00', 'Salida a ruta', 3, 2, 3);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (9, '2026-10-14 13:45:00', 'Rechazada: cliente ausente', 3, 4, 3);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (10, '2026-10-19 13:52:00', 'Orden creada', 2, 1, 4);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (11, '2026-10-21 07:50:00', 'Salida a ruta', 3, 2, 4);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (12, '2026-10-21 09:30:00', 'Entrega confirmada por el cliente', 3, 3, 4);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (13, '2026-10-20 12:05:00', 'Orden creada', 2, 1, 5);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (14, '2026-10-21 07:50:00', 'Salida a ruta', 3, 2, 5);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (15, '2026-10-21 11:12:00', 'Entrega confirmada por el cliente', 3, 3, 5);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (16, '2026-10-26 11:18:00', 'Orden creada', 2, 1, 6);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (17, '2026-10-27 07:55:00', 'Salida a ruta', 3, 2, 6);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (18, '2026-10-27 09:35:00', 'Entrega confirmada por el cliente', 3, 3, 6);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (19, '2026-10-25 10:31:00', 'Orden creada', 2, 1, 7);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (20, '2026-10-27 07:55:00', 'Salida a ruta', 3, 2, 7);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (21, '2026-10-25 09:44:00', 'Orden creada', 2, 1, 8);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (22, '2026-10-27 07:55:00', 'Salida a ruta', 3, 2, 8);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (23, '2026-10-18 16:57:00', 'Orden creada', 2, 1, 9);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (24, '2026-10-19 08:15:00', 'Salida a ruta', 4, 2, 9);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (25, '2026-10-19 10:14:00', 'Entrega confirmada por el cliente', 4, 3, 9);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (26, '2026-10-17 15:10:00', 'Orden creada', 2, 1, 10);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (27, '2026-10-19 08:15:00', 'Salida a ruta', 4, 2, 10);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (28, '2026-10-19 13:20:00', 'Entrega confirmada por el cliente', 4, 3, 10);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (29, '2026-10-24 14:23:00', 'Orden creada', 2, 1, 11);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (30, '2026-10-26 08:10:00', 'Salida a ruta', 4, 2, 11);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (31, '2026-10-26 10:25:00', 'Entrega confirmada por el cliente', 4, 3, 11);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (32, '2026-10-24 13:36:00', 'Orden creada', 2, 1, 12);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (33, '2026-10-26 08:10:00', 'Salida a ruta', 4, 2, 12);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (34, '2026-10-26 12:58:00', 'Rechazada: producto no corresponde', 4, 4, 12);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (35, '2026-10-21 12:49:00', 'Orden creada', 2, 1, 13);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (36, '2026-10-22 08:05:00', 'Salida a ruta', 5, 2, 13);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (37, '2026-10-22 09:55:00', 'Entrega confirmada por el cliente', 5, 3, 13);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (38, '2026-10-20 11:02:00', 'Orden creada', 2, 1, 14);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (39, '2026-10-22 08:05:00', 'Salida a ruta', 5, 2, 14);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (40, '2026-10-22 12:30:00', 'Entrega confirmada por el cliente', 5, 3, 14);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (41, '2026-10-24 10:15:00', 'Orden creada', 2, 1, 15);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (42, '2026-10-26 08:25:00', 'Salida a ruta', 5, 2, 15);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (43, '2026-10-26 10:12:00', 'Entrega confirmada por el cliente', 5, 3, 15);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (44, '2026-10-24 09:28:00', 'Orden creada', 2, 1, 16);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (45, '2026-10-26 08:25:00', 'Salida a ruta', 5, 2, 16);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (46, '2026-10-26 13:25:00', 'Entrega confirmada por el cliente', 5, 3, 16);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (47, '2026-10-26 16:41:00', 'Orden creada', 2, 1, 17);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (48, '2026-10-27 15:54:00', 'Orden creada', 2, 1, 18);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (49, '2026-10-26 14:07:00', 'Orden creada', 2, 1, 19);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (50, '2026-10-22 13:20:00', 'Orden creada', 8, 1, 20);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (51, '2026-10-23 07:35:00', 'Salida a ruta', 9, 2, 20);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (52, '2026-10-23 09:20:00', 'Entrega confirmada por el cliente', 9, 3, 20);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (53, '2026-10-21 12:33:00', 'Orden creada', 8, 1, 21);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (54, '2026-10-23 07:35:00', 'Salida a ruta', 9, 2, 21);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (55, '2026-10-23 12:41:00', 'Entrega confirmada por el cliente', 9, 3, 21);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (56, '2026-10-25 11:46:00', 'Orden creada', 8, 1, 22);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (57, '2026-10-27 07:45:00', 'Salida a ruta', 9, 2, 22);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (58, '2026-10-27 10:20:00', 'Entrega confirmada por el cliente', 9, 3, 22);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (59, '2026-10-26 10:59:00', 'Orden creada', 8, 1, 23);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (60, '2026-10-27 07:45:00', 'Salida a ruta', 9, 2, 23);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (61, '2026-10-18 09:12:00', 'Orden creada', 8, 1, 24);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (62, '2026-10-20 08:05:00', 'Salida a ruta', 10, 2, 24);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (63, '2026-10-20 10:44:00', 'Entrega confirmada por el cliente', 10, 3, 24);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (64, '2026-10-18 16:25:00', 'Orden creada', 8, 1, 25);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (65, '2026-10-20 08:05:00', 'Salida a ruta', 10, 2, 25);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (66, '2026-10-20 13:35:00', 'Rechazada: dirección incorrecta', 10, 4, 25);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (67, '2026-10-25 15:38:00', 'Orden creada', 8, 1, 26);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (68, '2026-10-26 07:55:00', 'Salida a ruta', 10, 2, 26);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (69, '2026-10-26 09:50:00', 'Entrega confirmada por el cliente', 10, 3, 26);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (70, '2026-10-24 14:51:00', 'Orden creada', 8, 1, 27);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (71, '2026-10-26 07:55:00', 'Salida a ruta', 10, 2, 27);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (72, '2026-10-26 12:48:00', 'Entrega confirmada por el cliente', 10, 3, 27);
INSERT INTO historial_estado_orden (id_historial_orden, fechayhora_orden, comentario_historial_orden, usuario_id_usuario, estado_orden_id_estado_ord, orden_despacho_id_orden_desp) VALUES (73, '2026-10-27 13:04:00', 'Orden creada', 8, 1, 28);

-- ---------------------------------------------------------------------
-- Rutas y paradas
-- ---------------------------------------------------------------------
-- ruta (13)
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (1, '2026-10-14 00:00:00', '2026-10-14 08:00:00', '2026-10-14 15:40:00', 63820, 63897, 77, 38500, 1, 3, 1, 1);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (2, '2026-10-21 00:00:00', '2026-10-21 07:45:00', '2026-10-21 14:20:00', 63990, 64068, 78, 39000, 1, 3, 1, 1);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (3, '2026-10-27 00:00:00', '2026-10-27 07:50:00', NULL, 64180, NULL, NULL, NULL, 1, 2, 1, 1);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (4, '2026-10-19 00:00:00', '2026-10-19 08:10:00', '2026-10-19 16:00:00', 91010, 91090, 80, 40000, 1, 3, 2, 2);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (5, '2026-10-26 00:00:00', '2026-10-26 08:05:00', '2026-10-26 15:30:00', 91260, 91340, 80, 40000, 1, 3, 2, 2);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (6, '2026-10-22 00:00:00', '2026-10-22 08:00:00', '2026-10-22 14:50:00', 118110, 118176, 66, 33000, 1, 3, 3, 3);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (7, '2026-10-26 00:00:00', '2026-10-26 08:20:00', '2026-10-26 15:10:00', 118300, 118372, 72, 36000, 1, 3, 3, 3);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (8, '2026-10-24 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 1, 4, 3, 3);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (9, '2026-10-28 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 2);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (10, '2026-10-23 00:00:00', '2026-10-23 07:30:00', '2026-10-23 15:00:00', 44980, 45070, 90, 45000, 2, 3, 5, 6);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (11, '2026-10-27 00:00:00', '2026-10-27 07:40:00', NULL, 45330, NULL, NULL, NULL, 2, 2, 5, 6);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (12, '2026-10-20 00:00:00', '2026-10-20 08:00:00', '2026-10-20 15:20:00', 77130, 77205, 75, 37500, 2, 3, 6, 7);
INSERT INTO ruta (id_ruta, fecha_ruta, hora_inicio_ruta, hora_fin_ruta, km_inicial_ruta, km_final_ruta, distancia_ruta, costo_ruta, empresa_id_empresa, estado_ruta_id_estado_ruta, conductor_id_conductor, vehiculo_id_vehiculo) VALUES (13, '2026-10-26 00:00:00', '2026-10-26 07:50:00', '2026-10-26 15:00:00', 77610, 77690, 80, 40000, 2, 3, 6, 7);
-- parada_ruta (26)
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (1, 1, '2026-10-14 09:30:00', '2026-10-14 09:42:00', 'Entregado', 1, 1);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (2, 2, '2026-10-14 11:15:00', '2026-10-14 11:28:00', 'Entregado', 2, 1);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (3, 3, '2026-10-14 13:30:00', '2026-10-14 13:45:00', 'Rechazado', 3, 1);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (4, 1, '2026-10-21 09:15:00', '2026-10-21 09:30:00', 'Entregado', 4, 2);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (5, 2, '2026-10-21 11:00:00', '2026-10-21 11:12:00', 'Entregado', 5, 2);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (6, 1, '2026-10-27 09:30:00', '2026-10-27 09:35:00', 'Entregado', 6, 3);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (7, 2, '2026-10-27 13:30:00', NULL, 'Pendiente', 7, 3);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (8, 3, '2026-10-27 15:00:00', NULL, 'Pendiente', 8, 3);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (9, 1, '2026-10-19 10:00:00', '2026-10-19 10:14:00', 'Entregado', 9, 4);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (10, 2, '2026-10-19 13:00:00', '2026-10-19 13:20:00', 'Entregado', 10, 4);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (11, 1, '2026-10-26 10:15:00', '2026-10-26 10:25:00', 'Entregado', 11, 5);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (12, 2, '2026-10-26 12:40:00', '2026-10-26 12:58:00', 'Rechazado', 12, 5);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (13, 1, '2026-10-22 09:45:00', '2026-10-22 09:55:00', 'Entregado', 13, 6);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (14, 2, '2026-10-22 12:15:00', '2026-10-22 12:30:00', 'Entregado', 14, 6);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (15, 1, '2026-10-26 10:00:00', '2026-10-26 10:12:00', 'Entregado', 15, 7);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (16, 2, '2026-10-26 13:10:00', '2026-10-26 13:25:00', 'Entregado', 16, 7);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (17, 1, '2026-10-28 10:00:00', NULL, 'Pendiente', 17, 9);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (18, 2, '2026-10-28 12:00:00', NULL, 'Pendiente', 18, 9);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (19, 1, '2026-10-23 09:00:00', '2026-10-23 09:20:00', 'Entregado', 20, 10);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (20, 2, '2026-10-23 12:30:00', '2026-10-23 12:41:00', 'Entregado', 21, 10);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (21, 1, '2026-10-27 10:15:00', '2026-10-27 10:20:00', 'Entregado', 22, 11);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (22, 2, '2026-10-27 14:00:00', NULL, 'Pendiente', 23, 11);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (23, 1, '2026-10-20 10:30:00', '2026-10-20 10:44:00', 'Entregado', 24, 12);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (24, 2, '2026-10-20 13:20:00', '2026-10-20 13:35:00', 'Rechazado', 25, 12);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (25, 1, '2026-10-26 09:40:00', '2026-10-26 09:50:00', 'Entregado', 26, 13);
INSERT INTO parada_ruta (id_parada, secuencia_parada, hora_parada, hora_entrega_parada, resultado_parada, orden_despacho_id_orden_desp, ruta_id_ruta) VALUES (26, 2, '2026-10-26 12:30:00', '2026-10-26 12:48:00', 'Entregado', 27, 13);

-- ---------------------------------------------------------------------
-- Alertas
-- ---------------------------------------------------------------------
-- alerta (6)
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (1, 'Mantención vencida', 'Cambio de aceite vencido: superó el intervalo de 10.000 km', '2026-10-14 08:00:00', 'Activa', 5, NULL, 5);
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (2, 'Mantención próxima', 'Cambio de aceite próximo: supera el 85% del intervalo de 10.000 km', '2026-10-25 07:30:00', 'Activa', 2, NULL, 2);
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (3, 'Mantención próxima', 'Revisión de frenos próxima: supera el 85% del intervalo de 20.000 km', '2026-10-26 07:00:00', 'Activa', 7, NULL, 11);
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (4, 'Documento por vencer', 'La revisión técnica vence el 12-11-2026 (16 días)', '2026-10-27 06:00:00', 'Activa', 3, 8, NULL);
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (5, 'Documento vencido', 'La revisión técnica venció el 20-10-2026', '2026-10-21 06:00:00', 'Activa', 8, 23, NULL);
INSERT INTO alerta (id_alerta, tipo_alerta, mensaje_alerta, fecha_alerta, estado_alerta, vehiculo_id_vehiculo, alerta_id_documento, plan_mantencion_id_plan_mant) VALUES (6, 'Mantención próxima', 'Cambio de aceite próximo: supera el 85% del intervalo de 10.000 km', '2026-08-02 07:00:00', 'Resuelta', 1, NULL, 1);

COMMIT;
