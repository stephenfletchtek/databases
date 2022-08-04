require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT * FROM posts;'
posts = DatabaseConnection.exec_params(sql, [])

sql = 'SELECT * FROM user_accounts;'
users = DatabaseConnection.exec_params(sql, [])

posts.each do |record|
  str = "#{record['id']} - #{record['title']} - #{record['content']} - "
  str += "#{record['num_views']} - #{record['user_account_id']}"
  puts str
end

puts ""

users.each do |record|
  puts "#{record['id']} - #{record['email_address']} - #{record['username']}"
end
