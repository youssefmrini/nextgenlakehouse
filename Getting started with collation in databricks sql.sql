-- Databricks notebook source
-- Create collated string
SELECT 'a' COLLATE UNICODE as UnicodeString;

-- COMMAND ----------

-- Get collation of a string
SELECT collation('b' COLLATE DE_CI_AI) as GermanCollation;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Collations Demo Examples

-- COMMAND ----------

use catalog kent_marten_test_catalog;
use schema colSchema;

-- COMMAND ----------

SELECT COLLATION ('Hello World');

-- COMMAND ----------

CREATE OR REPLACE TABLE collation_name_test (
  id INT, 
  first_name STRING, 
  last_name STRING
  );

INSERT INTO collation_name_test
VALUES 
(1, 'aaron', 'SMITH'), 
(2, 'Aaron' , 'Michaels'),
(3, 'Àrne' , 'Solar'),
(4, 'bob' , 'mcdonald'),
(5, 'carson' , 'lee'),
(6, 'Carson' , 'Cruise'),
(7, 'Bobby' , 'McCloud'),
(8, 'C.J.' , 'Smith');

-- COMMAND ----------

SELECT * FROM collation_name_test
ORDER BY first_name;

-- COMMAND ----------

ALTER TABLE collation_name_test DEFAULT COLLATION UTF8_LCASE;

-- COMMAND ----------

ALTER TABLE collation_name_test 
ALTER COLUMN first_name TYPE STRING COLLATE UNICODE_CI_AI;

ANALYZE TABLE kent_marten_test_catalog.colSchema.collationTbl COMPUTE DELTA STATISTICS;

-- COMMAND ----------

ALTER TABLE collation_name_test 
ADD COLUMN new_col STRING COLLATE UTF8_LCASE_RTRIM;

-- COMMAND ----------

SELECT 'I see trailing spaces' = 'I see trailing spaces    ' COLLATE UNICODE_RTRIM as rtrim_compare;

-- COMMAND ----------

DESCRIBE collation_name_test;

-- COMMAND ----------

SELECT first_name 
FROM collation_name_test
ORDER BY first_name;

-- COMMAND ----------

CREATE OR REPLACE TABLE new_table (
  ID INT,
  name STRING
) DEFAULT COLLATION UTF8_LCASE;

-- COMMAND ----------

INSERT INTO new_table (ID, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Youssef');

-- COMMAND ----------

select * 
from new_table
-- where lower(name) = 'youssef'
where name = 'youssef'

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS kent_marten_test_catalog.colschema2 DEFAULT COLLATION UNICODE_CI_AI;

-- COMMAND ----------

USE SCHEMA colschema2;

-- COMMAND ----------

CREATE OR REPLACE TABLE collation_name_test2 (
  id INT, 
  first_name STRING, 
  last_name STRING
  );

INSERT INTO collation_name_test2
VALUES 
(1, 'aaron', 'SMITH'), 
(2, 'Aaron' , 'Michaels'),
(3, 'Àrne' , 'Solar'),
(4, 'bob' , 'mcdonald'),
(5, 'carson' , 'lee'),
(6, 'Carson' , 'Cruise'),
(7, 'Bobby' , 'McCloud'),
(8, 'C.J.' , 'Smith');

-- COMMAND ----------

describe collation_name_test2;

-- COMMAND ----------

SELECT first_name
FROM collation_name_test2
ORDER BY first_name;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Further Collations examples

-- COMMAND ----------

CREATE OR REPLACE TABLE kent_marten_test_catalog.colschema.collationTbl (id INT, name STRING, pet_name STRING COLLATE UTF8_LCASE)

-- COMMAND ----------

-- Insert values into table
INSERT INTO kent_marten_test_catalog.colschema.collationTbl VALUES (1, 'Mihailo', 'Rex' COLLATE UNICODE), (2, 'Maria' , 'Felix' COLLATE UNICODE);

-- COMMAND ----------

-- Insert different case names
INSERT INTO kent_marten_test_catalog.colschema.collationTbl VALUES (3, 'MiHaIlO', 'ReX'), (4, 'MaRiA' , 'FeLiX');

-- COMMAND ----------

-- Check table columns
SELECT * FROM kent_marten_test_catalog.kent_marten.collationTbl;

-- COMMAND ----------

-- Case sensitive search
SELECT * FROM kent_marten_test_catalog.kent_marten.collationTbl
WHERE name == 'mihailo'

-- COMMAND ----------

-- Case insensitive search
SELECT * FROM kent_marten_test_catalog.kent_marten.collationTbl
WHERE pet_name == 'felix'

-- COMMAND ----------

-- Switch case sensitive search to insensitive
SELECT * FROM kent_marten_test_catalog.kent_marten.collationTbl
WHERE name == 'mihailo' COLLATE UTF8_LCASE

-- COMMAND ----------

-- Alter column to be case insensitive; recompute statistics
ALTER TABLE kent_marten_test_catalog.kent_marten.collationTbl
ALTER COLUMN name TYPE STRING COLLATE UTF8_LCASE
ANALYZE TABLE kent_marten_test_catalog.kent_marten.collationTbl COMPUTE DELTA STATISTICS

-- COMMAND ----------

-- Rerun to see case insensitive results
SELECT * FROM kent_marten_test_catalog.kent_marten.collationTbl
WHERE name == 'mihailo'

-- COMMAND ----------

-- Aggregate example
SELECT count(pet_name), pet_name
FROM kent_marten_test_catalog.kent_marten.collationTbl
GROUP BY pet_name;

-- COMMAND ----------

-- Create second table for joining
CREATE OR REPLACE TABLE kent_marten_test_catalog.kent_marten.collationJoinTbl (id INT, name STRING COLLATE UTF8_LCASE, pet_name STRING COLLATE UTF8_LCASE);
INSERT INTO kent_marten_test_catalog.kent_marten.collationJoinTbl VALUES (1, 'Mihailo', 'Sky'), (2, 'Maria' , 'Thunder'), (3, 'mIHAilo', 'SkY'), (4, 'MarIA' , 'ThUnDeR');

-- COMMAND ----------

-- Query second table
SELECT * FROM kent_marten_test_catalog.kent_marten.collationJoinTbl;

-- COMMAND ----------

-- Join tables
SELECT ct.pet_name, cjt.pet_name
FROM kent_marten_test_catalog.kent_marten.collationTbl as ct
JOIN kent_marten_test_catalog.kent_marten.collationJoinTbl as cjt ON ct.name = cjt.name;

-- COMMAND ----------

-- Showcase work of contains, startswith, endswith
SELECT name, contains(name, 'mih') as contains, startswith(name, 'm') as startsWith, endswith(name, 'a') as endsWith
FROM kent_marten_test_catalog.kent_marten.collationTbl;

-- COMMAND ----------

-- Showcase work of replace
SELECT name, replace(name, 'ria', 'riana') as replaced
FROM kent_marten_test_catalog.kent_marten.collationTbl;

-- COMMAND ----------

describe collation_test

-- COMMAND ----------

SELECT last_name
FROM collation_test
ORDER BY last_name

-- COMMAND ----------

select first_name
from collation_test
order by first_name collate unicode_ai_ci