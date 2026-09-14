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