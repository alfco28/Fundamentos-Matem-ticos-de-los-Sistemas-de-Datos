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