-- Tutorial Week 2 - Aqeel Ahlam

-- This will show every single line on the console wether it has an error or not
set echo on

-- We are creating a table with 3 columns(or attributes/fields)
create table myfirstDB (
  column1 number(8) not null,
  column2 varchar(50) not null,
  column3 varchar(50) not null,
  constraint pk_myfirstdb primary key (column1));

-- Adding data to the table: Inserting a row(or tuple/ record)


insert into myfirstdb values (1,'a','aa');
insert into myfirstdb values (2,'b','bb');
insert into myfirstdb values (3,'c','bb');
insert into myfirstdb values (4,'d','dd');
insert into myfirstdb values (5,'e','ee');


-- You cannot undo once you have commited, this is to make it permanent.
COMMIT;

set echo off

