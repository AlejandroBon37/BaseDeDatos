"""
Conexion de Python a la base de datos control_acceso_institucion.

Prueba:
    python py/conexion.py
"""

import os
from contextlib import contextmanager

import pymysql
from pymysql.cursors import DictCursor

CONFIG = {
    "host": os.getenv("CONTROL_HOST", "localhost"),
    "port": int(os.getenv("CONTROL_PORT", "3306")),
    "user": os.getenv("CONTROL_USER", "root"),
    "password": os.getenv("CONTROL_PASSWORD", ""),
    "database": os.getenv(
        "CONTROL_DB",
        "control_acceso_institucion"
    ),
    "charset": "utf8mb4",
    "cursorclass": DictCursor,
}


def conectar(**cambios):
    """
    Abre una conexión nueva.
    """

    try:

        return pymysql.connect(
            **{**CONFIG, **cambios},
            autocommit=False
        )

    except pymysql.err.OperationalError as error:

        if error.args[0] == 1049:

            raise SystemExit(
                "La base de datos control_acceso_institucion no existe."
            ) from error

        raise


@contextmanager
def conexion(**cambios):
    """
    Context manager para abrir y cerrar
    conexiones automáticamente.
    """

    con = conectar(**cambios)

    try:
        yield con

    finally:
        con.close()


def consultar(con, sql, params=None):
    """
    Ejecuta consultas SELECT.
    """

    with con.cursor() as cur:

        cur.execute(sql, params)

        return cur.fetchall()


def ejecutar(con, sql, params=None):
    """
    Ejecuta INSERT, UPDATE o DELETE.
    """

    with con.cursor() as cur:

        return cur.execute(sql, params)


def imprimir(titulo, filas):
    """
    Imprime resultados en forma tabular.
    """

    print(f"\n== {titulo} ==")

    if not filas:
        print("(sin filas)")
        return

    columnas = list(filas[0].keys())

    anchos = {
        c: max(
            len(str(c)),
            *(len(str(f[c])) for f in filas)
        )
        for c in columnas
    }

    print(
        " | ".join(
            str(c).ljust(anchos[c])
            for c in columnas
        )
    )

    print(
        "-+-".join(
            "-" * anchos[c]
            for c in columnas
        )
    )

    for fila in filas:

        print(
            " | ".join(
                str(fila[c]).ljust(anchos[c])
                for c in columnas
            )
        )


if __name__ == "__main__":

    with conexion() as con:

        imprimir(
            "Servidor",
            consultar(
                con,
                """
                SELECT
                    VERSION() AS version,
                    DATABASE() AS base_de_datos,
                    CURRENT_USER() AS cuenta
                """
            )
        )