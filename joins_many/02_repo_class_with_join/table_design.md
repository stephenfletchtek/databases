# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

student, name, cohort
cohort, name, starting date
```

## 2. Infer the Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------- |
| cohort                | name, starting_date |
| student               | name, cohort        |


1. Name of the first table (always plural): `cohorts` 

    Column names: `name`, `starting_date`

2. Name of the second table (always plural): `students` 

    Column names: `name`, `cohort`

## 3. Decide the column types.

```
Table: cohorts
id: SERIAL
name: text
starting_date: text

Table: students
id: SERIAL
name: text
```

## 4. Decide on The Tables Relationship

```
1. Can one cohort have many students? YES
2. Can one student have many cohorts? NO

-> Therefore,
-> A cohort HAS MANY students
-> An student BELONGS TO a cohort

-> Therefore, the foreign key is on the students table.
```

## 4. Write the SQL.

```sql
-- file: albums_table.sql
-- Replace the table name, columm names and types.
-- Create the table without the foreign key first.

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date text
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);
```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < spec/create_table.sql
```