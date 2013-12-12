
/* Drop Tables */

DROP TABLE IF EXISTS EVALUACION_CONTENIDO;
DROP TABLE IF EXISTS EVALUACION;
DROP TABLE IF EXISTS PAUTA;
DROP TABLE IF EXISTS DOCUMENTO;
DROP TABLE IF EXISTS CONTENIDO;
DROP TABLE IF EXISTS ASIGNATURA;
DROP TABLE IF EXISTS ACADEMICO;
DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS TIPO_EVALUACION;




/* Create Tables */

CREATE TABLE ACADEMICO
(
	-- El identificador del académico sera su RUT sin guión, sin digito verificador.
	id_academico int NOT NULL UNIQUE,
	nombre_academico varchar(45) DEFAULT 'NN' NOT NULL,
	PRIMARY KEY (id_academico)
) WITHOUT OIDS;


CREATE TABLE USUARIO
(
	id_usuario int NOT NULL UNIQUE,
	-- Contraseña de tamaño máximo 8 caracteres.
	password varchar(8) NOT NULL,
	-- Nivel de privilegios del usuario. Permite diferenciar al académico que solo hace clases, del que tiene una labor administrativa (en este caso el director de escuela).
	nivel_usuario int NOT NULL,
	PRIMARY KEY (id_usuario)
) WITHOUT OIDS;


CREATE TABLE TIPO_EVALUACION
(
	id_tipo serial NOT NULL UNIQUE,
	nombre_tipo varchar(25) NOT NULL,
	PRIMARY KEY (id_tipo)
) WITHOUT OIDS;


CREATE TABLE DOCUMENTO
(
	id_documento serial NOT NULL UNIQUE,
	nombre_documento varchar(25) DEFAULT 'documento' NOT NULL,
	contenido_documento int NOT NULL UNIQUE,
	PRIMARY KEY (id_documento)
) WITHOUT OIDS;


CREATE TABLE CONTENIDO
(
	id_contenido serial NOT NULL UNIQUE,
	nombre_contenido varchar(45) NOT NULL,
	-- Será el codigo de la asignatura.
	asignatura_contenido varchar(8) NOT NULL UNIQUE,
	PRIMARY KEY (id_contenido)
) WITHOUT OIDS;


CREATE TABLE ASIGNATURA
(
	-- Será el codigo de la asignatura.
	id_asignatura varchar(8) NOT NULL UNIQUE,
	nombre_asignatura varchar(45) NOT NULL,
	-- El identificador del académico sera su RUT sin guión, sin digito verificador.
	academico_asignatura int NOT NULL UNIQUE,
	PRIMARY KEY (id_asignatura)
) WITHOUT OIDS;


CREATE TABLE PAUTA
(
	id_pauta serial NOT NULL UNIQUE,
	nombre_pauta varchar(45) NOT NULL,
	-- Será el codigo de la asignatura.
	asignatura_pauta varchar(8) NOT NULL UNIQUE,
	PRIMARY KEY (id_pauta)
) WITHOUT OIDS;


CREATE TABLE EVALUACION
(
	id_evaluacion serial NOT NULL UNIQUE,
	nombre_evaluacion varchar(45) NOT NULL,
	fecha_evaluacion date NOT NULL,
	-- Hora tentativa de la evaluación.
	hora_evaluacion time,
	-- Porcentaje de ponderación de la evaluación.
	ponderacion_evaluacion int,
	-- Observación con respecto a la evaluación.
	observacion_evaluacion varchar(200),
	tipo_evaluacion int NOT NULL UNIQUE,
	-- Será el codigo de la asignatura.
	asignatura_evaluacion varchar(8) NOT NULL UNIQUE,
	-- El identificador del académico sera su RUT sin guión, sin digito verificador.
	academico_evaluacion int NOT NULL UNIQUE,
	pauta_evaluacion int NOT NULL UNIQUE,
	PRIMARY KEY (id_evaluacion)
) WITHOUT OIDS;


CREATE TABLE EVALUACION_CONTENIDO
(
	id_contenido int NOT NULL UNIQUE,
	id_evaluacion int NOT NULL UNIQUE
) WITHOUT OIDS;



/* Create Foreign Keys */

ALTER TABLE EVALUACION
	ADD FOREIGN KEY (academico_evaluacion)
	REFERENCES ACADEMICO (id_academico)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ASIGNATURA
	ADD FOREIGN KEY (academico_asignatura)
	REFERENCES ACADEMICO (id_academico)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE EVALUACION
	ADD FOREIGN KEY (tipo_evaluacion)
	REFERENCES TIPO_EVALUACION (id_tipo)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE EVALUACION_CONTENIDO
	ADD FOREIGN KEY (id_contenido)
	REFERENCES CONTENIDO (id_contenido)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE DOCUMENTO
	ADD FOREIGN KEY (contenido_documento)
	REFERENCES CONTENIDO (id_contenido)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE EVALUACION
	ADD FOREIGN KEY (asignatura_evaluacion)
	REFERENCES ASIGNATURA (id_asignatura)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE PAUTA
	ADD FOREIGN KEY (asignatura_pauta)
	REFERENCES ASIGNATURA (id_asignatura)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE CONTENIDO
	ADD FOREIGN KEY (asignatura_contenido)
	REFERENCES ASIGNATURA (id_asignatura)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE EVALUACION
	ADD FOREIGN KEY (pauta_evaluacion)
	REFERENCES PAUTA (id_pauta)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE EVALUACION_CONTENIDO
	ADD FOREIGN KEY (id_evaluacion)
	REFERENCES EVALUACION (id_evaluacion)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Comments */

COMMENT ON COLUMN ACADEMICO.id_academico IS 'El identificador del académico sera su RUT sin guión, sin digito verificador.';
COMMENT ON COLUMN USUARIO.password IS 'Contraseña de tamaño máximo 8 caracteres.';
COMMENT ON COLUMN USUARIO.nivel_usuario IS 'Nivel de privilegios del usuario. Permite diferenciar al académico que solo hace clases, del que tiene una labor administrativa (en este caso el director de escuela).';
COMMENT ON COLUMN CONTENIDO.asignatura_contenido IS 'Será el codigo de la asignatura.';
COMMENT ON COLUMN ASIGNATURA.id_asignatura IS 'Será el codigo de la asignatura.';
COMMENT ON COLUMN ASIGNATURA.academico_asignatura IS 'El identificador del académico sera su RUT sin guión, sin digito verificador.';
COMMENT ON COLUMN PAUTA.asignatura_pauta IS 'Será el codigo de la asignatura.';
COMMENT ON COLUMN EVALUACION.hora_evaluacion IS 'Hora tentativa de la evaluación.';
COMMENT ON COLUMN EVALUACION.ponderacion_evaluacion IS 'Porcentaje de ponderación de la evaluación.';
COMMENT ON COLUMN EVALUACION.observacion_evaluacion IS 'Observación con respecto a la evaluación.';
COMMENT ON COLUMN EVALUACION.asignatura_evaluacion IS 'Será el codigo de la asignatura.';
COMMENT ON COLUMN EVALUACION.academico_evaluacion IS 'El identificador del académico sera su RUT sin guión, sin digito verificador.';



