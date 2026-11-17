"""
DML (Data Manipulation Language)
Insercion de datos de prueba
"""

from conexion import conexion, ejecutar
def main(): 
  with conexion() as con:
    ejecutar(con,
             "INSERT INTO rol(nombre_rol) VALUES (%s)",
             ("Administrador",))
    ejecutar(con,
             "INSERT INTO rol(nombre_rol) VALUES (%s)",
             ("Vigilante",))
    ejecutar(con,
            """
            INSERT INTO departamento(nombre_depto)
            VALUES (%s)
            """,
            ("Tecnologia y Sistemas",))
    ejecutar(con,
            """
            INSERT INTO usuario
            (
               numero_documento,
               nombres,
               apellidos,
               rol_id,
               departamento_id
            )
            VALUES (%s,%s,%s,%s,%s)
            """,
           (
              "1000123456",
              "Carlos Andres",
              "Perez Gomez",
              1,
              1
           ))
    con.commit()
    print("Datos insertados correctamente")

if __name__ == "__main__":
  main()
