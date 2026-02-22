# Videos

Repo dedicated to the content from the videos — Databricks notebooks, SQL scripts, and archives you can import and run.

---

## Getting Started with Databricks ABAC

**Type:** Databricks notebook (Python + SQL)  
**Link:** [Getting Started with Databricks ABAC](https://github.com/youssefmrini/Videos/blob/main/Getting%20Started%20with%20Databricks%20ABAC)

Walkthrough of **Attribute-Based Access Control (ABAC)** on Databricks with Unity Catalog: row-level filtering and column masking using tags and policies.

**Contents:**
- **Row filtering:** Create a schema-level policy that hides rows (e.g. “West” region) for a group using a row filter function and `MATCH COLUMNS hasTag('geo_region') AS region USING COLUMNS(region, 'West')`.
- **Column masking:** Mask PII columns (SSN, address) with a masking function for a group, using `hasTagValue('sensitive_pii','ssn')` and `EXCEPT` for groups that should see unmasked data.
- **Tags:** Apply tags to columns (`sensitive_pii`, `geo_region`) and use them in policies.
- **Policies:** `CREATE POLICY ... ROW FILTER` / `COLUMN MASK` with `TO` and `EXCEPT` for account groups (`demo_fgac_group_1`, `demo_fgac_group_2`).
- **Complex masking:** Conditional mask (e.g. mask SSN only when another column has a given value) using a multi-argument masking function.
- **Iceberg:** Short section on creating and querying an Iceberg table in the same catalog.

**Use case:** Learn how to implement row- and column-level security with Unity Catalog ABAC (tags, row filters, column masks, TO/EXCEPT).

**Note:** Uses catalog/schema and S3 paths from the video; adjust `dkushari_uc`, `fgac_abac`, and managed location to your environment.

---

## Getting Started with SQL Scripting.dbc

**Type:** Databricks notebook archive (`.dbc`)  
**Link:** [Getting Started with SQL Scripting.dbc](https://github.com/youssefmrini/Videos/blob/main/Getting%20Started%20with%20SQL%20Scripting.dbc)

A **Databricks notebook export** (`.dbc`) for the “Getting Started with SQL Scripting” video. Import it into your workspace to get the full notebook(s) and run the examples.

**How to use:** In Databricks, go to **Workspace** → **Import** → choose **File** and upload `Getting Started with SQL Scripting.dbc`, or drag-and-drop into the workspace.

**Use case:** Follow along with the SQL Scripting video using the same notebooks (variables, blocks, control flow, etc.) in your own workspace.

---

## Getting started with collation in databricks sql.sql

**Type:** SQL notebook  
**Link:** [Getting started with collation in databricks sql.sql](https://github.com/youssefmrini/Videos/blob/main/Getting%20started%20with%20collation%20in%20databricks%20sql.sql)

**Collation** in Databricks SQL: case-insensitive and locale-aware string comparison and ordering without always using `LOWER()`/`UPPER()`.

**Contents:**
- **Collation literals:** `'a' COLLATE UNICODE`, `'b' COLLATE DE_CI_AI`; `collation(...)` to inspect the collation of a value.
- **Table/schema default:** `DEFAULT COLLATION UTF8_LCASE` or `UNICODE_CI_AI` on table/schema.
- **Column-level:** `ALTER COLUMN ... TYPE STRING COLLATE UNICODE_CI_AI`, `UTF8_LCASE_RTRIM`, etc.
- **Comparisons:** Case-sensitive vs case-insensitive (`WHERE name = 'mihailo'` vs `WHERE pet_name = 'felix'` with `UTF8_LCASE`); `UNICODE_RTRIM` for ignoring trailing spaces.
- **Joins and functions:** Joining on collated columns; behavior of `contains`, `startswith`, `endswith`, `replace` with collation.
- **Ordering:** `ORDER BY first_name` with table/column collation; `ORDER BY ... COLLATE unicode_ai_ci`.

**Use case:** Implement case-insensitive or locale-specific sorting and filtering in Databricks SQL using collation instead of ad-hoc `LOWER()`/`UPPER()`.

**Note:** Uses catalog/schema `kent_marten_test_catalog` / `colSchema` (and similar); change to your catalog and schema.

---

## Getting started with recursive CTE.sql

**Type:** SQL script / notebook  
**Link:** [Getting started with recursive CTE.sql](https://github.com/youssefmrini/Videos/blob/main/Getting%20started%20with%20recursive%20CTE.sql)

Examples of **recursive CTEs** (`WITH RECURSIVE`) in Databricks SQL: hierarchies, expression evaluation, and sessionization.

**Example 1 — Hierarchy (employee → manager):**
- Table `emps(name, mgr)`; root row where `mgr IS NULL`.
- Recursive CTE builds `(e, m, path)` with `array_append(path, name)` to walk from root to leaves.
- Use case: org charts, tree traversal.

**Example 2 — Formula evaluation:**
- Variable `v_formula` (e.g. `'6*3/2*9-4+7'`).
- Recursive CTE parses and evaluates step-by-step (one operator per level: `*`, `/`, `+`, `-`).
- Use case: simple expression evaluation or parsing in SQL.

**Example 3 — Sessionization:**
- Table `sessionize(id, ts)` with event timestamps.
- **Rule 1:** New session when gap ≥ 5 minutes (window + `lag`, then `sum(new_session)` for `session_id`).
- **Rule 2:** Session validity (e.g. “session lasts 5 minutes after start”): recursive CTE over ordered `id` to assign `session_ts` and `session_id` based on the 5-minute rule.

**Use case:** Learn or reuse patterns for recursive CTEs (trees, stepwise evaluation, sessionization) in Databricks SQL.

---

## Summary

| File | Type | Purpose |
|------|------|---------|
| Getting Started with Databricks ABAC | Notebook | Unity Catalog ABAC: row filters, column masking, tags, TO/EXCEPT |
| Getting Started with SQL Scripting.dbc | .dbc archive | Importable SQL Scripting notebooks from the video |
| Getting started with collation in databricks sql.sql | SQL | Collation (UNICODE, UTF8_LCASE, etc.) for case/locale-aware SQL |
| Getting started with recursive CTE.sql | SQL | Recursive CTEs: hierarchy, formula evaluation, sessionization |

---

*Repository: [youssefmrini/Videos](https://github.com/youssefmrini/Videos)*
