# {{user_accounts}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

Already created

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_user_accounts.sql)
TRUNCATE TABLE posts, user_accounts RESTART IDENTITY; -- replace with your own table name.
INSERT INTO user_accounts (email_address, username) VALUES ('homer@simpsons.com', 'Homer Simpson');
INSERT INTO user_accounts (email_address, username) VALUES ('bart@simpsons.com', 'Bart Simpson');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount
end

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccount
  attr_accessor :id, :email_address, :username
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: user_accounts

# Repository class
# (in lib/user_account_repo.rb)

class UserAccountRepository
  # Selecting all records
  def all
    # Executes the SQL query:
    # SELECT * FROM user_accounts;
    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM user_accounts WHERE id = $1;
    # Returns a single UserAccount object.
  end

  def create(user_account)
    # INSERT INTO user_accounts (user_account) VALUES ($1)
    # returns nothing
  end

  def update(id, user_account)
    # UPDATE user_accounts SET $1 = $2 WHERE id = $3
  end

  def delete(student)
    # DELETE FROM user_accounts WHERE id = $1
  end
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all

user_accounts.length # =>  2

user_accounts[0].id # =>  1
user_accounts[0].email_address # =>  'homer@simpsons.com'
user_accounts[0].username # =>  'Homer Simpson'

user_accounts[1].id # =>  2
user_accounts[1].email_address # =>  'bart@simpsons.com'
user_accounts[1].username # =>  'Bart Simpson'

# 2
# Get a single user_account

repo = UserAccountRepository.new

user_account = repo.find(1)[0]

user_account.id # => '1'
user_account.email_address # =>  'homer@simpsons.com'
user_account.cohort_username # =>  'Homer Simpson'

# 3 
# Create a user account
lisa = UserAccount.new
lisa.email_address = 'lisa@simpsons.com'
lisa.username = 'Lisa Simpson'

repo = UserAccountRepository.new
repo.create(lisa)

user_accounts = repo.all
user_accounts.length # =>  3

user_accounts[2].id # =>  3
user_accounts[2].email_address # =>  'lisa@simpsons.com'
user_accounts[2].username # =>  'Lisa Simpson'

# 4
# Update a user account
maggie = UserAccount.new
maggie.email_address = 'maggie@simpsons.com'
maggie.username = 'Maggie Simpson'

repo = UserAccountRepository.new
repo.update(1, maggie)

repo.all.length # =>  2

repo.find(1)[0].id # =>  1
repo.find(1)[0].email_address # =>  'maggie@simpsons.com'
repo.find(1)[0].username # =>  'Maggie Simpson'

repo.find(2)[0].id # =>  2
repo.find(2)[0].email_address # =>  'bart@simpsons.com'
repo.find(2)[0].username # =>  'Bart Simpson'

# 5
# Delete
repo = UserAccountRepository.new
repo.delete(1)
user_accounts = repo.all
user_accounts.length # => 1

user_accounts[0].id # => 2
user_accounts[0].email_address # =>  'bart@simpsons.com'
user_accounts[0].username # =>  'Bart Simpson'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_account_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._