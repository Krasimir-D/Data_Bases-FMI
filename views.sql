-- VIEWS
-- views a.k.a. virtual tables are objects that behave as regular tables
-- but don't live on the ROM.
-- views don't contain data themselves, they just encapsulate a SELECT query
-- that extracts data from a table

-- Creating a VIEW
create view MyView
as select (*) from Jobs;

-- Using a VIEW
select (*) from MyView;

-- Dropping a VIEW
drop view MyView;

-- Why do we use VIEWS
-- 1) Security reasons
-- 2) Encapsulating tables of choice, thus limiting the access to users to
--      subsets of attributes and subsets of records
-- 3) Could be faster due to caching mechanisms in SQL

-- Oddities with VIEWS
-- when we write queries to views in reality we write them to the table(s) that
-- the view's definition consists of. Therefore the VIEW itself doesn't contain any records
-- As a result, different result sets get produced across multiple queries to the same VIEW
-- as tables get modified (new records get added, updated or deleted)
-- if a table gets modified (DDL-wise, i.e. ALTER/CREATE/DROP), the view enters a frozen state
-- In such cases the user is forced to manually drop the view and recreate it. The same caveat
-- is present when using table functions.
-- The best way of combating this footgun is to create table functions and views with "create or replace <object>"
-- What this statement is, essentially, an atomic drop and create, so cheers.

-- VIEW example_1
create view JobsView as
select j.number, j.title, j.minsal, j.maxsal, e.name as employerName
from Jobs j
join Employers e on j.empno = e.number;

