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
