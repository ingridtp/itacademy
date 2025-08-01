# 📼 ToBio Life – Proyecto Final de Análisis de Datos

Este repositorio documenta el desarrollo del proyecto final de la especialización en Data Analytics de IT Academy, basado en el análisis de datos de los dos primeros meses de operación piloto de ToBio Life, un emprendimiento dedicado a productos artesanales y naturales para el cuidado personal.

---

## 📁 Estructura del Repositorio

```
├── Data/
│   └── Carpeta auxiliar para almacenamiento general.
│
├── tobiolife_data/
│   └── Datos crudos (.csv)
│
├── tobiolife_operacional/
│   ├── Scripts SQL para el modelo relacional operativo (.sql)
│   └── Modelo entidad-relación (.png)
│
├── tobiolife_analytics/
│   ├── Scripts SQL para el modelo estrella analítico (.sql)
│   └── Diagrama del modelo estrella (.png)
│
├── tobiolife_etl/
│   └── Scripts en Python para el proceso ETL (.ipynb)
│
├── PBI/
│   ├── Archivo Power BI (.pbix)
│   ├── Documento con cálculos DAX (.pdf)
│   └── Documento de visualizaciones y hallazgos (.pdf)
│
├── Informe/
│   └── Informe final del proyecto (.pdf)
│
├── Presentacion/
│   └── Presentación de exposición final (.pdf)
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

4. Abre el archivo `.pbix` con Power BI para visualizar dashboards e indicadores.

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

## 👥 Autores

- **Autora**: Ingrid Tobío Pérez – `@tuUsuarioGitHub`
- **Mentora**: Alana Oliveri

---

## 📬 Contacto

Para dudas o sugerencias, puedes contactarme a: [ingrid.tobio@gmail.com]

---

## 📋 Licencia

Este repositorio es parte de un proyecto académico y no está licenciado para fines comerciales.
