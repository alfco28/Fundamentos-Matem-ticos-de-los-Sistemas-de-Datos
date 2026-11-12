PRAGMA foreign_keys=ON;

drop table if exists taux1;
drop table if exists t3;
drop table if exists t2;
drop table if exists t1;

create table t1(
    a1 varchar(5) not null primary key,
    a2 varchar(5)
);

create table t2(
    a3 varchar(5) not null,
    a1 varchar(5) not null,
    primary key(a3,a1),
    foreign key(a1) references t1(a1)
        on delete cascade
);

create table t3(
    a4 varchar(5) not null,
    a3 varchar(5) not null,
    a1 varchar(5) not null,
    primary key (a4),
    foreign key (a3,a1) references t2(a3,a1)
        on delete set null
);

insert into t1 values('v1','v2');
insert into t2 values('v3','v1');
insert into t3 values('v4','v3','v1');

/* al ejecutar la siguiente orden nos da un error
delete from t1 where a1='v1';*/

create table taux1(
    a integer not null primary key,
    b integer default 10,
    c varchar(5)
);

insert into taux1 values ('11','12','hola');
insert into taux1(a) values ('22'),('33');
insert into taux1(c,b,a) values ('---','100','200');

.print "tabla taux1"
select * from taux1;
.print "tuplas de taux1 con c nulo"
select * from taux1 where c is null;