-- Tarea S4.01
-- -------------------------------------------------- Nivel 1 --------------------------------------------------
-- Crear la base de datos
CREATE DATABASE sprint4;
-- Seleccionar la base de datos para usarla:
USE sprint4;

-- Creación de tablas
-- Tabla Compañia
CREATE TABLE company (
    comp_id VARCHAR(15) PRIMARY KEY,
    comp_name VARCHAR(255),
    comp_country VARCHAR(100),
    comp_phone VARCHAR(15),
    comp_email VARCHAR(100),
    comp_website VARCHAR(100));     
    
-- Tabla productos
CREATE TABLE product (
    prod_id INT UNSIGNED PRIMARY KEY,
    prod_name VARCHAR(255),
    prod_price DECIMAL(10,2),
    prod_colour VARCHAR(7),
    prod_weight DECIMAL(3,2),
    prod_warehouse_id VARCHAR(6));
    
-- Tabla user
CREATE TABLE user (
    user_id INT UNSIGNED PRIMARY KEY,
    user_name VARCHAR(50),
    user_surname VARCHAR(50),
    user_phone VARCHAR(15),
	user_email VARCHAR(100),
    user_birth_date DATE,
    user_country VARCHAR(100),
    user_city VARCHAR(100),
    user_postal_code VARCHAR (10),
    user_address VARCHAR (250));
    
-- Tabla tarjetas
CREATE TABLE credit_card (
    card_id VARCHAR(15) PRIMARY KEY,
    card_iban VARCHAR(35) NOT NULL UNIQUE,
	card_pan VARCHAR(35) NOT NULL UNIQUE,
    card_pin VARCHAR(4),
    card_cvv VARCHAR(4),
    card_track1 VARCHAR(100),
    card_track2 VARCHAR(100),
    card_expiring_date DATE /*,
	/*user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_card_user FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE*/);
    
    -- Tabla transacciones
CREATE TABLE transaction (
    tran_id VARCHAR(50) PRIMARY KEY,
    card_id VARCHAR(15) NOT NULL,
    comp_id VARCHAR(15) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    tran_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tran_amount DECIMAL(10,2),
    tran_decline TINYINT,
    tran_lat FLOAT,
    tran_longitude FLOAT,
    CONSTRAINT fk_transaction_company FOREIGN KEY (comp_id) REFERENCES company(comp_id) ON DELETE CASCADE,
    CONSTRAINT fk_transaction_card FOREIGN KEY (card_id) REFERENCES credit_card(card_id) ON DELETE CASCADE,
    CONSTRAINT fk_transaction_user FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE);

-- Tabla de la relación entre transaction y product
CREATE TABLE transaction_product (
    tran_id VARCHAR(50) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    -- cantidad SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (tran_id, prod_id),
	CONSTRAINT fk_tp_transaction FOREIGN KEY (tran_id) REFERENCES transaction(tran_id) ON DELETE CASCADE,
    CONSTRAINT fk_tp_product FOREIGN KEY (prod_id) REFERENCES product(prod_id) ON DELETE CASCADE);    
 
 -- Ingesta de datos
-- Datos de tabla compañia
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\companies.csv'
INTO TABLE company
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(comp_id, comp_name, comp_phone, comp_email, comp_country, comp_website);   

-- Datos de tabla producto
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\products.csv'
INTO TABLE product
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(prod_id, prod_name, @price, prod_colour, prod_weight, prod_warehouse_id)
SET prod_price = REPLACE(@price, '$', '');

-- Datos de tabla usuario
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_usa.csv'
INTO TABLE user
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(user_id, user_name, user_surname, user_phone, user_email, @user_birth_date, user_country, user_city, user_postal_code, user_address)
SET user_birth_date = STR_TO_DATE(@user_birth_date, '%b %d, %Y');

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_uk.csv'
INTO TABLE user
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(user_id, user_name, user_surname, user_phone, user_email, @user_birth_date, user_country, user_city, user_postal_code, user_address)
SET user_birth_date = STR_TO_DATE(@user_birth_date, '%b %d, %Y');

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users_ca.csv'
INTO TABLE user
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(user_id, user_name, user_surname, user_phone, user_email, @user_birth_date, user_country, user_city, user_postal_code, user_address)
SET user_birth_date = STR_TO_DATE(@user_birth_date, '%b %d, %Y');

