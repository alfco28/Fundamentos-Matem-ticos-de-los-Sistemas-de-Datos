

.print 'Borramos todas las tablas'
drop table if exists matriculas;
drop table if exists alumnos;

.print 'Creamos la tabla alumnos'
CREATE TABLE alumnos(
    DNI CHAR(8) primary key NOT NULL, 
    nomalum VARCHAR(50), 
    fechanac DATE, 
    direccion VARCHAR(40), 
    provincia VARCHAR(20), 
    beca CHAR(2)
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

CREATE TABLE matriculas(
    codasig CHAR(4) NOT NULL, 
    codgrupo CHAR(4) NOT NULL, 
    tipo CHAR(1) NOT NULL, 
    DNI CHAR(8) NOT NULL, 
    convocatoria INT NOT NULL, 
    calificacion DECIMAL(3,1),
    PRIMARY KEY(codasig, codgrupo, tipo, DNI, convocatoria)
);