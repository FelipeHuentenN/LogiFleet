"""Acceso a la base de datos MySQL de LogiFleet.

Usa el esquema de database/logifleet_estructura_mysql.sql tal como está.
La conexión se configura con variables de entorno:

    LOGIFLEET_DB_HOST      (por defecto: localhost)
    LOGIFLEET_DB_PORT      (por defecto: 3306)
    LOGIFLEET_DB_USER      (por defecto: root)
    LOGIFLEET_DB_PASSWORD  (por defecto: vacío)
    LOGIFLEET_DB_NAME      (por defecto: logifleet_db)
    LOGIFLEET_EMPRESA_ID   empresa cuyos datos se muestran (por defecto: 1)
"""
import os
from datetime import datetime, time

import pymysql
from pymysql.cursors import DictCursor

EMPRESA_ID = int(os.getenv("LOGIFLEET_EMPRESA_ID", "1"))


def conectar():
    return pymysql.connect(
        host=os.getenv("LOGIFLEET_DB_HOST", "localhost"),
        port=int(os.getenv("LOGIFLEET_DB_PORT", "3306")),
        user=os.getenv("LOGIFLEET_DB_USER", "root"),
        password=os.getenv("LOGIFLEET_DB_PASSWORD", ""),
        database=os.getenv("LOGIFLEET_DB_NAME", "logifleet_db"),
        charset="utf8mb4",
        cursorclass=DictCursor,
    )


def consultar(sql, params=()):
    conexion = conectar()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(sql, params)
            return cursor.fetchall()
    finally:
        conexion.close()


# Formato

def formato_fecha(valor, con_hora=False):
    if valor is None:
        return "Sin registro"
    return valor.strftime("%d/%m/%Y %H:%M" if con_hora else "%d/%m/%Y")


def formato_litros(litros, fecha):
    cantidad = f"{float(litros):g}".replace(".", ",")
    return f"{cantidad} L · {formato_fecha(fecha)}"


# Vehículos

def listar_vehiculos(empresa_id=EMPRESA_ID):
    vehiculos = consultar(
        """
        SELECT id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo,
               odometro_actual_vehiculo, estado_vehiculo
        FROM vehiculo
        WHERE empresa_id_empresa = %s
        ORDER BY patente_vehiculo
        """,
        (empresa_id,),
    )

    # Conductor de la ruta más reciente de cada vehículo
    rutas = consultar(
        """
        SELECT r.vehiculo_id_vehiculo, CONCAT(u.nombre_us, ' ', u.apellido_us) AS conductor,
               r.hora_inicio_ruta, r.hora_fin_ruta
        FROM ruta r
        JOIN conductor c ON c.id_conductor = r.conductor_id_conductor
        JOIN usuario u ON u.id_usuario = c.usuario_id_usuario
        WHERE r.empresa_id_empresa = %s
        ORDER BY r.fecha_ruta DESC, r.id_ruta DESC
        """,
        (empresa_id,),
    )

    # Próxima mantención según el plan: la fecha más cercana entre todos los planes
    planes = consultar(
        """
        SELECT p.vehiculo_id_vehiculo,
               MIN(DATE_ADD(p.fecha_ultimo_mant, INTERVAL CAST(p.cada_dias AS UNSIGNED) DAY)) AS proxima
        FROM plan_mantencion p
        JOIN vehiculo v ON v.id_vehiculo = p.vehiculo_id_vehiculo
        WHERE v.empresa_id_empresa = %s
        GROUP BY p.vehiculo_id_vehiculo
        """,
        (empresa_id,),
    )
    proxima_mantencion = {p["vehiculo_id_vehiculo"]: p["proxima"] for p in planes}

    cargas = consultar(
        """
        SELECT cc.vehiculo_id_vehiculo, cc.fecha_carga_comb, cc.litros_carga_comb, cc.odometro_carga_comb
        FROM carga_combustible cc
        JOIN vehiculo v ON v.id_vehiculo = cc.vehiculo_id_vehiculo
        WHERE v.empresa_id_empresa = %s
        ORDER BY cc.fecha_carga_comb
        """,
        (empresa_id,),
    )

    mantenciones = consultar(
        """
        SELECT m.vehiculo_id_vehiculo, MAX(m.fecha_mant) AS ultima
        FROM mantencion m
        JOIN vehiculo v ON v.id_vehiculo = m.vehiculo_id_vehiculo
        WHERE v.empresa_id_empresa = %s
        GROUP BY m.vehiculo_id_vehiculo
        """,
        (empresa_id,),
    )
    ultima_mantencion = {m["vehiculo_id_vehiculo"]: m["ultima"] for m in mantenciones}

    resultado = []
    for v in vehiculos:
        id_v = v["id_vehiculo"]
        rutas_v = [r for r in rutas if r["vehiculo_id_vehiculo"] == id_v]
        cargas_v = [c for c in cargas if c["vehiculo_id_vehiculo"] == id_v]

        # Rendimiento: km recorridos entre la primera y la última carga,
        # dividido por los litros cargados después de la primera.
        consumo = "Sin datos"
        if len(cargas_v) >= 2:
            km = cargas_v[-1]["odometro_carga_comb"] - cargas_v[0]["odometro_carga_comb"]
            litros = sum(c["litros_carga_comb"] for c in cargas_v[1:])
            if litros:
                consumo = f"{float(km / litros):.1f} km/l".replace(".", ",")

        ultima_carga = "Sin registro"
        if cargas_v:
            ultima_carga = formato_litros(cargas_v[-1]["litros_carga_comb"], cargas_v[-1]["fecha_carga_comb"])

        actividades = [c["fecha_carga_comb"] for c in cargas_v]
        actividades += [r["hora_fin_ruta"] or r["hora_inicio_ruta"] for r in rutas_v]
        actividades = [a for a in actividades if a is not None]
        if id_v in ultima_mantencion:
            # fecha_mant es DATE: se compara como medianoche de ese día
            actividades.append(datetime.combine(ultima_mantencion[id_v], time()))

        resultado.append({
            "id": id_v,
            "patente": v["patente_vehiculo"],
            "modelo": f"{v['marca_vehiculo']} {v['modelo_vehiculo']}",
            "conductor": rutas_v[0]["conductor"] if rutas_v else "Sin asignar",
            "estado": v["estado_vehiculo"],
            "km": int(v["odometro_actual_vehiculo"]),
            "mantencion": formato_fecha(proxima_mantencion.get(id_v)),
            "consumo": consumo,
            "combustible": ultima_carga,
            "ultima": (formato_fecha(max(actividades), con_hora=max(actividades).time() != time())
                       if actividades else "Sin registro"),
        })
    return resultado


