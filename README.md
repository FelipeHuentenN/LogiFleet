# LogiFleet
Capstone 

## Cómo ejecutar

1. Crear la base de datos en MySQL 8 y cargar los scripts de `database/` (en este orden):

   ```sql
   CREATE DATABASE logifleet_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   USE logifleet_db;
   SOURCE database/logifleet_estructura_mysql.sql;
   SOURCE database/logifleet_datos_mysql.sql;
   ```

2. Instalar dependencias (idealmente en un entorno virtual):

   ```
   python -m venv venv
   venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. Configurar la conexión con variables de entorno (ver `python/db.py`):
   `LOGIFLEET_DB_HOST`, `LOGIFLEET_DB_PORT`, `LOGIFLEET_DB_USER`,
   `LOGIFLEET_DB_PASSWORD`, `LOGIFLEET_DB_NAME` (por defecto `logifleet_db`)
   y `LOGIFLEET_EMPRESA_ID` (empresa a mostrar, por defecto 1).

4. Iniciar la aplicación desde la carpeta `python`:

   ```
   cd python
   python login.py
   ```

   Queda disponible en http://localhost:8080
