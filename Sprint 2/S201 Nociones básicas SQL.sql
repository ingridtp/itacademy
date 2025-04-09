-- Tarea S2.01

-- -------------------------------------------------- Nivel 1 --------------------------------------------------

-- Nivel 1. Ejercicio 2 
-- Listado de los países que están realizando compras (Usando JOIN)
SELECT DISTINCT c.country
FROM transaction t JOIN company c ON t.company_id = c.id;

-- Desde cuántos países se realizan las compras (Usando JOIN)
SELECT COUNT(DISTINCT c.country) AS paises
FROM transaction t JOIN company c ON t.company_id = c.id;

-- Identifica a la compañía con la mayor media de ventas (Usando JOIN)
SELECT c.company_name, ROUND(AVG(t.amount), 2) AS promedio_venta
FROM transaction t JOIN company c ON t.company_id = c.id
GROUP BY c.company_name
ORDER BY promedio_venta DESC
LIMIT 1;

-- Nivel 1. Ejercicio 3
-- Muestra todas las transacciones realizadas por empresas de Alemania (Sin usar JOIN)
SELECT *
FROM transaction t
WHERE t.declined=0 AND t.company_id IN (SELECT c.id
											FROM company c
											WHERE c.country = "Germany");
                        
-- Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones. (Sin usar JOIN)
SELECT c.company_name
FROM company c
WHERE EXISTS (SELECT 1
				FROM transaction t
				WHERE t.company_id = c.id
				AND t.amount > (SELECT AVG(t1.amount)
									FROM transaction t1));

/*-- V1 Con operador IN
SELECT c.company_name
FROM company c
WHERE c.id IN (SELECT t.company_id
				FROM transaction t
				WHERE t.amount > (SELECT AVG(t1.amount) 
									FROM transaction t1));
-- V2 Con operador ANY 
SELECT c.company_name
FROM company c
WHERE c.id = ANY (SELECT t.company_id
					FROM transaction t
					WHERE t.amount > (SELECT AVG(t1.amount) 
										FROM transaction t1));*/
                
-- Eliminarán del sistema las empresas que carecen de transacciones registradas, entrega el listado de estas empresas. (Sin usar JOIN)
-- Con operador EXISTS
SELECT c.id, c.company_name 
FROM company c
WHERE NOT EXISTS (SELECT 1 
					FROM transaction t 
					WHERE t.company_id = c.id);

-- -------------------------------------------------- Nivel 2 --------------------------------------------------
        
-- Nivel 2. Ejercicio 1
-- Identifica los cinco días que se generó la mayor cantidad de ingresos en la empresa por ventas. Muestra la fecha de cada transacción junto con el total de las ventas.
SELECT date(t.timestamp) AS fecha, SUM(t.amount) AS total_ventas
FROM transaction t 
GROUP BY fecha
ORDER BY total_ventas DESC
LIMIT 5;

-- Nivel 2. Ejercicio 2
-- ¿Cuál es la media de ventas por país? Presenta los resultados ordenados de mayor a menor medio.
SELECT c.country , ROUND(AVG(t.amount), 2) AS media_ventas
FROM transaction t JOIN company c ON t.company_id = c.id
GROUP BY c.country
ORDER BY media_ventas DESC;

-- Nivel 2. Ejercicio 3
/* En tu empresa, se plantea un nuevo proyecto para lanzar algunas campañas publicitarias para hacer competencia a la compañía “Non Institute”. 
Para ello, te piden la lista de todas las transacciones realizadas por empresas que están ubicadas en el mismo país que esta compañía.*/

-- Muestra el listado aplicando JOIN y subconsultas.
SELECT *
FROM transaction t JOIN company c ON t.company_id = c.id
WHERE c.country = (SELECT country
					FROM company
                    WHERE company_name ='Non Institute')
ORDER BY t.company_id;

-- Muestra el listado aplicando solo subconsultas.
SELECT *
FROM transaction t
WHERE t.company_id IN (SELECT c.id
						FROM company c
                        WHERE c.country = (SELECT c1.country
											FROM company c1
											WHERE c1.company_name ='Non Institute'))
ORDER BY t.company_id;
                                            
-- -------------------------------------------------- Nivel 3 --------------------------------------------------

-- Nivel 3. Ejercicio 1
/*Presenta el nombre, teléfono, país, fecha y amount, de aquellas empresas que realizaron transacciones con un valor 
comprendido entre 100 y 200 euros y en alguna de estas fechas: 29 de abril de 2021, 20 de julio de 2021 y 13 de marzo de 2022. 
Ordena los resultados de mayor a menor cantidad.*/
SELECT c.company_name, c.phone, c.country, date(t.timestamp) AS fecha, t.amount
FROM company c JOIN transaction t ON c.id = t.company_id
WHERE t.amount BETWEEN 100 AND 200 
    AND date(t.timestamp) IN ('2021-04-29', '2021-07-20', '2022-03-13')
    AND t.declined = 0 
ORDER BY t.amount DESC;

-- Nivel 3. Ejercicio 2
/*Necesitamos optimizar la asignación de los recursos y dependerá de la capacidad operativa que se requiera, 
por lo que te piden la información sobre la cantidad de transacciones que realizan las empresas, pero el departamento de 
recursos humanos es exigente y quiere un listado de las empresas en las que especifiques si tienen más de 4 transacciones o menos.*/
SELECT c.id, c.company_name, COUNT(t.id) AS cantidad_transacciones, 
	CASE 
		WHEN COUNT(t.id) > 4 THEN 'Más de 4'
		ELSE '4 o menos'
	END AS grupo
FROM company c 
JOIN transaction t ON c.id = t.company_id
GROUP BY c.id
ORDER BY cantidad_transacciones DESC;