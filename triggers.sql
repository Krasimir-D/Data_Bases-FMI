-- ROUTINES
-- routines that execute automatically upon other events if a given condition is satisfied
-- when creating a routine 2 things get defined
--  1) WHEN: before/after insert/update/delete
--  2) WHAT: what the routine does

-- triggers can be also called "rules of type event-condition-action"

-- a trigger is defined for a specific table or view and after its creation in executes automatically

-- SYNTAX
-- create trigger <name>
-- {after | instead of | before}
-- {insert | update | delete} on my_table
-- referencing new row | table as N
--             old row | table as O
-- for each row | statement
-- -- optional
-- when (<condition>)
--      <body>

-- on INSERT we can reference
-- 1) new row | table

-- on UPDATE we can reference
-- 1) new row | table
-- 2) old row | table

-- on DELETE we can reference
-- 1) old row | table

-- on FOR EACH ROW
-- the trigger executes for each change that the table will suffer
-- from a single DML statement

-- on FOR EACH STATEMENT
-- the trigger executes only ones per DML statement


-- BEFORE INSERT TRIGGER example_1
create trigger trg_default_appdate
before insert on Apply
referencing new as n
for each row
begin atomic
    if n.appdate is null then
        set n.appdate = current_date;
    end if;
end;

-- BEFORE INSERT TRIGGER example_2
create or replace trigger trg_deadline_check
before insert on Apply
referencing new as n
for each row
begin atomic
    if exists(
        select 1
        from Jobs j
        where j.number = n.jobno
            and n.appdate > j.deadline
    ) then
        signal sqlstate '45000'
            set message_text = 'Application after deadline';
    end if;
end;

-- BEFORE UPDATE TRIGGER example
create or replace trigger trg_deadline_check
before update of deadline on Jobs
referencing new as n old as n
for each row
begin atomic
    if n.deadline < current_date then
        signal sqlstate '45000'
        set message_text = 'Deadline must be in the future';
    end if;
end;

-- BEFORE trigger
create or replace trigger trg_apply_limit
before insert on Apply
referencing new as n
for each row
begin atomic
    if (select count (*)
        from Apply
        where jobseekerno = n.jobseekerno) >= 5 then
        signal sqlstate '45000'
        set message_text = 'Maximum 5 applications allowed';
    end if;
end;

-- AFTER trigger
create or replace trigger trg_close_job
after update of deadline on Jobs
referencing old as o new as n
for each row
begin atomic
    if n.deadline < current_date then
        update Jobs
        set status = 'I'
        where number = n.number;
    end if;
end;

-- AFTER trigger (FOR EACH STATEMENT)
create table JobsAudit
(
    action varchar(10),
    username varchar(50),
    tabname varchar(50),
    actionTime timestamp
);

create trigger trg_jobs_count
after insert on Jobs
referencing new as n
for each statement
begin atomic
    insert into JobsAudit
    values ('INSERT' || (select count(*) from n), user, 'Jobs', current timestamp );
end;

-- BEFORE trigger (FOR EACH STATEMENT)
-- DB2 does not support before triggers for each statement
create trigger trg_check_salary
before insert on Jobs
referencing new table as nt
for each statement
begin atomic
    if exists (
        select 1
        from nt
        where minsal < 0 or maxsal < 0
    ) then
        call sysibmadm.DBMS_OUTPUT.PUT_LINE('Salary cannot be negative!');
        signal sqlstate '45000'
            set message_text = 'Salary cannot be negative';
    end if;
end;