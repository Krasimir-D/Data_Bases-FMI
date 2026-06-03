-- Data Manipulation Language (DML)
-- core statements: INSERT, UPDATE, DELETE

-- Adding a record (INSERT)
-- we specify the table name, the subset of attributes we want to assign values to
-- and a list of values. The subset of values we omit get assigned with NULL
-- That's how we create a single new record

-- insert into <table_name>(att_1, attr_2,..,attr_n)
-- values (v_1, v_2,..,v_n)

insert into StarsIn(movietitle, movieyear, starname)
values ('The maltese falcon', 1942, 'Sydney');

-- it's redundant to list all attributes if our goal is to enter a value for each of them in the new record
insert into StarsIn
values ('The maltese falcon', 1942, 'Sydney');


-- Deleting a record (DELETE)
-- delete all records in a table of choice
-- that satisfy a condition of choice

-- delete from <table_name>
-- where <condition>

delete from StarsIn
where movietitle = 'The Maltese falcon'
    and movieyear = 1942
    and starName = 'Sydney';


-- Changing a record in a table (UPDATE)
-- update <table_name>
-- set <attribute_1> = <formula_1>, ...
-- where <condition>;

update StarsIn
set movieyear = 1943
where starName = 'Sydney';