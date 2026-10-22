-- tablas:


CREATE TABLE usuarios (
id INTEGER PRIMARY KEY,
nombre CHARACTER VARYING(20) NOT NULL,
correo CHARACTER VARYING (30) NOT NULL,
contrasena VARCHAR (255) NOT NULL,
fechaNacimiento DATE,
fechaRegistro DATE NOT NULL 
);

CREATE TABLE plan (
id INTEGER PRIMARY KEY,
nombre CHARACTER VARYING(15) NOT NULL,
precio NUMERIC(15,2) NOT NULL,
caracteristicas TEXT
);

CREATE TABLE suscripciones (
id INTEGER PRIMARY KEY,
usuarios_id INTEGER NOT NULL,
plan_id INTEGER NOT NULL,
fechaInicio DATE NOT NULL,
fechaFin DATE,
estado TEXT NOT NULL,
FOREIGN KEY (usuarios_id) 
REFERENCES usuarios (id),
FOREIGN KEY (plan_id)
REFERENCES plan (id)
);

CREATE TABLE artistas (
id INTEGER PRIMARY KEY,
nombreArtistico CHARACTER VARYING(15) NOT NULL,
biografia TEXT,
pais TEXT NOT NULL,
fechaDebut DATE NOT NULL
);

CREATE TABLE albumes (
id INTEGER PRIMARY KEY,
artista_id INTEGER NOT NULL,
titulo TEXT NOT NULL,
tipo TEXT,
fechaLanzamiento DATE NOT NULL,
imagenPortada TEXT,
FOREIGN KEY (artista_id)
REFERENCES artistas (id)
);

CREATE TABLE canciones (
id INTEGER PRIMARY KEY,
album_id INTEGER NOT NULL,
titulo TEXT NOT NULL,
duracion INTEGER NOT NULL,
anoLanzamiento DATE NOT NULL,
genero_principal TEXT NOT NULL,
archivo_audio TEXT NOT NULL,
FOREIGN KEY (album_id)
REFERENCES albumes (id)
);

CREATE TABLE playlist (
id INTEGER PRIMARY KEY,
usuarios_id INTEGER NOT NULL,
nombre TEXT NOT NULL,
descripcion TEXT,
fecha_creacion DATE NOT NULL,
es_publica BOOLEAN DEFAULT FALSE,
FOREIGN KEY (usuarios_id)
REFERENCES usuarios (id)
);

CREATE TABLE reproducciones (
id INTEGER PRIMARY KEY,
usuarios_id INTEGER NOT NULL,
cancion_id INTEGER NOT NULL,
fecha_hora TIMESTAMP NOT NULL,
duracion_escucha INTEGER,
FOREIGN KEY (usuarios_id)
REFERENCES usuarios (id),
FOREIGN KEY (cancion_id)
REFERENCES canciones (id)
);

CREATE TABLE me_gusta (
id INTEGER PRIMARY KEY,
usuarios_id INTEGER NOT NULL,
tipo_entidad TEXT, 
id_entidad INTEGER NOT NULL,
fecha DATE,
FOREIGN KEY (usuarios_id)
REFERENCES usuarios (id)
);

CREATE TABLE seguir_artista (
id INTEGER PRIMARY KEY,
usuarios_id INTEGER NOT NULL,
artista_id INTEGER NOT NULL,
fecha DATE,
FOREIGN KEY (usuarios_id)
REFERENCES usuarios (id),
FOREIGN KEY (artista_id)
REFERENCES artistas (id)
);

CREATE TABLE seguir_usuario (
id INTEGER PRIMARY KEY,
usuario_id INTEGER NOT NULL,
usuario_seguido_id INTEGER NOT NULL,
fecha DATE NOT NULL,
FOREIGN KEY (usuario_id) 
REFERENCES usuarios (id),
FOREIGN KEY (usuario_seguido_id) 
REFERENCES usuarios (id)
);


-- Datos:

INSERT INTO usuarios VALUES (2001, 'mauri', 'mauri@gmail.com', 'benja123', '2010-12-01', '2026-09-29');
INSERT INTO usuarios VALUES (2003, 'benja', 'benja@gmail.com', 'mauri123', '2010-12-02', '2026-09-28');
INSERT INTO usuarios VALUES (2006, 'alejo', 'samirateamo@gmail.com', 'samira11', '2010-12-05', '2026-09-25');

INSERT INTO plan VALUES (1923, 'Plan Basico', 60000.23, 'Musica con anuncios y para 1 dispositivo individual');
INSERT INTO plan VALUES (2010, 'Plan Estandar', 90000.23, 'Musica con anuncios y para 3 dispositivos');
INSERT INTO plan VALUES (2012, 'Plan Premium', 100000.23, 'Musica sin anuncios y para 6 dispositivos');

INSERT INTO suscripciones VALUES (2012, 2001, 1923, '2021-11-15', '2025-03-12', 'activo');
INSERT INTO suscripciones VALUES (2018, 2003, 2010, '2012-10-11', '2016-05-17', 'desactivado');
INSERT INTO suscripciones VALUES (2026, 2006, 2012, '2026-09-29', '2028-02-17', 'activo');