-- Mostrar datos de tabla user
select *
FROM user;

-- Vaciar la tabla
TRUNCATE TABLE user;

-- Datos de tabla tarjeta de credito
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\credit_cards.csv'
INTO TABLE credit_card
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(card_id, @ignorar, card_iban, card_pan, card_pin, card_cvv, card_track1, card_track2, @card_expiring_date)
SET card_expiring_date = STR_TO_DATE(@card_expiring_date, '%m/%d/%y');

-- Datos de tabla transaccion
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\transactions.csv'
INTO TABLE transaction
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tran_id, card_id, comp_id, tran_timestamp, tran_amount, tran_decline, @ignorar, user_id, tran_lat, tran_longitude);

-- Datos de tabla relación transaccion-usuario
-- Creación de tabla temporal
CREATE TEMPORARY TABLE temp(
    tran_id VARCHAR(50),
    productos VARCHAR(50));
    
-- Cargar los datos desde el archivo CSV a la tabla temporal
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\transactions.csv'
INTO TABLE temp
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tran_id, @card_id, @comp_id, @tran_timestamp, @tran_amount, @tran_decline, productos, @user_id, @tran_lat, @tran_longitude);

-- Insertar los datos en la tabla de relación transaction_product
INSERT INTO transaction_product (tran_id, prod_id)
SELECT t.tran_id, p.prod_id
FROM temp t JOIN product p
 ON FIND_IN_SET(p.prod_id, REPLACE(t.productos, ' ', '')) > 0;
 
-- Borrar tabla temporal
DROP TEMPORARY TABLE IF EXISTS temp;
 
-- Ejercicio 1 --
-- Usuarios con más de 30 transacciones (con subconsulta y utilizando al menos 2 tablas)
SELECT u.user_id, u.user_name, u.user_surname
FROM user u
WHERE u.user_id IN (SELECT t.user_id
					FROM transaction t
					GROUP BY t.user_id
					HAVING COUNT(t.tran_id) > 30);
    
-- Ejercicio 2 --
-- Media de amount por IBAN de las tarjetas de crédito en la compañía Donec Ltd (utiliza por lo menos 2 tablas)
SELECT cc.card_iban AS IBAN, ROUND(AVG(t.tran_amount), 2) AS media
FROM transaction t
JOIN credit_card cc ON t.card_id = cc.card_id
JOIN company c ON t.comp_id = c.comp_id
WHERE c.comp_name = 'Donec Ltd'
GROUP BY cc.card_iban;

-- -------------------------------------------------- Nivel 2 --------------------------------------------------
-- Crear una nueva tabla de estado de tarjeta
CREATE TABLE card_status (
    card_id VARCHAR(15) PRIMARY KEY,
    -- updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status BOOLEAN);
    
-- Llenando la tabla de estado, definiendolo en función de las últimas 3 transacciones
INSERT INTO card_status (card_id, status)
SELECT aux.card_id, IF(SUM(aux.tran_decline) = 3, 0, 1) AS status
FROM (SELECT t.card_id, t.tran_decline, ROW_NUMBER() OVER (PARTITION BY t.card_id ORDER BY t.tran_timestamp DESC) AS row_num
		FROM transaction t) aux
WHERE aux.row_num <= 3
GROUP BY aux.card_id;

-- Mostrando los registros de la tabla de estatus
SELECT * FROM card_status;

-- Cantidad de tarjetas registradas
SELECT COUNT(card_id)
FROM credit_card;

-- Ejercicio 1
-- Consultando cuántas tarjetas están activas
select SUM(status)
FROM card_status;

-- ------------------------------- Nivel 3 --------------------------------------------------
-- Ejercicio 1
-- Cantidad de transacciones por producto
SELECT p.prod_id as ID, p.prod_name as Producto, count(tp.tran_id) as Ventas
FROM product p 
JOIN transaction_product tp ON p.prod_id = tp.prod_id
GROUP BY p.prod_id, p.prod_name
Order BY Ventas DESC;