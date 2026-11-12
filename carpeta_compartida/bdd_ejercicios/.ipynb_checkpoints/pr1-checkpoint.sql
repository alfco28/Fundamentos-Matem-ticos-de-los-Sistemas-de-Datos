/* Añadimos esta línea para comprobar claves externas*/
PRAGMA foreign_keys=ON;
/* Muestra tablas con select de forma más bonita */
.mode table

.print 'Eliminamos todas las tablas, si no eliminamos alguna dará error al crearla'
drop table if exists grupos;
drop table if exists departamentos;
drop table if exists aulas;
drop table if exists profesores;
drop table if exists matriculas;
drop table if exists asignaturas;
drop table if exists alumnos;

.print 'orden 1: creación de la tabla alumnos'
CREATE TABLE alumnos(
    /* establecemos la clave primaria */
    DNI CHAR(8) PRIMARY KEY NOT NULL, 
    nomalum VARCHAR(50) DEFAULT '--', 
    fechanac DATE DEFAULT '--', 
    direccion VARCHAR(40) DEFAULT '--', 
    provincia VARCHAR(20) DEFAULT 'Cádiz', 
    beca VARCHAR(2) DEFAULT 'no'
    /*,
    primary key(DNI)*/
);

insert into alumnos(DNI) 
    values
    ('dni5'),('dni6'),('dni7');

.print 'Insertamos un dato en la tabla alumnos'
insert into alumnos values 
    ('dni1','nombre1',
    '2000-02-28','dir1','Cádiz','Sí'), 
    ('dni2','nombre1',
    '2000-02-28','dir1','Cádiz',NULL);

insert into alumnos values 
    ('dni3','nombre1',
    '2000-02-28','dir1','Cádiz','Sí'); 

.print 'Mostramos el contenido de la tabla alumnos'
select * from alumnos;

.print 'Creamos tabla asignaturas'
CREATE TABLE asignaturas(
    codasig CHAR(4) NOT NULL /*PRIMARY KEY*/,
    nomasig VARCHAR(30) NOT NULL,
    creditos DECIMAL(4,1) DEFAULT 6/*unique*/, 
    caracter CHAR(2) 
        CHECK (caracter in ('ob','op')) 
        DEFAULT 'ob', 
    curso DECIMAL(1,0) 
        CHECK (curso BETWEEN 1 AND 4)
        DEFAULT 1,
    PRIMARY KEY(codasig),
    /*UNIQUE(nomasig,caracter)*/
    UNIQUE(nomasig)
);

INSERT INTO asignaturas(codasig,nomasig) VALUES
    ('ca5','na 5'),
    ('ca6','na 6');

insert into asignaturas values
    ('ca1','na1',6,'ob','2');

insert into asignaturas values
    ('ca2','na2',7,'op',1);

select * from asignaturas;


.print 'Definimos la tabla matriculas'

CREATE TABLE matriculas(
    codasig CHAR(4) NOT NULL 
        REFERENCES asignaturas(codasig)
            ON DELETE CASCADE
            ON UPDATE CASCADE, 
    codgrupo CHAR(4) NOT NULL, 
    tipo CHAR(1) NOT NULL
        CHECK (tipo IN ('t','p','o')), 
    DNI CHAR(8) NOT NULL 
        REFERENCES alumnos(DNI)
            ON DELETE CASCADE
            ON UPDATE CASCADE, 
    convocatoria INT NOT NULL, 
    calificacion DECIMAL(3,1) DEFAULT '--',
    /*Establecemos la clave primaria*/
    PRIMARY KEY(codasig, codgrupo, tipo, DNI, convocatoria)
);

INSERT INTO matriculas(codasig, codgrupo, tipo, DNI, convocatoria) values
    ('ca5','gr7','p','dni3',1);

insert into matriculas values
    ('ca1','gr1','t','dni2',1,NULL);
insert into matriculas values('ca2','gr2','p','dni3',2,NULL);

.print '*******************'
.print 'Tabla matriculas'
select * from matriculas;
.print 'Actualizamos la tabla alumnos'
update alumnos set DNI='dni22',direccion='dirección 22' where DNI='dni2';
select * from alumnos;
select * from matriculas;
.print '*******************'

.print 'profesores'
CREATE TABLE profesores(
    NRP CHAR(8) NOT NULL PRIMARY KEY, 
    nomprof VARCHAR(35) NOT NULL DEFAULT '--', 
    categoria CHAR(2) 
        CHECK (categoria IN ('AS','TE','TU','CU'))
        DEFAULT 'tu',
    area VARCHAR(20) DEFAULT '--', 
    coddep CHAR(4)
);

insert into profesores values
    ('nrp1','np1','AS','Álgebra','cd1');
insert into profesores values
    ('nrp2','np2','AS','Álgebra','cd1');
insert into profesores values
    ('nrp3','np3','TU','Álgebra','cd1');

select * from profesores;

.print 'Creamos la tabla aulas'
CREATE TABLE aulas(
	codaula CHAR(4) PRIMARY KEY,
	/*capacidad INTEGER 
    		CHECK ((capacidad>=0)AND(capacidad<=150)
			AND(capacidad<>0))*/
    capacidad DECIMAL 
        CHECK (capacidad BETWEEN 0 AND 150)
);

insert into aulas values
	('aula1',100),
	('aula2',20);

CREATE table departamentos(
    iddep varchar(5) PRIMARY KEY NOT NULL,
    nombre varchar(50) NOT NULL UNIQUE,
    dniDirector char(8),
    FOREIGN KEY (dniDirector) REFERENCES profesores(NRP)
        ON DELETE SET NULL
        ON UPDATE SET NULL
);

insert into departamentos values
    ('dep1','Dep1','nrp1'),
    ('dep2','Dep2','nrp3'),
    ('dep3','Dep3',NULL);
/* Desconocemos el director de dep3 */

CREATE TABLE grupos(
    codgrupo CHAR(4) NOT NULL, 
    codasig CHAR(4) NOT NULL,
    tipo CHAR(1) NOT NULL
        CHECK (tipo IN ('T','P')),
    NRP CHAR(4),
    maxal INT CHECK (maxal BETWEEN 10 AND 150),
    PRIMARY KEY (codasig, codgrupo, tipo),
    FOREIGN KEY (codasig) REFERENCES asignaturas(codasig)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (NRP) REFERENCES profesores(NRP)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

insert into grupos values
    ('A','ca1','T',NULL,100),
    ('B','ca1','T','nrp1',100),
    ('A','ca1','P','nrp2',30);

.print 'Vemos los grupos que tenemos con profesor asignado'
select * from grupos where NRP is not NULL;
.print 'Vemos los grupos que tenemos sin profesor asignado (NRP es NULL)'
select * from grupos where NRP is NULL;

.print
.print 'Pruebas de borrado y actualización de profesores, asignaturas y grupos'

select * from departamentos;
select * from grupos;
delete from profesores where NRP='nrp2';
DELETE FROM profesores where nrp='nrp1';
select * from departamentos;
select * from grupos;

.print "Insertamos datos en alumnos desde fichero"
.separator ";" "\n"
.import alumnos.csv alumnos
select * from alumnos;

.print 'fin del fichero pr1.sql'