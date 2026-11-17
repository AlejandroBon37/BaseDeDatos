"""
VDL (View Definition Langauge)
Creacion de vistas
"""

from conexion import conexion, ejecutar

def main():
  with conexion() as con:
    ejecutar(con, """ CREATE OR REPLACE VIEW
    Vista_usuarios AS
    SELECT
    u.usuario_id,
    u.numero_documento,
    CONCAT(u.nombres,' ', u.apellidos) AS
    nombre_completo,
    r.nombre_rol,
    d.nombre_depto
    FROM usuario u
    INNER JOIN rol r
     ON r.rol_id = u.rol_id
    INNER JOIN departamento d
     ON d.departamento_id = u.departamento_id
    """)

con.commit()
print("Vista creada correctamente")

if __name__ == "__main__":
  main()
    
