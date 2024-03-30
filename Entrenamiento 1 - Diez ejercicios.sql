CREATE DATABASE my_database;			-- Creamos base de datos my_database
SHOW DATABASES;
USE my_database;						-- Activamos my_database

CREATE TABLE distribution_companies(	-- Creamos la tabla con sus 2 columnas
	id int not null auto_increment,		-- Columna de id autoincremental que sera la llave primaria
    PRIMARY KEY(id),
    company_name varchar(20)			-- Columna de cadenas
);
ALTER TABLE distribution_companies MODIFY COLUMN company_name varchar(50);		-- Cambiamos la limitacion de caracteres

INSERT INTO distribution_companies (company_name)		-- Cargamos los datos en la tabla, solo en la columna company_name
VALUES
	('Columbia Pictures'),
    ('Paramount Pictures'),
    ('Warner Bros. Pictures'),
    ('United Artists'),
    ('Universal Pictures'),
    ('New Line Cinema'),
    ('Miramax Films'),
    ('Produzioni Europee Associate'),
    ('Buena Vista'),
    ('StudioCanal');
    
CREATE TABLE movies(		-- Creamos otra tabla, 8 columnas, tiene su llave primaria y externa
	id int not null auto_increment,
    PRIMARY KEY(id),
    movie_title varchar(100),
    imdb_rating decimal(3,1),		-- Decimal de maximo 3 digitos y 1 numero luego de la coma
    year_released int,
    budget decimal(10,2),			-- Decimal de maximo 10 digitos y 2 numeros luego de la coma
    box_office decimal(10,2),
    distribution_company_id int not null,
    FOREIGN KEY(distribution_company_id) REFERENCES distribution_companies(id), -- Referencia de esta tabla a la columna id de la tabla anterior
    language varchar(100)
);

INSERT INTO movies (movie_title, imdb_rating, year_released, budget, box_office, distribution_company_id, language) -- Cargamos la tabla
VALUES
	('The Shawshank Redemption', 9.2, 1994, 25.00, 73.30, 1, 'English'),
	('The Godfather', 9.2, 1972, 7.20, 291.00, 2, 'English'),
	('The Dark Knight', 9.0, 2008, 185.00, 1006.00, 3, 'English'),
	('The Godfather Part II', 9.0, 1974, 13.00, 93.00, 2, 'English, Sicilian'),
	('12 Angry Men', 9.0, 1957, 0.34, 2.00, 4, 'English'),
	('Schindler''s List', 8.9, 1993, 22.00, 322.20, 5, 'English, German, Yiddish'),
	('The Lord of the Rings: The Return of the King', 8.9, 2003, 94.00, 1146.00, 6, 'English'),
	('Pulp Fiction', 8.8, 1994, 8.50, 213.90, 7, 'English'),
	('The Lord of the Rings: The Fellowship of the Ring', 8.8, 2001, 93.00, 898.20, 6, 'English'),
	('The Good, the Bad and the Ugly', 8.8, 1966, 1.20, 38.90, 8, 'English, Italian, Spanish');
    
-- Ejercicio 1: Seleccionar todos los datos de las tablas distribution_companies y movies
SELECT * FROM distribution_companies;
SELECT * FROM movies;

-- Ejercicio 2: Para cada película, seleccione el título, la calificación IMDb y el año de estreno.
SELECT movie_title, imdb_rating, year_released FROM movies;

-- Ejercicio 3: Seleccione las columnas movie_title y box_office de la tabla movies. 
-- 				Mostrar sólo las películas con ganancias superiores a 300 millones de dólares.
SELECT movie_title, box_office FROM movies WHERE box_office > 300.00;

-- Ejercicio 4: Seleccione las columnas movie_title, imdb_rating, y year_released de la tabla movies. 
-- 			  	Mostrar las películas que tienen la palabra 'El Padrino' en el título.
SELECT movie_title, imdb_rating, year_released FROM movies WHERE movie_title LIKE '%The Godfather%';

-- Ejercicio 5: Seleccione las columnas movie_title, imdb_rating, y year_released de la tabla movies. 
-- 				Mostrar las películas que se estrenaron antes de 2001 y tuvieron una calificación superior a 9.
SELECT movie_title, imdb_rating, year_released FROM movies WHERE year_released < 2001 AND imdb_rating > 9;

-- Ejercicio 6: Seleccione las columnas movie_title, imdb_rating, y year_released de la tabla movies. 
-- 				Muestra las películas estrenadas después de 1991. Ordene la salida por el año de estreno en orden ascendente.
SELECT movie_title, imdb_rating, year_released FROM movies WHERE year_released > 1991 ORDER BY year_released ASC;

-- Ejercicio 7: Mostrar el recuento de películas por cada categoría de idioma. (Agrupacion)
SELECT language, COUNT(*) AS number_of_movies FROM movies GROUP BY language;

-- Ejercicio 8: Mostrar el conteo de películas por año de estreno e idioma. 
-- 				Ordenar los resultados por la fecha de estreno en orden ascendente.
SELECT year_released, language, COUNT(*) AS number_of_movies FROM movies GROUP BY year_released, language ORDER BY year_released ASC;

-- Ejercicio 9: Mostrar los idiomas hablados y el presupuesto medio de las películas por categoría de idioma. 
-- 				Mostrar sólo los idiomas con un presupuesto medio superior a 50 millones de dólares.
SELECT language, AVG(budget) AS average_of_budget FROM movies GROUP BY language HAVING average_of_budget > 50.00;

-- Ejercicio 10: Mostrar títulos de películas de la tabla movies, cada uno con el nombre de su distribuidora.
SELECT movie_title, company_name FROM movies m INNER JOIN distribution_companies dc ON m.distribution_company_id = dc.id;
