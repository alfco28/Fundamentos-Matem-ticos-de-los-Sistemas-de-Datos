/* producto cartesiano de profesores con profesores */
select p1.nrp,p2.nrp from profesores p1, profesores as p2;

/* parejas nombre profesor, nombre departamento */ 
select profesores.nomprof,departamentos.nombre from
profesores,departamentos where profesores.coddep=departamentos.iddep;

select t1.nomprof 'Nombre profesor' ,t2.nombre 'Nombre departamento'
    from profesores t1,departamentos t2
    where t1.coddep=t2.iddep;

select t1.nrp NRP_prof, t1.nomprof,t2.codgrupo 
    from profesores t1, grupos t2 where NRP_prof=t2.nrp;

select t1.dni,t2.dni,t1.nomalum na from alumnos t1, alumnos t2 
    where t1.nomalum=t2.nomalum and t1.dni<t2.dni order by na;

select * from profesores,(select * from alumnos where provincia='Cádiz');

select dni from matriculas where codasig in (select codasig from asignaturas where caracter='op');

select dni from matriculas,asignaturas where matriculas.codasig=asignaturas.codasig and asignaturas.caracter='op';

select dni from matriculas where codasig not in (select codasig from asignaturas where caracter='op');

select distinct dni from matriculas where dni not in 
    (select dni from matriculas,asignaturas where matriculas.codasig=asignaturas.codasig and asignaturas.caracter='op');

select dni,nomalum,provincia from alumnos where provincia in (select distinct provincia from alumnos where nomalum='Juan');

select dni from alumnos where dni not in (select dni from matriculas);

select t1.codaula from aulas t1 where not exists 
    (select * from aulas t2 where t2.capacidad<t1.capacidad and t1.codaula<>t2.codaula);