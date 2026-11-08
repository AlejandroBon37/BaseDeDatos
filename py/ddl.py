"""  
DDL (Data Definition Language)
Crea la estructura de la base de datos.
"""

from conexion import conexion,
ejecutar

def main():
  with conexion() as con: 

  ejecutar(con, """
  CREATE TABLE IF NOT EXISTS rol
(
  rol_id INT UNSIGNED
AUTO_INCREMENT PRIMARY KEY,
             nombre_rol VARCHAR(50) NOT
NULL
  )
  """)

ejecutar(con, """
CREATE TABLE IF NOT EXISTS departamento (
departamento_id INT UNSIGNED AUTO_INCREMENT
PRIMARY KEY,
nombre_depto VARCHAR(100) NOT NULL
)
""")

ejecutar(con, """ 
CREATE TABLE IF NOT EXISTS usuario (
usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
numero_documento VARCHAR(15) NOT NULL,
 nombres VARCHAR(100) NOT NULL,
 apellidos VARCHAR(100) NOT NULL,
 rol_id INT UNSIGNED NOT NULL,
 departamento_id INT UNSIGNED NOT NULL,
 FOREIGN KEY (rol_id)
  REFERENCES rol(rol_id),
 FOREIGN KEY (departamento_id)
  REFERENCES departamento(departamento_id)
)
""")

con.commit()
print("Tablas creadas correctamente")
if __name__ == "__main__":
  main()
