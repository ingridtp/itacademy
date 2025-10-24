# 📼 ToBio Life – Proyecto Final de Análisis de Datos

# 📼 ToBio Life – Proyecto Final de Análisis de Datos

Este repositorio documenta el desarrollo del proyecto final de la especialización del Bootcamp en Data Analytics de IT Academy, basado en el análisis de datos de los dos primeros meses de operación piloto de ToBio Life, un emprendimiento dedicado a productos artesanales y naturales para el cuidado personal.

---

## 📁 Estructura del Repositorio

```
│   ├── Data/                     # Datos y procesos ETL
│   │   ├── tobiolife_data/       # Datos crudos (.csv)
│   │   │
│   │   ├── tobiolife_operacional/       # Modelo relacional operativo
│   │   │   ├── Scripts SQL (.sql)       # Scripts SQL del modelo operativo
│   │   │   └── Diagrama ER (.png)       # Diagrama entidad-relación
│   │   │
│   │   ├── tobiolife_analytics/         # Modelo estrella analítico
│   │   │   ├── Scripts SQL (.sql)       # Scripts SQL del modelo operativo
│   │   │   └── Diagrama estrella (.png) # Diagrama del modelo estrella
│   │   │
│   │   └── tobiolife_etl/               # Proceso ETL
│   │       └── Scripts Python (.ipynb)  # Notebook con scripts ETL en Python
│   │
│   ├── PBI/                             # Dashboards y análisis Power BI
│   │   ├── Sprint 10.pbix               # Dashboard Power BI con visualizaciones
│   │   ├── Sprint 10 - Medidas Dax.pdf  # Documento con cálculos DAX
│   │   └── Sprint 10 - Gráficas PBI.pdf # Documento con visualizaciones e insights
│   │
│   ├── Informe/                          # Informe final del proyecto
│   │   └── Informe (.pdf)
│   │
│   └── Presentacion/                     # Presentación final del proyecto
│       └── Presentación (.pdf)
│
├── README.md                     
```

---

## 🛠️ Tecnologías utilizadas

- **Python** – Proceso ETL (pandas, sqlalchemy, mysql-connector-python).
- **MySQL** – Modelado de datos (modelo relacional y modelo estrella).
- **Power BI** – Visualización de datos e indicadores clave.
- **DAX** – Cálculos personalizados para reportes analíticos.
- **ERD/Diagramas** – Modelado conceptual y lógico del sistema de datos.

---

## 🚀 Cómo ejecutar el proyecto

1. Clona este repositorio:

```bash
git clone https://github.com/tu-usuario/tobiolife-analytics.git
```

2. Crea las BD en MySQL con los DDL en `/Datos/tobiolife_operacional/` y `/Datos/tobiolife_analytics/`.

3. Ejecuta el flujo ETL con los notebooks en `/Datos/tobiolife_etl/`.

4. Abre el archivo `.pbix` con Power BI para visualizar dashboards e indicadores `/PBI/`.

---

## 📦 Requisitos

- Python 3.x
- MySQL Server
- Power BI Desktop
- Paquetes Python: `pandas`, `sqlalchemy`, `mysql-connector-python`

---

## 📄 Documentos adicionales

- 📘 **Informe final del proyecto**: `/Informe/`
- 📈 **Dashboards y DAX**: `/PBI/`
- 🗅️ **Presentación final**: `/Presentacion/`

---

## 👥 Autoría

- **Autora:** Ingrid Tobío Pérez  
- **Mentora:** Alana Oliveri

## 📬 Contacto

- Email: ingrid.tobio@gmail.com  
- GitHub: [@ingridtp](https://github.com/ingridtp)  
- LinkedIn: [Ingrid Tobío Pérez](https://www.linkedin.com/in/ingrid-tobio/)

---

## 📋 Licencia y Condiciones de Uso

Este proyecto es académico y todos los materiales incluidos se encuentran bajo la licencia MIT, permitiendo el uso, copia, modificación y distribución del código y documentación con atribución al autor original.

**Condiciones específicas para los datos:**

Los datasets incluidos en tobiolife_data son únicamente para fines académicos y de aprendizaje.

No se permite redistribuir los archivos originales (.csv, bases de datos SQL, Power BI) a terceros sin autorización explícita.

El uso externo de los datos debe respetar los términos de los proveedores originales cuando corresponda.

Los notebooks y archivos Power BI son de referencia educativa y de práctica.

Cualquier uso fuera del contexto académico requiere permiso explícito del autor.
