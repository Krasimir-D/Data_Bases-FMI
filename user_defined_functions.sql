-- DB2 supports only 2 types of user-defined functions
-- 1) Scalar functions <-> return a single value
-- 2) Table functions <-> return a virtual table ( SELECT queries are supported on the product)

-- however table functions are limited as they can't modify the database
-- therefore the following statements are not allowed in the functions body
-- 1) INSERT, UPDATE, DELETE (DML)
-- 2) CREATE, ALTER, DROP (DDL)
-- 3) COMMIT, ROLLBACK
-- 4) can't call stored procedures that modify the state of the database (i.e. any objects contained within)

-- Scalar functions
create or replace function get_company_age(age_bg integer)
returns integer
return year(current_date) - age_bg;

create or replace function days_to_deadline(deadline date)
returns integer
return days(deadline) - days(current_date);

create or replace function applications_count(js integer)
returns integer
return (
    select count(*)
    from Apply
    where jobseekerno = js
    );

-- table functions
create or replace function get_jobs_by_employer(p_empno int)
returns table
    (
        job_number int,
        title varchar(50),
        minsal decimal(9,2),
        maxsal decimal(9,2)
    )
language sql
return
    select number, title, minsal, maxsal
    from Jobs
    where empno = p_empno;

-- and we call it like this:
select * from table(get_jobs_by_employer(1)) T;

-- the table(...) tells the parser to treat the result of the function as a table
-- the T is an alias