INSERT INTO artistas VALUES (2035, 'agusfortnite', 'pendejo promesa, que canto con zell', 'Argentina', '2026-07-27');
INSERT INTO artistas VALUES (2028, 'fantarosario', 'el mejor cantante negro', 'PuertoRico', '2026-12-21');
INSERT INTO artistas VALUES (2031, 'slimesanti', 'no pregunte por su nombre', 'Argentina', '2026-02-12');

UPDATE usuarios SET correo = 'tuliox@gmail.com'
WHERE id= 2006;

SELECT id,nombre,correo
FROM usuarios
WHERE id = 2006

-- Mostrar con otro nombre que no sea "id"
SELECT id CodigoUsuario
FROM usuarios
ORDER BY nombre

--ordenar un campo de manera descendente y otro ascendente
SELECT id CodigoUsuario, nombre, correo 
FROM usuarios
ORDER BY nombre ASC, correo DESC

SELECT id, pais 
FROM artistas
WHERE id > 2031 AND pais= 'argentina'

-- IS NULL (pag 26)
-- nos muestra en usuarios los que no tienen id cargado
SELECT * FROM usuarios
WHERE id IS NULL;
-- nos muestra los que si tienen un id cargado
SELECT * FROM usuarios
WHERE id IS NOT NULL;

-- BETWEEN (pag 27)
-- significaria "entre". Da un limite o un rango de lo que debe devolver
SELECT * FROM usuarios
WHERE id BETWEEN 2000 AND 2004;
-- tambien nos ayuda a mostrar lo que no esta dentro del rango que le pedimos
SELECT * FROM usuarios
WHERE id NOT BETWEEN 2000 AND 2003;
-- entre fechas
SELECT * FROM suscripciones
WHERE fechainicio BETWEEN '2010/01/01' AND '2022/01/01';

-- IN (pag 28)
-- significaria "sea". Sirve para verificar datos, Por ejemplo mostrar que los id sean 2001, 2004 (no hay), y 2006 en usuarios
SELECT * FROM usuarios
WHERE id IN (2001, 2004, 2006); 
-- tambien para verificar que los id coincidan en tablas conectadas
SELECT * FROM usuarios
WHERE id IN (SELECT usuarios_id FROM suscripciones ) 

-- LIKE/NOT LIKE (pag 29)
-- Busca textos que coincidan con un patrón. Con estos comodines (%:los caracteres que sean. '_': caracteres definidos.
SELECT * FROM usuarios
WHERE nombre LIKE 'a%'

SELECT * FROM usuarios
WHERE nombre LIKE '_____' -- 5 caracteres definido
-- NOT LIKE seria lo contrario "mostrar los nombres que no contengan una a" o "los nombres que no sean de 5 caracteres"
SELECT * FROM usuarios
WHERE nombre NOT LIKE '_____' 

SELECT * FROM usuarios
WHERE nombre NOT LIKE '%a%'

-- COUNT (pag 30)
-- sirve para contar los registros 
SELECT COUNT (*) FROM usuarios

-- cuantos registros hay con correo cargado
SELECT COUNT (correo) FROM usuarios

--  sum - min - max - avg (pag 31)
-- sum: sirve para sumar valores
SELECT SUM (precio) FROM plan
-- min: valor minimo 
SELECT MIN (precio) FROM plan
-- max: valor maximo
SELECT MAX (precio) FROM plan
  -- estos dos (min, max) puede funcionar en texto mostrando el primero o ultimo en orden alfabetico 
-- avg: valor promedio
SELECT AVG (precio) FROM plan

--GROUP BY (pag 32)
-- agrupa registros por una columna y cuenta cuántas veces se repite cada valor.
-- agregamos un dato mas en un plan para los ejemplos
INSERT INTO suscripciones VALUES (2001, 2065, 1923, '2021-11-12', '2025-03-18', 'activo');
-- trae cuantas suscripciones tiene cada plan
SELECT plan_id, COUNT (*)
FROM suscripciones
GROUP BY plan_id
-- asi solo trae cada plan con su id, para mostrar el nombre de cada plan:
SELECT plan.nombre , COUNT (*) as usuarios_suscriptos
FROM suscripciones
JOIN plan ON suscripciones.plan_id = plan.id -- une la tabla plan con la de suscripciones donde el plan_id coincida con el id de plan
GROUP BY plan.nombre;

--HAVING (pag 33)
-- filtra grupos despues de agrupar
SELECT plan.nombre , COUNT (*) as usuarios_suscriptos
FROM suscripciones
JOIN plan ON suscripciones.plan_id = plan.id
GROUP BY plan.nombre
HAVING COUNT (*) <=2; --muestra solo los planes que tiene menos o igual a 2

--DISTINCT (pag 34)
--elimina duplicados 
SELECT DISTINCT pais
FROM artistas;
