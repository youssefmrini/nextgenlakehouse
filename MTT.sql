drop table if exists mst_table_1;
drop table if exists mst_table_2;

create or replace table mst_table_1
( id    bigint generated always as identity not null
, ts    timestamp                           not null
, val   decimal(5,2)                        not null
)
tblproperties('delta.feature.catalogManaged' = 'supported');


create or replace table mst_table_2
( id    bigint generated always as identity not null
, ts    timestamp                           not null
, val   decimal(5,2)                        not null
)
tblproperties('delta.feature.catalogManaged' = 'supported');


insert into mst_table_1 (ts, val) values (current_timestamp(), 1.0);
insert into mst_table_2 (ts, val) values (current_timestamp(), 2.0);

begin
  update mst_table_1 set val = 1.1  where id = 1;
  update mst_table_2 set val = null where id = 1;
end;

select 'Table_1' as src, * from mst_table_1 union all
select 'Table_2' as src, * from mst_table_2;

begin atomic
  update mst_table_1 set val = 1.2  where id = 1;
  update mst_table_2 set val = null where id = 1;
end;

select 'Table_1' as src, * from mst_table_1 union all
select 'Table_2' as src, * from mst_table_2;


begin transaction;

update mst_table_1 set val = 1.3 where id = 1;

update mst_table_2 set val = 2.3 where id = 1;

select 'Table_1' as src, * from mst_table_1 union all
select 'Table_2' as src, * from mst_table_2;

rollback transaction;

select 'Table_1' as src, * from mst_table_1 union all
select 'Table_2' as src, * from mst_table_2;












from values ('[{"shipment_id": 1, "tracking_ref": "GEO-001", "origin": "Paris", "destination": "Lyon", "status": "IN_TRANSIT", "carrier_code": "DHL", "updated_at": "2026-03-01T10:00:00", "version": 1},
  {"shipment_id": 2, "tracking_ref": "GEO-002", "origin": "Marseille", "destination": "Bordeaux", "status": "DELIVERED", "carrier_code": "FED", "updated_at": "2026-03-01T11:00:00", "version": 1}]') as t (str)
|> select parse_json(str) as jstr
        , jstr:shipment_id;

