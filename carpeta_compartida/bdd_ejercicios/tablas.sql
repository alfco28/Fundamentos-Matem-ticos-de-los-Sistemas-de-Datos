/* Exigimos que se comprueben las claves externas,
comprobación de regla de integridad referencial*/
PRAGMA foreign_keys=ON;

/* Cambiamos modo para visualizar las tablas*/
.mode qbox
/* Las tablas muestran el nombre de los atributos */
.headers on 
/* indicamos los separadores al hacer .import*/
.separator "," "\n" 

/*select datetime();*/

/* borramos la tabla alumnos, si es que existe*/
.print "Borramos todas las tablas"

drop table if exists aulas;
DROP TABLE IF EXISTS matriculas;
drop table if exists grupos;
drop table if exists pertenece;
drop table if exists departamentos;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS asignaturas;
DROP TABLE IF EXISTS alumnos;


/* definimos la tabla alumnos*/
.print "Orden CREATE TABLE:"
CREATE TABLE alumnos(
	DNI CHAR(8) not null, 
	nomalum VARCHAR(100), 
	fechanac DATE,
	direccion VARCHAR(40), 
	provincia VARCHAR(20), 
	beca VARCHAR(2),
	primary key(DNI)
);

CREATE TABLE asignaturas(
	codasig CHAR(4) not null PRIMARY KEY,
	nomasig VARCHAR(30),
	creditos DECIMAL(4,1) NOT NULL, 
	caracter CHAR(2) check (caracter in ('fb','ob','op')), 
	curso integer check (curso between 1 and 4),
	UNIQUE(nomasig)
);

CREATE TABLE profesores(
        NRP CHAR(8) NOT NULL PRIMARY KEY,
        nomprof VARCHAR(35) NOT NULL,
        categoria CHAR(2) CHECK (categoria IN ('AS','TE','TU','CU')),
        area VARCHAR(20),
        coddep CHAR(4)
);
                                            
CREATE table departamentos(
	iddep varchar(5) not null primary key,
    	nombre varchar(50) not null unique,
	dniDirector char(8),
	foreign key (dniDirector) references profesores(NRP)
		on delete set null /*hacemos nulo el nrp del director si lo borramos*/
		on update set null/*actulizamos el nrp del director, si se actualiza */
);

CREATE TABLE pertenece(
	/*
	NRP char(8) not null primary key references profesores(NRP),
	iddep varchar(5) references departamentos(iddep)
	*/
	NRP char(8) not null primary key,
	iddep varchar(5) references departamentos(iddep),
	foreign key (NRP) references profesores(NRP)
		on update cascade
		on delete cascade
);

CREATE TABLE grupos(
	codgrupo CHAR(4), 
	codasig CHAR(4),
	tipo CHAR(1) CHECK (tipo IN ('T','P')),
	NRP CHAR(4),
	maxal INT CHECK (maxal BETWEEN 10 AND 150),
	PRIMARY KEY (codasig, codgrupo, tipo),
	FOREIGN KEY (codasig) REFERENCES asignaturas(codasig),
	FOREIGN KEY (NRP) REFERENCES profesores(NRP)
		on delete set null
		on update cascade 
);

.print "Defino la tabla matrículas"
CREATE TABLE matriculas(
	codasig CHAR(4) not null, 
	codgrupo CHAR(4) not null, 
	tipo CHAR(1) not null, 
	DNI CHAR(8) not null,
	/* DNI  es clave externa de la tabla matriculas y hace referencia
	 al atributo DNI de la tabla alumnos*/
	convocatoria INT not null default 1, 
	calificacion DECIMAL(3,1),
	PRIMARY KEY(codasig, codgrupo, tipo, DNI, convocatoria),
	foreign key (codasig,codgrupo,tipo) 
		references grupos(codasig,codgrupo,tipo),
	foreign key (DNI) REFERENCES alumnos(DNI)
		on delete cascade 
);

CREATE TABLE aulas(
	codaula CHAR(4) not null PRIMARY KEY,
	capacidad DECIMAL 
	    /*CHECK ((capacidad>=0)AND(capacidad<=150)AND(capacidad<>0))*/
		check (capacidad between 1 and 150)
);

.print "Orden INSERT:"
/* Insertamos un alumno de prueba*/
.print "Insertamos alumno de prueba"
insert into alumnos values ('12345678','Juan','2000-01-02','dir 1','Cádiz','Sí');
insert into alumnos values ('12345679','Pepe','2001-02-03','dir1','Cádiz','No'),('22345678','Antonio','2001-02-03','dir1','Cádiz','No');

insert into asignaturas values ('ca1','Asignatura 1','6','op','3');
insert into asignaturas values ('ca2','Asignatura 2','6','ob','4');

insert into profesores values
        ('nrp1','Pepe','TU','Geometría','dep1'),
        ('nrp2','Juan 1','AS','Álgebra','dep2');

insert into departamentos values
	('dep1','nombre dep 1','nrp1'),
	('dep2','nombre dep 2',null);

insert into pertenece values
	('nrp1','dep1'),
	('nrp2','dep1');

insert into grupos values
	('A','ca1','T','nrp1','20'),
	('A','ca1','P','nrp2','25');

insert into matriculas values
	('ca1','A','T','12345678','112345.1234','12345.1234');

insert into aulas values('fc09','150');
insert into aulas values('fc11','15');
insert into aulas values('fc12','15');

insert into matriculas(codasig,codgrupo,tipo,DNI) values
	('ca1','A','P','12345679');


insert into grupos values
	('A','ca2','T','nrp1','30');
insert into matriculas(codasig,codgrupo,tipo,DNI) values
	('ca2','A','T','12345679');

insert into matriculas(codasig,codgrupo,tipo,DNI) values
	('ca2','A','T','22345678');


.print "Orden UPDATE:"
/*
update profesores set NRP='abcde' where NRP='nrp1';
*/

.separator ";" "\n"
.import alumnos.csv alumnos


/*.read busquedas.sql*/

