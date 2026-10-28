from nicegui import ui
@ui.page('/Estado_empresa')
def pagina_vehiculos():
    ui.colors(primary="#1F3A5F")
    with ui.header().classes("items-center gap-6 px-6"):
            ui.label("🚚 LogiFleet").classes("text-xl font-bold")
            ui.space()
    
            ui.link("Inicio", target="/").classes("text-white no-underline")
            ui.link("Vehículos", target="/vehiculos").classes("text-white no-underline")
            ui.link("Trabajadores", target="/Trabajadores").classes("text-white no-underline")
            ui.link("Reportes", target="/Estado_empresa").classes("text-white no-underline")
    ui.label('Información del Estado de la  empresa').classes('text-2xl font-bold')
    ui.button('Volver', on_click=lambda: ui.navigate.to('/'))