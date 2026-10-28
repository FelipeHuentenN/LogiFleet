from nicegui import ui
import Vehiculos, Trabajadores, Estado_empresa

@ui.page('/')
def table_page():
    ui.colors(primary="#1F3A5F")

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

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Vehiculos activos').classes('text-sm font-bold')
                ui.icon('directions_car').classes('text-blue-600 text-xl')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Vehiculos en taller').classes('text-sm font-bold')
                ui.icon('car_crash').classes('text-blue-600 text-xl')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('total Conductores').classes('text-sm font-bold')
                ui.icon('groups').classes('text-blue-600 text-xl')

        with ui.card().classes('flex-1 h-[90px]'):
            with ui.row().classes('items-center gap-2'):
                ui.label('Conductores activos').classes('text-sm font-bold')
                ui.icon('person').classes('text-blue-600 text-xl')

        with ui.card().classes('flex-1 h-[90px]'):  # noqa: SIM117
            with ui.row().classes('items-center gap-2'):
                ui.label('Conductores inactivos').classes('text-sm font-bold')
                ui.icon('person_off').classes('text-blue-600 text-xl')


    #                         
    with ui.row().classes('w-full gap-6'):

        #                         VEHÍCULOS
        with ui.card().classes('flex-1 h-[900px]'):
            ui.label('Vehículos').classes('text-2xl font-bold self-center')

            with ui.row().classes('w-full grid grid-cols-3 items-center'):
                ui.label('Patente').classes('font-bold text-xl')
                ui.label('Indicador').classes('font-bold text-xl')
                ui.label('Estado').classes('font-bold text-xl')

            #colocar  el rango con la cantidad de VEHÍCULOS que tendra la cempresa (ojala solo los 100 primeros y que sea en scroll)
            with ui.column().classes('w-full h-[900px] overflow-y-auto gap-2'):
                for i in range(50):
                    with ui.row().classes('w-full grid grid-cols-3 items-center cursor-pointer ''hover:bg-gray-100 rounded p-2').on('click', lambda i=i: ui.notify(f'Seleccionaste el vehículo {i + 1}')):
                        # Columna 1: Vehículo
                        ui.label(f'Vehículo {i + 1}').classes('text-xl')

                        # Columna 2: Indicador
                        with ui.row().classes('w-full ml-9 '):
                            if i == 0 or i == 3:
                                ui.icon('check').classes('text-2xl text-green-600')
                            elif i == 1:
                                ui.icon('warning').classes('text-2xl text-yellow-600')
                            else:
                                ui.icon('error').classes('text-2xl text-red-600')

                        # Columna 3: Estado
                        if i == 0 or i == 3:
                            ui.label('Mantenimiento').classes('text-base')
                        elif i == 1:
                            ui.label('En uso').classes('text-base')
                        else:
                            ui.label('No uso').classes('text-base')
            ui.button('Más información', on_click=lambda:ui.navigate.to('/vehiculos')).classes('self-end')


        #                         TRABAJADORES
        with ui.card().classes('flex-1 h-[900px]'):

            ui.label('Trabajadores').classes('text-2xl font-bold self-center')

            with ui.row().classes('w-full grid grid-cols-3 items-center'):
                ui.label('Nombre').classes('font-bold text-xl')
                ui.label('Estado').classes('font-bold text-xl')
                ui.label('Patente').classes('font-bold text-xl')

            with ui.column().classes('w-full h-[900px] overflow-y-auto gap-2'):
                for o in range(50):
                    with ui.row().classes('w-full grid grid-cols-3 items-center cursor-pointer ''hover:bg-gray-100 rounded p-2').on('click', lambda o=o: ui.notify(f'Seleccionaste al trabajador {o + 1}')):
                        ui.label(f'Nombre {o + 1}').classes('text-base')
                        ui.label('Activo').classes('text-lg')
                        ui.label('ABC-123').classes('text-base')
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
