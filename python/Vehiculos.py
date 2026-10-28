
from nicegui import ui


@ui.page('/vehiculos')
def pagina_vehiculos():
    ui.colors(primary="#1F3A5F")

    # Datos ficticios para el prototipo
    datos_vehiculos = [
        {
            "id": 1, "patente": "ABCD-12", "modelo": "Renault Master",
            "conductor": "Juan Pérez", "estado": "Activo",
            "km": 45000, "mantencion": "15/11/2026",
            "consumo": "10 km/l", "combustible": "65%",
            "ultima": "Hoy, 14:30"
        },
        {
            "id": 2, "patente": "EFGH-34", "modelo": "Peugeot Partner",
            "conductor": "María López", "estado": "Activo",
            "km": 32000, "mantencion": "20/12/2026",
            "consumo": "12 km/l", "combustible": "80%",
            "ultima": "Hoy, 13:45"
        },
        {
            "id": 3, "patente": "IJKL-56", "modelo": "Citroën Berlingo",
            "conductor": "Pedro Soto", "estado": "En mantenimiento",
            "km": 60000, "mantencion": "10/10/2026",
            "consumo": "9 km/l", "combustible": "30%",
            "ultima": "Ayer, 17:20"
        },
    ]

    # Encabezado
    with ui.header().classes("items-center gap-6 px-6"):
        ui.label("🚚 LogiFleet").classes("text-xl font-bold")
        ui.space()

        ui.link("Inicio", target="/").classes("text-white no-underline")
        ui.link("Vehículos", target="/vehiculos").classes("text-white no-underline")
        ui.link("Trabajadores", target="/Trabajadores").classes("text-white no-underline")
        ui.link("Reportes", target="/Estado_empresa").classes("text-white no-underline")

    # Contenido principal
    with ui.column().classes("w-full p-6 gap-5"):

        # Título y descripción
        with ui.row().classes("w-full items-center justify-between"):
            with ui.column().classes("gap-1"):
                ui.label("Gestión de vehículos").classes("text-3xl font-bold")
                ui.label("Administra la flota, los conductores y el mantenimiento.").classes("text-gray-500")

            ui.button("Actualizar panel",icon="refresh",on_click=lambda: ui.notify("Panel actualizado ")).props("outline")


        # Tarjetas de resumen
        with ui.grid(columns=4).classes("w-full gap-4"):

            #       vehiculos totales
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("commute", size="2xl").classes("text-blue-700")
                    with ui.column().classes("gap-0"):
                        ui.label("Vehículos totales").classes("text-gray-500")
                        ui.label(str(len(datos_vehiculos))).classes("text-3xl font-bold")

            #       vehiculos Activos
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("local_shipping", size="2xl").classes("text-green-600")
                    with ui.column().classes("gap-0"):
                        ui.label("vehiculos activos").classes("text-gray-500")
                        ui.label(str(sum(v["estado"] == "Activo" for v in datos_vehiculos))).classes("text-3xl font-bold")

            #       vehiculos En mantenimiento
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("build", size="2xl").classes("text-orange-500")
                    with ui.column().classes("gap-0"):
                        ui.label("vehiculos en mantenimiento").classes("text-gray-500")
                        ui.label(str(sum(v["estado"] == "En mantenimiento" 
                                        for v in datos_vehiculos))).classes("text-3xl font-bold")

            #       vehiculos Disponibles
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("check_circle", size="2xl").classes("text-teal-600")
                    with ui.column().classes("gap-0"):
                        ui.label("vehiculos disponibles").classes("text-gray-500")
                        ui.label(str(sum(v["estado"] == "Disponible"
                                        for v in datos_vehiculos))).classes("text-3xl font-bold")

        # Buscador y filtro
        with ui.card().classes("w-full"):
            with ui.row().classes("w-full items-center gap-4"):

                buscador = ui.input(placeholder="Buscar por patente o modelo...").props("outlined clearable").classes("flex-1")
                filtro = ui.select(
                    ["Todos", "Activo", "Disponible", "En mantenimiento"],
                    value="Todos",
                    label="Estado del vehículo").props("outlined").classes("w-64")

        # Distribución de la lista y el detalle
        with ui.row().classes("w-full items-start gap-5"):

            # Lista de vehículos
            with ui.card().classes("w-1/3 min-w-[280px]"):
                with ui.row().classes("w-full items-center justify-between"):
                    ui.label("Flota de vehículos").classes("text-xl font-bold")
                    ui.label(f"{len(datos_vehiculos)} registrados").classes("text-sm text-gray-500")

                ui.separator()

                filas = []

                with ui.column().classes("w-full max-h-[600px] overflow-y-auto gap-2"):
                    for vehiculo in datos_vehiculos:
                        with ui.row().classes("w-full items-center gap-3 p-3 rounded ""cursor-pointer hover:bg-gray-100") as fila:

                            color_estado = {
                                "Activo": "text-green-600",
                                "Disponible": "text-blue-600",
                                "En mantenimiento": "text-orange-500",}.get(vehiculo["estado"], "text-gray-500")

                            with ui.column().classes("gap-1 flex-1"):
                                ui.label(vehiculo["patente"]).classes("font-bold")
                                ui.label(vehiculo["modelo"]).classes("text-sm text-gray-500")
                                ui.label(vehiculo["estado"]).classes(f"text-xs {color_estado}")

                            ui.icon("chevron_right").classes("text-gray-400")

                        fila.on("click",lambda v=vehiculo: seleccionar_vehiculo(v))
                        filas.append((fila, vehiculo))

                ui.label("Selecciona un vehículo para ver sus detalles.").classes("text-xs text-gray-500")

            # Panel de detalles
            with ui.card().classes("flex-1 min-w-0 gap-4"):

                with ui.row().classes("w-full items-center justify-between"):
                    with ui.column().classes("gap-1"):
                        ui.label("Detalle del vehículo").classes("text-xl font-bold")
                        ui.label("Información general y estado operativo").classes("text-sm text-gray-500")

                    estado_detalle = ui.label("Activo").classes("text-green-700 font-bold")

                ui.separator()

                with ui.row().classes("w-full items-center gap-4"):
                    with ui.column().classes("items-center justify-center bg-blue-50 ""rounded-xl p-5"):
                        ui.icon("directions_car", size="4rem").classes("text-blue-800")

                    with ui.column().classes("gap-1"):
                        patente_detalle = ui.label("ABCD-12").classes("text-2xl font-bold")
                        modelo_detalle = ui.label("Renault Master").classes("text-gray-500")
                        conductor_detalle = ui.label("Conductor: Juan Pérez")

                # Datos generales
                ui.label("Datos generales").classes("text-lg font-bold")

                with ui.grid(columns=2).classes("w-full gap-4"):
                    with ui.card().classes("bg-gray-50"):
                        ui.icon("speed").classes("text-blue-700 text-xl")
                        ui.label("Kilometraje").classes("text-gray-500")
                        km_detalle = ui.label("45.000 km").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("local_gas_station").classes("text-blue-700 text-xl")
                        ui.label("Consumo de combustible").classes("text-gray-500")
                        consumo_detalle = ui.label("10 km/l").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("calendar_month").classes("text-orange-500 text-xl")
                        ui.label("Próximo mantenimiento").classes("text-gray-500")
                        mantencion_detalle = ui.label("15/11/2026").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("local_gas_station").classes("text-green-600 text-xl")
                        ui.label("Combustible disponible").classes("text-gray-500")
                        combustible_detalle = ui.label("65%").classes("text-lg font-bold")

                # Actividad y acciones
                ui.separator()
                ui.label("Última actividad").classes("text-lg font-bold")
                ultima_detalle = ui.label("Hoy, 14:30").classes("text-gray-600")

                with ui.row().classes("w-full flex-wrap gap-2"):
                    ui.button("Registrar mantenimiento",icon="build",on_click=lambda: ui.notify("Registro de mantenimiento: función por implementar")).props("outline")

                    ui.button("Editar información",icon="edit",on_click=lambda: ui.notify("Edición de vehículo: función por implementar"))

        # Información adicional al final
        with ui.card().classes("w-full"):
            with ui.row().classes("items-center gap-3"):
                ui.icon("info", size="xl").classes("text-blue-700")
                with ui.column().classes("gap-1"):
                    ui.label("Información de la flota").classes("font-bold")
                    ui.label(
                        "Revisa periódicamente el kilometraje, el consumo "
                        "de combustible y las fechas de mantenimiento para "
                        "mantener los vehículos operativos.").classes("text-gray-600")

        # Funciones de interacción

        def seleccionar_vehiculo(vehiculo):
            patente_detalle.set_text(vehiculo["patente"])
            modelo_detalle.set_text(vehiculo["modelo"])
            conductor_detalle.set_text(f"Conductor: {vehiculo['conductor']}")
            estado_detalle.set_text(vehiculo["estado"])
            km_detalle.set_text(f"{vehiculo['km']:,}".replace(",", ".") + " km")
            consumo_detalle.set_text(vehiculo["consumo"])
            mantencion_detalle.set_text(vehiculo["mantencion"])
            combustible_detalle.set_text(vehiculo["combustible"])
            ultima_detalle.set_text(vehiculo["ultima"])

            colores = {
                "Activo": "text-green-700",
                "Disponible": "text-blue-700",
                "En mantenimiento": "text-orange-600",}
            estado_detalle.classes(remove="text-green-700 text-blue-700 text-orange-600")
            estado_detalle.classes(colores.get(vehiculo["estado"], "text-gray-600"))

        def aplicar_filtros():
            texto = (buscador.value or "").strip().lower()
            estado = filtro.value

            for fila, vehiculo in filas:
                coincide_texto = (texto in vehiculo["patente"].lower()or texto in vehiculo["modelo"].lower())
                coincide_estado = (estado == "Todos" or vehiculo["estado"] == estado)
                fila.set_visibility(coincide_texto and coincide_estado)

        buscador.on_value_change(lambda _: aplicar_filtros())
        filtro.on_value_change(lambda _: aplicar_filtros())




    ui.button('Volver', on_click=lambda: ui.navigate.to('/'))