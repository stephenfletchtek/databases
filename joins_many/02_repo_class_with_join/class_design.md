# Cohort Model and Repository Classes Design Recipe

## 1. Design and create the Table

Already done

## 2. Create Test SQL seeds

```sql
TRUNCATE TABLE students, cohorts RESTART IDENTITY;
INSERT INTO cohorts (name, starting_date) VALUES ('june22', '15/06/22');
INSERT INTO cohorts (name, starting_date) VALUES ('july22', '18/07/22');
INSERT INTO cohorts (name, starting_date) VALUES ('august22', '04/08/22');
INSERT INTO students (name, cohort_id) VALUES ('Bart Simpson', 1);
INSERT INTO students (name, cohort_id) VALUES ('Homer Simpson', 2);
INSERT INTO students (name, cohort_id) VALUES ('Daffy Duck', 2);
INSERT INTO students (name, cohort_id) VALUES ('Goldilocks', 3);
INSERT INTO students (name, cohort_id) VALUES ('Big Bad Wolf', 3);
INSERT INTO students (name, cohort_id) VALUES ('Red Riding Hood', 3);
```

```bash
psql -h 127.0.0.1 student_directory_2 < seeds.sql
```

## 3. Define the class names

```ruby
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repo.rb)
class CohortRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: cohorts
# Model class
# (in lib/cohort.rb)

class Cohort
  attr_accessor :id, :name, :starting_date, :students
end
```

## 5. Define the Repository Class interface

```ruby
# Table name: cohorts
# Repository class
# (in lib/cohort_repo.rb)

class CohortRepository
  # find_with_students method
  def find_with_students(id)
    # SQL 'SELECT cohorts.id,
    #             cohorts.name, 
    #             cohorts.starting_date,
    #             students.id AS student_id,
    #             students.name
    #     FROM cohorts JOIN students
    #     ON students.cohort_id = cohorts.id
    #     WHERE cohorts.id = $1;'

    # returns a cohort object containing related students
  end
end
```

## 6. Write Test Examples

```ruby
# 1 Get cohort with students

repo = CohortRepository.new
cohort = repo.find_with_students(3)
cohort.name # => 'august22'
cohort.students.length # => 3
cohort.students[0].name # =>'Goldilocks'
```

## 7. Reload the SQL seeds before each test run

```ruby
# file: spec/cohort_repository_spec.rb

def reset_cohorts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_cohorts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_Used the test-driving process of red, green, refactor to implement the behaviour._