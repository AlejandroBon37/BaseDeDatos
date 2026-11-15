import os
from conexion import conexion, ejecutar

def main():
    archivo_sql = os.path.join("Comands", "06_TCL.sql")
    
    if not os.path.exists(archivo_sql):
        print(f"Error: No se encontró el archivo {archivo_sql}")
        return

    try:
        with open(archivo_sql, 'r', encoding='utf-8') as f:
            sentencias_sql = f.read()
        
        with conexion() as con:
            ejecutar(con, sentencias_sql)
            print("Transacciones ejecutadas con éxito desde 06_TCL.sql")
            
    except Exception as e:
        print(f"Ocurrió un error al ejecutar TCL: {e}")

if __name__ == "__main__":
    main()