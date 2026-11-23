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

select nomalum,t3.dni,t3.calificacion from 
alumnos,
(select t1.dni,t1.calificacion from matriculas t1 where t1.codasig='ca1' and t1.calificacion is not null and
    not exists 
        (select * from matriculas t2 where t2.codasig='ca1' and  
        t2.calificacion < t1.calificacion)) t3
    where alumnos.dni=t3.dni;



create temp view taux3 as 
    select t1.dni,t1.calificacion from matriculas t1 
        where t1.codasig='ca1' and 
            t1.calificacion is not null 
            and not exists 
                (select * from matriculas t2 where t2.codasig='ca1' and  
                t2.calificacion < t1.calificacion);

select nomalum,taux3.dni,taux3.calificacion from alumnos, taux3
    where alumnos.dni=taux3.dni;

drop view taux3;


create temp view t1 as 
    select codasig from asignaturas where curso='3';

select DISTINCT dni from matriculas where codasig in t1;

drop view t1;

select dni,nomalum from alumnos union select nrp,nomprof from profesores;

select dni,nomalum from alumnos INTERSECT select nrp,nomprof from profesores;

select dni,nomalum from alumnos INTERSECT select nrp,nomprof from profesores;