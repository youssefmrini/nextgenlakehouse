# NextGenLakehouse — Video Demos

Companion code for the [**NextGenLakehouse**](https://www.youtube.com/@nextgenlakehouse) videos
by [Youssef Mrini](https://www.nextgenlakehouse.com): Databricks notebooks, SQL scripts, and
archives you can import and run. Each section links the **video** and the matching **demo file**,
and uses the same script shown on screen.

> **Tip:** most demos use a catalog/schema or S3 path from the recording. Change them to your own
> environment before running.

---

## Getting Started with Row & Column Security in Unity Catalog (ABAC)

**Type:** Databricks notebook (Python + SQL)
**Video:** [Getting Started with Row & Column Security in Unity Catalog](https://www.youtube.com/watch?v=Ph32H5HTWlA)
**Demo:** [Getting Started with Databricks ABAC](./Getting%20Started%20with%20Databricks%20ABAC)

Walkthrough of **Attribute-Based Access Control (ABAC)** on Databricks with Unity Catalog:
row-level filtering and column masking using tags and policies.

- **Row filtering:** schema-level policy that hides rows (e.g. "West" region) for a group, via a row-filter function and `MATCH COLUMNS hasTag('geo_region') AS region USING COLUMNS(region, 'West')`.
- **Column masking:** mask PII columns (SSN, address) for a group with `hasTagValue('sensitive_pii','ssn')`, and `EXCEPT` for groups that should see unmasked data.
- **Tags & policies:** `CREATE POLICY ... ROW FILTER` / `COLUMN MASK` with `TO` and `EXCEPT` for account groups.
- **Complex masking:** conditional mask (mask SSN only when another column has a given value) using a multi-argument masking function.
- **Iceberg:** short section on creating and querying an Iceberg table in the same catalog.

**Note:** uses catalog/schema and S3 paths from the video (`dkushari_uc`, `fgac_abac`, a managed location) — adjust to your environment.

---

## Getting Started with Databricks SQL Scripting

**Type:** Databricks notebook archive (`.dbc`)
**Video:** [SQL Scripting / Migrate PL/SQL to Databricks](https://www.youtube.com/watch?v=JIHVKI_HEPc)
**Demo:** [Getting Started with SQL Scripting.dbc](./Getting%20Started%20with%20SQL%20Scripting.dbc)

A notebook export (`.dbc`) for the SQL Scripting video — variables, blocks, control flow, and
procedural logic in SQL.

**How to use:** in Databricks, go to **Workspace** → **Import** → **File** and upload the `.dbc`,
or drag-and-drop it into the workspace.

---

## Getting Started with Stored Procedures in Databricks SQL

**Type:** SQL script
**Video:** [Getting started with Stored Procedures in Databricks SQL](https://www.youtube.com/watch?v=-QvilT17X2k)
**Demo:** [Getting started with Stored Procedures in Databricks SQL.sql](./Getting%20started%20with%20Stored%20Procedures%20in%20Databricks%20SQL.sql)

**Stored procedures** take SQL/PSM procedural logic and make it a **server-side, callable Unity
Catalog object** — fully governed with ACLs. Public preview on **Runtime 17+ (Apache Spark 4.0)**.

- **Define:** `CREATE PROCEDURE ... LANGUAGE SQL SQL SECURITY INVOKER AS BEGIN ... END` with `IN` / `OUT` / `INOUT` parameters.
- **Govern:** `DESCRIBE PROCEDURE` and `GRANT EXECUTE` — it's a UC securable like any other.
- **Call:** `DECLARE` a variable, then `CALL`; a procedure can call a function or another procedure.
- **State:** `INOUT` carries a value across successive calls (classic data-warehousing pattern).

---

## Getting Started with recursive CTE in Databricks SQL

**Type:** SQL script
**Video:** [Getting started with recursive CTE in Databricks SQL](https://www.youtube.com/watch?v=4cAg3wRurLY)
**Demo:** [Getting started with recursive CTE.sql](./Getting%20started%20with%20recursive%20CTE.sql)

Examples of **recursive CTEs** (`WITH RECURSIVE`): hierarchies, expression evaluation, and
sessionization.

- **Hierarchy (employee → manager):** recursive CTE builds `(e, m, path)` with `array_append` to walk from root to leaves.
- **Formula evaluation:** parse and evaluate an arithmetic string step-by-step, one operator per level.
- **Sessionization:** new session when the gap ≥ 5 minutes (`lag` + running `sum`), and a 5-minute session-validity rule via a recursive CTE.

---

## Getting Started with Multi-Statement Transactions (MTT) in Databricks SQL

**Type:** SQL script
**Video:** [Atomic Transactions in Databricks: BEGIN ATOMIC & Multi-Table Commits](https://www.youtube.com/watch?v=u11eg5TxU1s)
**Demo:** [Getting started with MTT.sql](./Getting%20started%20with%20MTT.sql)

**Multi-statement / multi-table transactions**: commit changes across several managed tables as a
single ACID unit.

- **Managed tables:** `tblproperties('delta.feature.catalogManaged' = 'supported')`.
- **Blocks:** `BEGIN ... END`, `BEGIN ATOMIC ... END`, and `BEGIN TRANSACTION ... ROLLBACK/COMMIT TRANSACTION`.
- **Rollback:** verify that a `ROLLBACK` leaves all tables at their pre-transaction state.
- **Bonus:** `parse_json` and the pipe syntax (`|>`) over a `VALUES` row.

---

## Getting started with collation in Databricks SQL

**Type:** SQL script
**Video:** [Collations: Case-Insensitive SQL & Legacy Data Warehouse Migration](https://www.youtube.com/watch?v=yLWpSYSkFgY)
**Demo:** [Getting started with collation in databricks sql.sql](./Getting%20started%20with%20collation%20in%20databricks%20sql.sql)

**Collation**: case-insensitive and locale-aware string comparison/ordering without always using
`LOWER()` / `UPPER()`.

- **Literals & defaults:** `'a' COLLATE UNICODE`, `DEFAULT COLLATION UTF8_LCASE` on table/schema, `ALTER COLUMN ... COLLATE UNICODE_CI_AI`.
- **Comparisons & joins:** case-sensitive vs case-insensitive matching; `UNICODE_RTRIM` to ignore trailing spaces; behavior of `contains` / `startswith` / `replace`.
- **Ordering:** `ORDER BY ... COLLATE unicode_ai_ci`.

**Note:** uses catalog/schema `kent_marten_test_catalog` / `colSchema` — change to your own.

---

## Getting Started with the Open Source Synthetic Data SDK

**Type:** Databricks notebook (Python)
**Video:** [Getting started with the Open Source Synthetic Data SDK](https://www.youtube.com/watch?v=jM-fkYC8_LA)
**Demo:** [Getting started with the Open Source Synthetic Data SDK.ipynb](./Getting%20started%20with%20the%20Open%20Source%20Synthetic%20Data%20SDK.ipynb)

End-to-end demo of the [**Mostly AI** Synthetic Data SDK](https://github.com/mostly-ai/mostlyai)
(Apache 2.0) on the US Census Income dataset — train a generator from scratch, then create a
privacy-safe synthetic replica.

- **Install & init:** `pip install 'mostlyai[local]'`, then `MostlyAI()` in local mode.
- **Three primitives:** `mostly.train` (generator from scratch), `mostly.probe` (live disposable samples), `mostly.generate` (persisted dataset).
- **Model report:** `g.reports(display=True)` — accuracy score, distribution/correlation charts, privacy metrics.
- **Conditional generation:** seed the generator to fix columns (e.g. 35-year-old males) and synthesize the rest.
- **Differential privacy:** optional `differential_privacy` training block; write the synthetic table back to Unity Catalog.

---

## Getting Started with Secrets in Unity Catalog

**Type:** Databricks notebook (Python)
**Video:** [NextGenLakehouse channel](https://www.youtube.com/@nextgenlakehouse)
**Demo:** [Unity Catalog Secrets — Demo & Script.ipynb](./Unity%20Catalog%20Secrets%20%E2%80%94%20Demo%20%26%20Script.ipynb)

**Unity Catalog secrets** store sensitive values (passwords, tokens, API keys) as *securable
objects* under the three-level namespace `catalog.schema.secret_name` — governed, unlike legacy
workspace-scoped secret scopes.

- **Create / list:** via the UI or REST API; `dbutils.secrets.list(catalog=..., schema=...)` (metadata only — values are never returned by list).
- **Read & use:** `dbutils.secrets.get(catalog=..., schema=..., key=...)`, e.g. to pass an API key to an SDK client.

---

## Python Unit Testing in Databricks

**Type:** Python module + pytest tests
**Video:** [Python Unit Testing in Databricks with AI Error Diagnosis](https://www.youtube.com/watch?v=72kuRVl0hPY)
**Demo:** [python-unit-tests-demo/](./python-unit-tests-demo)

A small, realistic pricing module with pytest tests — including **one intentionally failing test**
to fix during the demo (the AI-assisted error-diagnosis flow).

- `pricing.py` — `format_currency`, `item_subtotal`, `free_shipping_eligible` (has a `>` vs `>=` bug).
- `test_pricing.py` — passing tests plus `test_free_shipping_eligible_at_threshold`, which fails until you fix the bug.

---

## Summary

| Topic | Video | Demo | Type |
|---|---|---|---|
| Row & Column Security (ABAC) | [▶](https://www.youtube.com/watch?v=Ph32H5HTWlA) | Getting Started with Databricks ABAC | Notebook |
| SQL Scripting | [▶](https://www.youtube.com/watch?v=JIHVKI_HEPc) | Getting Started with SQL Scripting.dbc | `.dbc` |
| Stored Procedures | [▶](https://www.youtube.com/watch?v=-QvilT17X2k) | Getting started with Stored Procedures in Databricks SQL.sql | SQL |
| Recursive CTE | [▶](https://www.youtube.com/watch?v=4cAg3wRurLY) | Getting started with recursive CTE.sql | SQL |
| Multi-Statement Transactions (MTT) | [▶](https://www.youtube.com/watch?v=u11eg5TxU1s) | Getting started with MTT.sql | SQL |
| Collation | [▶](https://www.youtube.com/watch?v=yLWpSYSkFgY) | Getting started with collation in databricks sql.sql | SQL |
| Synthetic Data SDK | [▶](https://www.youtube.com/watch?v=jM-fkYC8_LA) | Getting started with the Open Source Synthetic Data SDK.ipynb | Notebook |
| Unity Catalog Secrets | [▶](https://www.youtube.com/@nextgenlakehouse) | Unity Catalog Secrets — Demo & Script.ipynb | Notebook |
| Python Unit Testing | [▶](https://www.youtube.com/watch?v=72kuRVl0hPY) | python-unit-tests-demo/ | Python |

---

*Channel: [NextGenLakehouse](https://www.youtube.com/@nextgenlakehouse) · Repository: [youssefmrini/nextgenlakehouse](https://github.com/youssefmrini/nextgenlakehouse)*
