PRAGMA foreign_keys=ON;

.print 'Borramos todas las tablas'
drop table if exists matriculas;
drop table if exists grupos;
drop table if exists departamentos;
drop table if exists aulas;
drop table if exists profesores;
drop table if exists t1;
drop table if exists t2;
drop table if exists asignaturas;
drop table if exists alumnos;

.print 'Creamos la tabla alumnos'
CREATE TABLE alumnos(
    DNI CHAR(8) primary key NOT NULL, 
    nomalum VARCHAR(50), 
    fechanac DATE, 
    direccion VARCHAR(40), 
    provincia VARCHAR(20), 
    beca CHAR(2) default 'no' check (beca in ('sí','no'))
);

.print
.schema alumnos
.print
.print 'Las tablas que tenemos son:'
.tables


/* comentario */
.print 'Insertamos datos en alumnos'
insert into alumnos values 
    ('11','Juan','2000-01-05','calle 1','Cádiz','sí'),
    ('22','Antonio','2001-02-03','calle 2','Sevilla','no');

.print 'Los datos de la tabla son:'
select * from alumnos;

/*
CREATE TABLE matriculas(
    codasig CHAR(4) NOT NULL, 
    codgrupo CHAR(4) NOT NULL, 
    tipo CHAR(1) NOT NULL, 
    DNI CHAR(8) NOT NULL, 
    convocatoria INT NOT NULL, 
    calificacion DECIMAL(3,1),
    PRIMARY KEY(codasig, codgrupo, tipo, DNI, convocatoria)
);*/

/*
CREATE TABLE asignaturas(
    codasig CHAR(4) NOT NULL PRIMARY KEY,
    nomasig VARCHAR(30) NOT NULL,
    creditos DECIMAL(4,1), 
    caracter CHAR(2), 
    curso DECIMAL(1,0),
    UNIQUE(nomasig)
);*/

CREATE TABLE asignaturas(
    codasig CHAR(4) PRIMARY KEY NOT NULL,
    nomasig VARCHAR(30) UNIQUE NOT NULL,
    creditos DECIMAL(4,1),
    caracter CHAR(2) CHECK (caracter IN ('tr','ob','op')),
    curso DECIMAL CHECK (curso BETWEEN 1 AND 5)
);

insert into asignaturas values ('a123','asi1', 10 , 'op', 1);

select * from asignaturas;

CREATE TABLE T1(
    a1 varchar(10) NOT NULL,
    a2 varchar(10) NOT NULL,
    a3 varchar(10) NOT NULL PRIMARY KEY,
    unique(a1,a2)
);

CREATE TABLE profesores(
    NRP CHAR(8) NOT NULL PRIMARY KEY, 
    nomprof VARCHAR(35) NOT NULL, 
    categoria CHAR(2) CHECK (categoria IN ('AS','TE','TU','CU')),
    area VARCHAR(20), 
    coddep CHAR(4)
);

insert into profesores values('123','Juan', 'AS', '', '');

select * from profesores;

CREATE TABLE aulas(
    codaula CHAR(4) PRIMARY KEY NOT NULL,
    capacidad DECIMAL /* NOT NULL */
        /* CHECK ((capacidad>=0)AND(capacidad<=150)AND(capacidad<>0)) */
        /* CHECK ((capacidad BETWEEN 0 AND 150) AND (capacidad<>0)) */
        CHECK (capacidad>=0)
);

CREATE table departamentos(
    iddep varchar(5) PRIMARY KEY NOT NULL,
    nombre varchar(50) NOT NULL,
    dniDirector char(8),
    foreign key (dniDirector) references profesores(NRP) 
        on delete set null
        on update cascade
);



CREATE TABLE grupos(
    codgrupo CHAR(4) NOT NULL,   
    codasig CHAR(4) not null,
    tipo CHAR(1) CHECK (tipo IN ('T','P')) NOT NULL,
    NRP CHAR(4),
    maxal INT CHECK (maxal BETWEEN 10 AND 150),
    PRIMARY KEY (codasig, codgrupo, tipo),
    FOREIGN KEY (codasig) REFERENCES asignaturas(codasig)
        on delete cascade
        on update cascade,
    FOREIGN KEY (NRP) REFERENCES profesores(NRP)
        on delete set null
        on update cascade
);

insert into alumnos values ('56','Juan','2003-01-05','calle 2','Cádiz','sí');
insert into asignaturas values ('a11','asi11', 10 , 'op', 3);
insert into profesores values('222','José', 'AS', '', '');

insert into grupos values ('cg1','a11','T','222',25);
insert into grupos values ('cg1','a11','P','222',25);

CREATE TABLE matriculas(
    codasig CHAR(4) not null, 
    codgrupo CHAR(4) not null, 
    tipo CHAR(1) not null,
    DNI CHAR(8) not null,
    convocatoria DECIMAL not null, 
    calificacion DECIMAL,
    PRIMARY KEY (codasig, codgrupo, tipo, DNI, convocatoria),
    FOREIGN KEY(codasig, codgrupo, tipo) REFERENCES grupos(codasig,codgrupo,tipo)
        on delete cascade
        on update cascade,
    foreign key(DNI) REFERENCES alumnos(DNI) 
        on delete cascade 
        on update cascade
);

create table t2(
    a1 varchar,
    a2 varchar
);

insert into t2 values('a',null);
select * from t2 where a2 is null;