# Conductores

def listar_conductores(empresa_id=EMPRESA_ID):
    conductores = consultar(
        """
        SELECT c.id_conductor, u.nombre_us, u.apellido_us, c.clase_licencia_conductor,
               c.fecha_vencimiento_licencia, c.telefono_conductor, c.estado_conductor
        FROM conductor c
        JOIN usuario u ON u.id_usuario = c.usuario_id_usuario
        WHERE u.empresa_id_empresa = %s
        ORDER BY u.nombre_us, u.apellido_us
        """,
        (empresa_id,),
    )

    # Ruta vigente de cada conductor: la que está "En curso" o, si no hay, la más reciente
    rutas = consultar(
        """
        SELECT r.id_ruta, r.conductor_id_conductor, er.nombre_ruta, v.patente_vehiculo
        FROM ruta r
        JOIN estado_ruta er ON er.id_estado_ruta = r.estado_ruta_id_estado_ruta
        JOIN vehiculo v ON v.id_vehiculo = r.vehiculo_id_vehiculo
        WHERE r.empresa_id_empresa = %s
        ORDER BY (er.nombre_ruta = 'En curso') DESC, r.fecha_ruta DESC, r.id_ruta DESC
        """,
        (empresa_id,),
    )

    paradas = consultar(
        """
        SELECT pr.ruta_id_ruta, pr.resultado_parada, o.motivo_rechazo
        FROM parada_ruta pr
        JOIN orden_despacho o ON o.id_orden_desp = pr.orden_despacho_id_orden_desp
        WHERE o.empresa_id_empresa = %s
        """,
        (empresa_id,),
    )

    cargas = consultar(
        """
        SELECT cc.conductor_id_conductor, cc.fecha_carga_comb, cc.litros_carga_comb
        FROM carga_combustible cc
        JOIN vehiculo v ON v.id_vehiculo = cc.vehiculo_id_vehiculo
        WHERE v.empresa_id_empresa = %s
        ORDER BY cc.fecha_carga_comb DESC
        """,
        (empresa_id,),
    )

    resultado = []
    for c in conductores:
        id_c = c["id_conductor"]
        ruta = next((r for r in rutas if r["conductor_id_conductor"] == id_c), None)
        paradas_ruta = [p for p in paradas if ruta and p["ruta_id_ruta"] == ruta["id_ruta"]]
        rechazos = [p["motivo_rechazo"] for p in paradas_ruta
                    if p["resultado_parada"] == "Rechazado" and p["motivo_rechazo"]]
        carga = next((x for x in cargas if x["conductor_id_conductor"] == id_c), None)

        resultado.append({
            "id": id_c,
            "conductor": f"{c['nombre_us']} {c['apellido_us']}",
            "licencia": f"Licencia {c['clase_licencia_conductor']} · vence "
                        f"{formato_fecha(c['fecha_vencimiento_licencia'])}",
            "telefono": c["telefono_conductor"],
            "estado": c["estado_conductor"],
            "estado recorrido": ruta["nombre_ruta"] if ruta else "Sin ruta",
            "Vehiculo asigando": ruta["patente_vehiculo"] if ruta else "Sin asignar",
            "total de paquetes": str(len(paradas_ruta)),
            "paquetes entregados": str(sum(p["resultado_parada"] == "Entregado" for p in paradas_ruta)),
            "paquetes faltantes": str(sum(p["resultado_parada"] == "Pendiente" for p in paradas_ruta)),
            "paquete no entregado": "; ".join(rechazos) if rechazos else "N/A",
            "ultima carga": (formato_litros(carga["litros_carga_comb"], carga["fecha_carga_comb"])
                             if carga else "Sin registro"),
        })
    return resultado
