from nicegui import ui

@ui.page('/Trabajadores')
def pagina_trabajadores():
    ui.colors(primary="#1F3A5F")

    # Datos ficticios para el prototipo
    datos_trabajadores = [
        {
            "rut": "11111111", "digito verificador": "4","conductor": "Juan Pérez","estado recorrido": "En recorrido",
            "total de paquetes": "10", "paquetes entregados": "5", "paquetes faltantes": "3",
            "Vehiculo asigando": "ABCD-12", "combustible": "65%", "paquete no entregado": "Cliente no responde", "estado": "activo"
        },
        {
            "rut": "22222222", "digito verificador": "8","conductor": "Carlos Pérez","estado recorrido": "finalizado",
            "total de paquetes": "11", "paquetes entregados": "6", "paquetes faltantes": "1",
            "Vehiculo asigando": "EFGH-34", "combustible": "5%", "paquete no entregado": "Fallo de la entrega por motivos climaticos", "estado": "activo"
        },
        {
            "rut": "33333333", "digito verificador": "k","conductor": "Lucas Pérez","estado recorrido": "Iniciando recorrido",
            "total de paquetes": "12", "paquetes entregados": "0", "paquetes faltantes": "12",
            "Vehiculo asigando": "IJKL-56", "combustible": "94%", "paquete no entregado": "N/A", "estado": "activo"
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
                ui.label("Trabajadores").classes("text-3xl font-bold")
                ui.label("Administra la flota y los conductores").classes("text-gray-500")

            ui.button("Actualizar panel",icon="refresh",on_click=lambda: ui.notify("Panel actualizado ")).props("outline")


        # Tarjetas de resumen
        with ui.grid(columns=4).classes("w-full gap-4"):

            #       Trabajadores totales
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("groups", size="2xl").classes("text-blue-700")
                    with ui.column().classes("gap-0"):
                        ui.label("trabajadores totales").classes("text-gray-500")
                        ui.label(str(len(datos_trabajadores))).classes("text-3xl font-bold")

            #       Trabajadores Activos
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("person_check", size="2xl").classes("text-green-600")
                    with ui.column().classes("gap-0"):
                        ui.label("Trabajadores activos").classes("text-gray-500")
                        ui.label(str(sum(v["estado"] == "activo"
                                         for v in datos_trabajadores))).classes("text-3xl font-bold")

            #       Trabajadores finalizado
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("person_off", size="2xl").classes("text-orange-500")
                    with ui.column().classes("gap-0"):
                        ui.label("Trabajadores inactivos").classes("text-gray-500")
                        ui.label(str(sum(v["estado"] == "inactivo" 
                                        for v in datos_trabajadores))).classes("text-3xl font-bold")

            #       Trabajadores iniciando recorrido
            with ui.card().classes("w-full"):
                with ui.row().classes("items-center gap-3"):
                    ui.icon("local_shipping", size="2xl").classes("text-teal-600")
                    with ui.column().classes("gap-0"):
                        ui.label("Trabajadores en recorrido").classes("text-gray-500")
                        ui.label(str(sum(v["estado recorrido"] == "En recorrido"
                                        for v in datos_trabajadores))).classes("text-3xl font-bold")

        # Buscador y filtro
        with ui.card().classes("w-full"):
            with ui.row().classes("w-full items-center gap-4"):

                buscador = ui.input(placeholder="Buscar por conductor o RUT...").props("outlined clearable").classes("flex-1")
                filtro = ui.select(
                    ["Todos", "Iniciando recorrido", "En recorrido", "finalizado"],
                    value="Todos",
                    label="Estado del recorrido").props("outlined").classes("w-64")

        # Distribución de la lista y el detalle
        with ui.row().classes("w-full items-start gap-5"):

            # Lista de Trabajadores
            with ui.card().classes("w-1/3 min-w-[280px]"):
                with ui.row().classes("w-full items-center justify-between"):
                    ui.label("Trabajadores").classes("text-xl font-bold")
                    ui.label(f"{len(datos_trabajadores)} registrados").classes("text-sm text-gray-500")

                ui.separator()

                filas = []

                with ui.column().classes("w-full max-h-[600px] overflow-y-auto gap-2"):
                    for Trbajadores in datos_trabajadores:
                        with ui.row().classes("w-full items-center gap-3 p-3 rounded ""cursor-pointer hover:bg-gray-100") as fila:

                            color_estado = {
                                "Iniciando recorrido": "text-green-600",
                                "En recorrido": "text-yellow-600",
                                "finalizado": "text-red-500",}.get(Trbajadores["estado recorrido"], "text-gray-500")

                            with ui.column().classes("gap-1 flex-1"):
                                ui.label(Trbajadores["conductor"]).classes("font-bold")
                                ui.label(Trbajadores["Vehiculo asigando"]).classes("text-sm text-gray-500")
                                ui.label(Trbajadores["estado recorrido"]).classes(f"text-xs {color_estado}")

                            ui.icon("chevron_right").classes("text-gray-400")

                        fila.on("click",lambda v=Trbajadores: seleccionar_Trabajador(v))
                        filas.append((fila, Trbajadores))

                ui.label("Selecciona a un Trbajador para ver sus detalles.").classes("text-xs text-gray-500")

            # Panel de detalles
            with ui.card().classes("flex-1 min-w-0 gap-4"):

                with ui.row().classes("w-full items-center justify-between"):
                    with ui.column().classes("gap-1"):
                        ui.label("Detalle del Trabajador").classes("text-xl font-bold")
                        ui.label("Información general y estado operativo").classes("text-sm text-gray-500")
                        # cambiar por estado del trabajador
                    estado_detalle = ui.label("En recorrido").classes("text-green-700 font-bold")

                ui.separator()

                with ui.row().classes("w-full items-center gap-4"):
                    with ui.column().classes("items-center justify-center bg-blue-50 ""rounded-xl p-5"):
                        ui.icon("person", size="4rem").classes("text-blue-800")

                    with ui.column().classes("gap-1"):
                        conductor_detalle = ui.label("Juan Pérez").classes("text-2xl font-bold")
                        rut_detalle = ui.label("11111111"+"-"+"4").classes("text-gray-500")
                        vehiculo_asignado_detalle = ui.label("vehiculo asignado: ABCD-12")

                # Datos generales
                ui.label("Datos generales").classes("text-lg font-bold")

                with ui.grid(columns=2).classes("w-full gap-4"):
                    with ui.card().classes("bg-gray-50"):
                        ui.icon("inventory_2").classes("text-blue-700 text-xl")
                        ui.label("Total pquetes").classes("text-gray-500")
                        total_paquetes_detalle = ui.label("10").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("task_alt").classes("text-blue-700 text-xl")
                        ui.label("Paquetes entregados").classes("text-gray-500")
                        paquetes_entregados_detalle = ui.label("0").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("pending_actions").classes("text-orange-500 text-xl")
                        ui.label("Paquetes faltantes").classes("text-gray-500")
                        paquetes_faltantes_detalle = ui.label("3").classes("text-lg font-bold")

                    with ui.card().classes("bg-gray-50"):
                        ui.icon("local_gas_station").classes("text-green-600 text-xl")
                        ui.label("Combustible disponible").classes("text-gray-500")
                        combustible_detalle = ui.label("65%").classes("text-lg font-bold")

                # Actividad y acciones
                ui.separator()
                ui.label("Paquetes no entregados").classes("text-lg font-bold")
                paquetes_no__detalle = ui.label("Cliente no responde").classes("text-gray-600")

                with ui.row().classes("w-full flex-wrap gap-2"):
                    ui.button("Registrar comentario",icon="",on_click=lambda: ui.notify("Registro de comentario: función por implementar")).props("outline")

                    ui.button("Editar información",icon="edit",on_click=lambda: ui.notify("Edición de : función por implementar"))

        # Funciones de interacción

        def seleccionar_Trabajador(Trabajador):
            conductor_detalle.set_text(Trabajador["conductor"])
            rut_detalle.set_text(Trabajador["rut"]+"-"+(Trabajador["digito verificador"]))
            vehiculo_asignado_detalle.set_text(f"Vehiculo asigando: {Trabajador['Vehiculo asigando']}")
            estado_detalle.set_text(Trabajador["estado recorrido"])
            total_paquetes_detalle.set_text(Trabajador['total de paquetes'])
            paquetes_entregados_detalle.set_text(Trabajador["paquetes entregados"])
            paquetes_faltantes_detalle.set_text(Trabajador["paquetes faltantes"])
            combustible_detalle.set_text(Trabajador["combustible"])
            paquetes_no__detalle.set_text(Trabajador["paquete no entregado"])

            colores = {
                "Iniciando recorrido": "text-green-700",
                "En recorrido": "text-yellow-700",
                "finalizado": "text-red-600",}
            estado_detalle.classes(remove="text-green-700 text-yellow-700 text-red-600 " "text-blue-700 text-orange-600 text-gray-600")
            estado_detalle.classes(colores.get(Trabajador["estado recorrido"], "text-gray-600"))

        def aplicar_filtros():
            texto = (buscador.value or "").strip().lower()
            estado = filtro.value

            for fila, vehiculo in filas:
                rut_completo = (vehiculo["rut"] + "-" + vehiculo["digito verificador"]).lower()
                texto_busqueda = texto.replace(".", "").replace("-", "")
                coincide_texto = (texto in vehiculo["conductor"].lower()or texto_busqueda in rut_completo.lower())
                coincide_estado = (estado == "Todos" or vehiculo["estado recorrido"] == estado)
                fila.set_visibility(coincide_texto and coincide_estado)

        buscador.on_value_change(lambda _: aplicar_filtros())
        filtro.on_value_change(lambda _: aplicar_filtros())
        ui.button('Volver', on_click=lambda: ui.navigate.to('/'))