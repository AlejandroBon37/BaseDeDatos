"""
Prueba de conexión a MariaDB.

Ejecutar:
    python py/conexion_mariadb.py
"""

from conexion import conexion, consultar, imprimir


def main():

    with conexion() as con:

        datos = consultar(
            con,
            """
            SELECT
                VERSION() AS version,
                DATABASE() AS base_de_datos,
                CURRENT_USER() AS usuario_actual
            """
        )

        imprimir(
            "Prueba de conexión",
            datos
        )


if __name__ == "__main__":
    main()