from nicegui import ui
import Vehiculos, Trabajadores, Estado_empresa
import db

@ui.page('/')
def table_page():
    ui.colors(primary="#1F3A5F")

    # Datos desde MySQL (ver db.py)
    vehiculos = db.listar_vehiculos()
    conductores = db.listar_conductores()

    with ui.header().classes("items-center gap-6 px-6"):
        ui.label("🚚 LogiFleet").classes("text-xl font-bold")
        ui.space()

        ui.link("Inicio", target="/").classes("text-white no-underline")
        ui.link("Vehículos", target="/vehiculos").classes("text-white no-underline")
        ui.link("Trabajadores", target="/Trabajadores").classes("text-white no-underline")
        ui.link("Reportes", target="/Estado_empresa").classes("text-white no-underline")

    with ui.column().classes("w-full p-4 gap-4"):
    
        ui.label('Bienvenido @Administrador').classes('text-2xl')
        ui.label('estos soin los datos del hoy')

    #                         Resumen corto
    with ui.row().classes(' gap-5'):
        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Vehiculos totales').classes('text-sm font-bold')
                ui.icon('commute').classes('text-blue-600 text-xl')
            ui.label(str(len(vehiculos))).classes('text-2xl font-bold')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Vehiculos en ruta').classes('text-sm font-bold')
                ui.icon('directions_car').classes('text-blue-600 text-xl')
            ui.label(str(sum(v['estado'] == 'En ruta' for v in vehiculos))).classes('text-2xl font-bold')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Vehiculos en taller').classes('text-sm font-bold')
                ui.icon('car_crash').classes('text-blue-600 text-xl')
            ui.label(str(sum(v['estado'] == 'En mantención' for v in vehiculos))).classes('text-2xl font-bold')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('total Conductores').classes('text-sm font-bold')
                ui.icon('groups').classes('text-blue-600 text-xl')
            ui.label(str(len(conductores))).classes('text-2xl font-bold')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Conductores activos').classes('text-sm font-bold')
                ui.icon('person').classes('text-blue-600 text-xl')
            ui.label(str(sum(c['estado'] != 'Inactivo' for c in conductores))).classes('text-2xl font-bold')

        with ui.card().classes('flex-1 h-[90px]'):  # noqa: SIM117
            with ui.row().classes('items-center gap-2'):
                ui.label('Conductores inactivos').classes('text-sm font-bold')
                ui.icon('person_off').classes('text-blue-600 text-xl')
            ui.label(str(sum(c['estado'] == 'Inactivo' for c in conductores))).classes('text-2xl font-bold')


    #                         
    with ui.row().classes('w-full gap-6'):

        #                         VEHÍCULOS
        with ui.card().classes('flex-1 h-[900px]'):
            ui.label('Vehículos').classes('text-2xl font-bold self-center')

            with ui.row().classes('w-full grid grid-cols-3 items-center'):
                ui.label('Patente').classes('font-bold text-xl')
                ui.label('Indicador').classes('font-bold text-xl')
                ui.label('Estado').classes('font-bold text-xl')

            indicadores = {
                'Disponible': ('check', 'text-green-600'),
                'En ruta': ('local_shipping', 'text-blue-600'),
                'En mantención': ('build', 'text-orange-500'),
            }
            with ui.column().classes('w-full h-[900px] overflow-y-auto gap-2'):
                for v in vehiculos[:100]:
                    with ui.row().classes('w-full grid grid-cols-3 items-center cursor-pointer ''hover:bg-gray-100 rounded p-2').on('click', lambda v=v: ui.notify(f'Seleccionaste el vehículo {v["patente"]}')):
                        # Columna 1: Vehículo
                        ui.label(v['patente']).classes('text-xl')

                        # Columna 2: Indicador
                        icono, color = indicadores.get(v['estado'], ('help', 'text-gray-500'))
                        with ui.row().classes('w-full ml-9 '):
                            ui.icon(icono).classes(f'text-2xl {color}')

                        # Columna 3: Estado
                        ui.label(v['estado']).classes('text-base')
            ui.button('Más información', on_click=lambda:ui.navigate.to('/vehiculos')).classes('self-end')


        #                         TRABAJADORES
        with ui.card().classes('flex-1 h-[900px]'):

            ui.label('Trabajadores').classes('text-2xl font-bold self-center')

            with ui.row().classes('w-full grid grid-cols-3 items-center'):
                ui.label('Nombre').classes('font-bold text-xl')
                ui.label('Estado').classes('font-bold text-xl')
                ui.label('Patente').classes('font-bold text-xl')

            with ui.column().classes('w-full h-[900px] overflow-y-auto gap-2'):
                for c in conductores:
                    with ui.row().classes('w-full grid grid-cols-3 items-center cursor-pointer ''hover:bg-gray-100 rounded p-2').on('click', lambda c=c: ui.notify(f'Seleccionaste al trabajador {c["conductor"]}')):
                        ui.label(c['conductor']).classes('text-base')
                        ui.label(c['estado']).classes('text-lg')
                        ui.label(c['Vehiculo asigando']).classes('text-base')
            ui.button('Más información', on_click=lambda:ui.navigate.to('/Trabajadores')).classes('self-end')



        #                           ESTADO COMPAÑÍA 
        with ui.card().classes('flex-1 h-[900px]'):

            ui.label('Estado de compañía').classes('text-xl font-bold self-center text-center')

            # Aquí después puedes poner tus gráficos, aqui esta la documentacion para sacar los graficos https://nicegui.io/documentation/section_data_elements

            ui.button('Más información', on_click=lambda:ui.navigate.to('/Estado_empresa')).classes('self-end')


    #                           BOTÓN REPORTE 'Generar reporte'
    #      ui.button('Content', on_click=lambda: ui.download.content('Hello World', 'hello.txt'))  
    ui.button('Generar reporte').classes('fixed bottom-4 right-4')
ui.run(table_page)
