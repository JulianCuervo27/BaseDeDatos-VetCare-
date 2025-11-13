# 🐾 VetCare – Sistema de Gestión para Clínica Veterinaria

**VetCare** es una base de datos relacional desarrollada en **MySQL Workbench**, diseñada para administrar de forma integral la información de una clínica veterinaria.  
El proyecto permite registrar clientes, mascotas, citas, veterinarios, productos y ventas, garantizando integridad y coherencia en los datos mediante claves primarias, foráneas y restricciones.

---

## 📋 Objetivos del Proyecto

**Objetivo general:**  
Desarrollar una base de datos relacional en MySQL Workbench que permita gestionar la información de una clínica veterinaria, incluyendo el registro de clientes, mascotas, servicios, productos y pedidos, garantizando integridad y coherencia de los datos mediante claves primarias y foráneas.

**Objetivos específicos:**
1. Diseñar un modelo entidad-relación (E-R) que refleje las principales áreas de gestión de la clínica veterinaria.  
2. Implementar la estructura de tablas en MySQL con sus respectivas restricciones y relaciones.  
3. Ejecutar consultas integradoras que permitan obtener información cruzada entre clientes, mascotas, servicios y pedidos.

---

## 🧱 Estructura de la Base de Datos

**Entidades principales:**
- `clientes`: información de los dueños de mascotas.  
- `mascotas`: datos de las mascotas registradas.  
- `veterinarios`: personal médico encargado de las citas.  
- `citas`: registro de atenciones veterinarias.  
- `productos`: catálogo de artículos y medicamentos.  
- `ventas`: registro de transacciones realizadas.  
- `detalle_venta`: relación M:N entre productos y ventas.

**Relaciones:**
- Cliente → Mascota → Cita (1:N).  
- Veterinario → Cita (1:N).  
- Cliente → Venta (1:N).  
- Venta ↔ Producto (M:N, mediante `detalle_venta`).  

**Nivel de normalización:** hasta **3FN**, eliminando redundancias y asegurando consistencia.

---

## ⚙️ Instalación y Uso

### 🔸 Requisitos previos
- Tener instalado **MySQL Server 8.0** o superior.  
- Tener instalado **MySQL Workbench**.  
- Contar con usuario con permisos de creación de bases de datos.

### 🔸 Creación de la base de datos
1. Clonar este repositorio o descargar el archivo `vetcare.sql`.
2. Abrir **MySQL Workbench**.
3. Crear una nueva conexión si es necesario.
4. Ejecutar el siguiente comando en el panel SQL:

```sql
SOURCE C:/ruta/del/archivo/vetcare.sql;
