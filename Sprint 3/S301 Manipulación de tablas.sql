-- Tarea S2.01
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
    expiring_date DATE NOT NULL  -- Fecha de expiración
    );    
        
-- Creando relación con tabla transaction   
ALTER TABLE transaction 
ADD CONSTRAINT fk_transaction_credit_card
FOREIGN KEY (credit_card_id) 
REFERENCES credit_card(id) 
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





