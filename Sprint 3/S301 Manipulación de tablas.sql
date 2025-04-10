-- Tarea S3.01
-- -------------------------------------------------- Nivel 1 --------------------------------------------------
-- Nivel 1. Ejercicio 1
-- Creación de Tabla credit_card
    CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(15) PRIMARY KEY,   -- Identificador único de la tarjeta
	-- nombre VARCHAR(100) NOT NULL,  -- Nombre del titular de la tarjeta
    iban VARCHAR(34) NOT NULL UNIQUE,  -- Código IBAN único
    pan VARCHAR(16) NOT NULL UNIQUE,  -- Número PAN de la tarjeta
    pin VARCHAR(4) NOT NULL,  -- PIN de 4 dígitos
    cvv VARCHAR(4) NOT NULL,  -- CVV de 3 o 4 dígitos
    expiring_date VARCHAR(10) NOT NULL  -- Fecha de expiración
    );    
        
-- Creando relación con tabla transaction  
ALTER TABLE transaction 
ADD CONSTRAINT fk_transaction_credit_card FOREIGN KEY (credit_card_id) REFERENCES credit_card(id) 
ON DELETE CASCADE;

 -- Solución para insertar fechas en formato MM/DD/YY cuando el tipo de datos es DATE 
-- Cambiar el tipo de datos de la columna expiring_date a VARCHAR
ALTER TABLE credit_card
MODIFY COLUMN expiring_date VARCHAR(10);

-- Modificar el formato de la fecha
SET SQL_SAFE_UPDATES = 0; -- Desactivando el modo seguro que impide actualizar datos sin una condición basada en una clave primaria. 

UPDATE credit_card 
SET expiring_date = STR_TO_DATE(expiring_date, '%m/%d/%y');

SET SQL_SAFE_UPDATES = 1; -- Activando nuevamente el modo seguro.

-- Cambiando el tipo de dato nuevamente a Date
ALTER TABLE credit_card
MODIFY COLUMN expiring_date DATE;
  
-- Nivel 1. Ejercicio 2
-- Modificar el iban de la tarjeta con id 'CcU-2938'
UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';

-- Comprobar la modificación hecha
SELECT * FROM credit_card
WHERE id = 'CcU-2938';

-- Nivel 1. Ejercicio 3
-- Insertar un nuevo registro en la tabla transaccion
INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, 111.11, 0);

 -- Nivel 1. Ejercicio 4
 -- Eliminando columna PAN 
 ALTER TABLE credit_card
DROP COLUMN pan;

-- Comprobando que se eliminó la columna
DESCRIBE transaction;

-- -------------------------------------------------- Nivel 2 --------------------------------------------------
-- Nivel 2. Ejercicio 1
-- Eliminar un registro determinado de la tabla transaccion
DELETE FROM transaction WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Comprobar que se eliminó el registro
SELECT * FROM transaction WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Nivel 2. Ejercicio 2
-- Creación de Vista Marketing
CREATE OR REPLACE VIEW VistaMarketing AS
SELECT c.company_name, c.phone, c.country, AVG(t.amount) AS promedio
FROM company c JOIN transaction t ON c.id = t.company_id
GROUP BY c.company_name, c.phone, c.country;

-- Mostrar la vista
SELECT * FROM VistaMarketing
ORDER BY promedio DESC;

-- Nivel 2. Ejercicio 3
-- Filtrar Vista Marketing
SELECT * 
FROM VistaMarketing
WHERE country = 'Germany'
ORDER BY promedio DESC;

-- -------------------------------------------------- Nivel 3 --------------------------------------------------
-- Nivel 3. Ejercicio 1
-- Creación de la tabla 
CREATE TABLE IF NOT EXISTS user (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(150),
    email VARCHAR(150),
    birth_date VARCHAR(100),
    country VARCHAR(150),
    city VARCHAR(150),
    postal_code VARCHAR(100),
    address VARCHAR(255));
    
-- CreaR relación con tabla transaction   
ALTER TABLE transaction 
ADD CONSTRAINT fk_transaction_user
FOREIGN KEY (user_id) 
REFERENCES user(id) 
ON DELETE CASCADE;

-- Eliminar la columna website de la tabla company
ALTER TABLE company
DROP COLUMN website;

-- Modificar columnas de la tabla credit_card
ALTER TABLE credit_card
MODIFY COLUMN id VARCHAR(20), -- Modificar la longitud de la columna 'id' a VARCHAR(20)
MODIFY COLUMN iban VARCHAR(50) NULL, -- Modificar la longitud de la columna 'iban' a VARCHAR(50) y permitir valores nulos
MODIFY COLUMN pin VARCHAR(4) NULL, --  Modificar la longitud de la columna 'iban' a VARCHAR(4) y permitir valores nulos
MODIFY COLUMN cvv INT NULL, -- Cambiar el tipo de datos de la columna 'cvv' a INT y permitir valores nulos
MODIFY COLUMN expiring_date VARCHAR(20) NULL, -- Modificar el tipo de datos de la columna 'expiring_date' a VARCHAR(20) y permitir valores nulos
ADD COLUMN fecha_actual DATE; -- Agregar una nueva columna 'Fecha_actual' de tipo DATE;

-- Nivel 3. Ejercicio 2
-- Creación de la vista InformeTecnico
CREATE OR REPLACE VIEW InformeTecnico AS
SELECT t.id AS Transaccion, u.name AS Nombre, u.surname AS Apellido, cc.iban AS IBAN, c.company_name AS Compannia, t.amount AS Monto
FROM transaction t 
JOIN user u ON t.user_id = u.id
JOIN credit_card cc ON t.credit_card_id = cc.id
JOIN company c ON  t.company_id = c.id;

SELECT * FROM InformeTecnico
ORDER BY Transaccion DESC;




