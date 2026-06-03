create table Movie
(
    title varchar(50) not null,
    year integer not null,
    length integer,
    inColor char(1),
    studioName varchar(50),
    producer# integer
);

create table Studio
(
    name varchar(50) not null unique,
    address varchar(255),
    presc# integer
);

create table StarsIn
(
    movieTitle varchar(50) not null,
    movieYear integer not null,
    starName varchar(128) not null
);

create table MovieStar
(
    name varchar(128) not null unique,
    address varchar(255),
    gender char(1),
    birthdate date
);

create table MovieExec
(
    cert# integer not null unique,
    name varchar(128),
    address varchar(255),
    networth integer
);

-- add all necessary constraints to Movie table post-creation
alter table Movie
add constraint pk_Movie
primary key (title, year)
add constraint fk_Movie_Studio
foreign key (studioName)
references Studio(name)
add constraint fk_Movie_MovieExec
foreign key (producer#)
references MovieExec(cert#);

-- add all necessary constraints to Studio table post-creation
alter table Studio
add constraint pk_Studio
primary key (name);

-- add all necessary constraints to StarsIn table post-creation
alter table StarsIn
add constraint fk_StarsIn_Movie
foreign key (movieTitle, movieYear)
references Movie(title, year)
add constraint fk_StarsIn_MovieStar
foreign key (starName)
references MovieStar(name);

-- add all necessary constraints to MovieExec table post-creation
alter table MovieExec
add constraint pk_MovieExec
primary key (cert#);

-- add all necessary constraints to MovieStar table post-creation
alter table MovieStar
add constraint pk_MovieStar
primary key (name);
