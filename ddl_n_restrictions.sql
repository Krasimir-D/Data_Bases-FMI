-- Create relation
create table Moviestar
(
    name char(30),
    address varchar(255),
    gender char(1),
    birthdate date default current_date
);

-- Delete relation
drop table Moviestar;

-- Add attribute to relation
alter table Moviestar
add phone char(16);

alter table Moviestar
drop birthdate;

-- Restrictions
-- 1) not null
-- 2) primary key - PK
-- 3) unique - UK
-- 4) foreign key - FK
-- 5) check - CK

-- not null restriction
create table Moviestar
(
    name char(30) not null,
    address varchar(255)
);

-- ALTER TABLE T
-- ALTER COLUMN col1 col1_type NOT NULL;

alter table Moviestar
alter column name set not null;

-- primary key restriction
-- declaring a relation with a PK consisted of a single attribute
create table Moviestar
(
    name char(30) primary key,
    address varchar(255) not null,
    gender char(1),
    birthday date default current_date
);

-- declaration as a relation attribute
create table Moviestar
(
    name char(10) not null,
    address varchar(255),
    gender char(1),
    birthday date default current_date,
    primary key ( name )
);

-- declaring a compound primary key
create table Movie
(
    title varchar(50) not null,
    year integer not null,
    length integer,
    inColor char(1),
    studioName varchar(50)
);

-- declaring a primary key post table creation
alter table Movie
add constraint Movie_pk
primary key (title, year);

-- surrogate primary key
-- that's a concept that introduces an abundant attribute
-- which will serve as primary key if no suitable attributes exist
-- in the table. One such implementation of the surrogate pk concept
-- is the automatic row enumeration
alter table Movie
add id integer generated always as identity
(start with 1, increment by 1),
add constraint Movie_pk
primary key (id);

-- unique restriction
create table Movie
(
    title varchar(50) not null,
    year integer not null,
    length integer,
    inColor char(1),
    studioName varchar(50),
    producerC# integer,
    unique (title, year)
);

-- foreign key
-- ensures that attributes that refer from the relation where said foreign key
-- is defined exist in the referred relation
-- the referred attributes should be either unique or PK
-- PK facilitates parent - child relations. The FK is defined in the Child table

-- declaration at attribute level
create table Studio
(
    name char(30) primary key,
    address varchar(255),
    presC# integer references MovieExec(cert#)
);

-- declaration at table level
create table StarsIn
(
    movietitle varchar(50),
    movieyear integer,
    name char(30),
    foreign key (movietitle, movieyear)
    references Movie(title, year)
);

-- creating a foreign key, post table creation
alter table StarsIn
add constraint MovieStar_FK
    foreign key (starname)
    references MovieStar(name);

alter table StarsIn
add constraint Movie_FK
    foreign key (movietitle, movieyear)
    references Movie(title, year);

-- when creating a FK there are 3 policies that could be applied
-- regarding the integrity of the referral
-- those policies dictate what the DBMS does upon deletion or update
-- of the referred record

-- 1) Restrict / No Action (Evade)
-- all actions that can break the integrity of the relation get denied

-- 2) Cascade (Synchronize)
-- if there's a query that deletes / update the referred record, then the
-- one in the Child table gets erased / updated

-- 3) Set Null
-- if the referred record gets deleted / updated the one in the Child table gets
-- set to NULL only if the attribute allows such value

-- creating a foreign key with a policy of choice
create table StarsIn
(
    movietitle varchar(50),
    movieyear integer,
    name char(30),
    foreign key (movietitle, movieyear)
    references Movie(title, year)
    on delete cascade
    on update restrict
);

-- check restrictions
-- executed upon each update / record creation attempt

-- check at record level
create table my_table1
(
    col1 int not null,
    col2 char(2) not null check (col2 in ('BG', 'FR'))
);

-- check at table level
create table my_table1
(
    col1 int not null,
    col2 char(2) not null,
    check (col2 in ('BG', 'FR'))
);

-- creating a check restriction post table creation
alter table my_table1
add constraint ck_col2
check (col2 in ('BG', 'FR'));
