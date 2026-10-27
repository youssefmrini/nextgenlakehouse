- Getting Started with Stored Procedures in Databricks SQL
- Video: https://www.youtube.com/watch?v=-QvilT17X2k
-
- Stored procedures take the same SQL/PSM procedural logic as SQL scripting and
- make it a SERVER-SIDE, callable object. They are a Unity Catalog object, so
- they are fully governed with ACLs and callable from the SQL editor or a
- notebook. Public preview on Databricks Runtime 17+ (Apache Spark 4.0).
-
- Adjust catalog / schema to your environment.

use catalog main;
use schema default;


- Example 1 // A simple procedure: area of a rectangle
-
- The body lives in AS BEGIN ... END. IN params are inputs (the default); an OUT
- param starts as NULL and returns its final value. LANGUAGE SQL and SQL SECURITY
- are required.

create or replace procedure rectangle_area(
  in  length double,
  in  width  double,
  out area   double
)
language sql
sql security invoker
comment 'Computes the area of a rectangle'
as begin
  set area = length * width;
end;


- Inspect it -- stored procedures show up as Unity Catalog objects.

describe procedure rectangle_area;


- Governance // it is a UC securable, so grant EXECUTE like any other object.

grant execute on procedure rectangle_area to `demo_analysts`;


- Call it // declare a variable to receive the OUT value, then CALL.

declare result double;
call rectangle_area(4, 5, result);
select result;   -- 20.0


- Example 2 // A procedure that calls a function
-
- A procedure can call a function (or another procedure). Here a scalar UDF does
- the math and the procedure wraps it -- exactly the pattern shown in the video.

create or replace function rectangle_area_fn(length double, width double)
returns double
return length * width;

create or replace procedure rectangle_area_v2(
  in  length double,
  in  width  double,
  out area   double
)
language sql
sql security invoker
as begin
  set area = rectangle_area_fn(length, width);
end;

declare result2 double;
call rectangle_area_v2(6, 7, result2);
select result2;   -- 42.0


- Example 3 // INOUT carries state between calls (classic data-warehousing pattern)
-
- INOUT accepts an input and returns its final value, so a running total survives
- across successive CALLs.

create or replace procedure add_amount(in x int, out added int, inout total int)
language sql
sql security invoker
comment 'Add x to a running total'
as begin
  set added = x;
  set total = total + x;
end;

declare added int;
declare running int default 0;

call add_amount(10, added, running);
select added, running;   -- 10, 10

call add_amount(25, added, running);
select added, running;   -- 25, 35


- Clean up (optional)
-- drop procedure if exists rectangle_area;
-- drop procedure if exists rectangle_area_v2;
-- drop procedure if exists add_amount;
-- drop function  if exists rectangle_area_fn;
