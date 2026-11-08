"""
DCL (Data Control Language) — equivalente a Commands/05_DCL.sql.

CREATE USER
GRANT
SHOW GRANTS

Requiere una cuenta administrativa de MariaDB.
"""

from conexion import conexion, consultar, ejecutar

BD = "control_acceso_institucion"

USUARIOS = {
    "vigilante": (
        "Seguridad2026",
        "SELECT"
    ),
}


def main():

    with conexion() as con:

        for usuario, (clave, privilegios) in USUARIOS.items():

            cuenta = f"'{usuario}'@'localhost'"

            ejecutar(
                con,
                f"CREATE USER IF NOT EXISTS {cuenta} IDENTIFIED BY %s",
                (clave,)
            )

            ejecutar(
                con,
                f"""
                GRANT {privilegios}
                ON `{BD}`.`registro_acceso`
                TO {cuenta}
                """
            )

            ejecutar(
                con,
                f"""
                GRANT {privilegios}
                ON `{BD}`.`alerta_seguridad`
                TO {cuenta}
                """
            )

            print(
                f"Usuario {cuenta}: GRANT {privilegios}"
            )

        con.commit()

        for usuario in USUARIOS:

            print(f"\n== Privilegios de {usuario} ==")

            for fila in consultar(
                con,
                f"SHOW GRANTS FOR '{usuario}'@'localhost'"
            ):
                print(
                    next(iter(fila.values()))
                )


if __name__ == "__main__":
    main()