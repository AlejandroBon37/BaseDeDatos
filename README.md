# Sistema de Control de Acceso y Seguridad

**Autores:** Andrés Mateo, Daniel Stiven Ortiz, Angie Katalina Fajardo y Alejandro Bonilla Quintero
**Institución:** Fundación Universitaria Compensar  
**Asignatura:** Bases de Datos

## Descripción

Proyecto académico que propone un sistema para gestionar el acceso a espacios restringidos. Permite organizar usuarios y sus credenciales, registrar intentos de ingreso y almacenar alertas relacionadas con posibles incidentes de seguridad.

## Tecnologías

- MariaDB y XAMPP para la gestión de la base de datos.
- Visual Studio Code para editar los scripts SQL.
- MySQL Workbench para ejecutar y comprobar consultas.
- Git y GitHub para el control de versiones.

## Base de datos

La base de datos `control_acceso_institucion` contiene ocho tablas: `rol`, `departamento`, `usuario`, `credencial`, `zona`, `dispositivo`, `registro_acceso` y `alerta_seguridad`. Sus relaciones permiten organizar la información y mantener su integridad.

## Scripts SQL

- `00_DATABASE.sql`: crea la base de datos.
- `01_DDL.sql`: define las tablas y relaciones.
- `02_DATOS_FIC.sql`: contiene datos de prueba.
- `03_DML.sql`: realiza inserciones, actualizaciones y eliminaciones.
- `04_DQL.sql`: consulta la información.
- `05_VDL.sql`: crea vistas para accesos y alertas.
- `06_DCL.sql`: configura usuarios y permisos.
- `07_TCL.sql`: demuestra el uso de transacciones.

## Ejecución

Iniciar MariaDB desde XAMPP y ejecutar primero `00_DATABASE.sql`, después `01_DDL.sql` y luego `03_DATOS_FIC.sql`. Finalmente, ejecutar los scripts restantes según su función.

**Nota:** los datos son ficticios y se utilizan para probar el funcionamiento de la base de datos con fines académicos.
