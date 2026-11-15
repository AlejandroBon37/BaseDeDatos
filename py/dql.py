import os
from conexion import conexion, consultar, imprimir

def main():
    archivo_sql = os.path.join("Comands", "03_DQL.sql")
    
    if not os.path.exists(archivo_sql):
        print(f"Error: No se encontró el archivo {archivo_sql}")
        return

    try:
        with open(archivo_sql, 'r', encoding='utf-8') as f:
            sentencias_sql = f.read()
        
        with conexion() as con:
            filas = consultar(con, sentencias_sql)
            imprimir("Resultados de la consulta DQL", filas)
            
    except Exception as e:
        print(f"Ocurrió un error al ejecutar DQL: {e}")

if __name__ == "__main__":
    main()