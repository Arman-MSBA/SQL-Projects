# SQL projects

Two coursework and guided-practice projects showing relational data modeling, SQL queries, and aggregate analysis.

## Projects

| Project | Contents | Skills |
| --- | --- | --- |
| [Airline database](Airline%20Project/) | Schema/seed script, business-questions PDF, project brief | Tables, primary/foreign keys, relational modeling, Oracle-style SQL |
| [International debt](Analyze%20International%20Debt%20Statistics/) | SQL notebook, setup SQL, supplied World Bank dataset | Filtering, aggregation, grouping, ranking, subqueries |

## Airline database

`Airline Project/Airline_DB.sql` creates and seeds a database with states, cities, airports, aircraft specifications, airplanes, routes, schedules, and flight status. The script includes Oracle-specific conventions such as `CASCADE CONSTRAINTS`; use a disposable Oracle-compatible schema and review the script before running it.

The business-questions PDF describes the assignment. There is **no separate completed answer/report or business-query solution script** in this repository. The schema and brief should not be treated as evidence that all questions were solved.

## International debt analysis

The notebook is a **guided DataCamp-style practice project** using World Bank international debt data. Provided narrative and embedded DataCamp assets are retained and attributed; they are not presented as original authored research. This repository contains the completed SQL exercise queries.

The notebook uses PostgreSQL through the `%%sql` Jupyter magic and expects a local database named `international_debt`. Create that database, then run the setup file from its own `datasets/` directory with `psql -d international_debt -f international_debt.sql`. The script creates the table and runs a `\copy` command against the CSV in that directory. Use a disposable local database because rerunning the table-creation statement against an existing table will fail. Run Jupyter with a compatible SQL-magic extension, load it with `%load_ext sql`, and check the first cell's connection. Keep database credentials outside committed notebooks.

Questions cover distinct countries/indicators, totals and averages, highest amounts, and country comparisons. Saved observations describe the historical dataset, not current economic statistics.

## Scope and attribution

These files preserve coursework and guided learning. Dataset and exercise materials retain their original rights; this repository does not add a blanket redistribution license. Neither analysis was rerun during this documentation update. Verify source-data permission, database setup, and query results before reuse.
