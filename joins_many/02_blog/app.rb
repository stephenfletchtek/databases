require_relative 'lib/database_connection'

DatabaseConnection.connect('blog')

# Perform a SQL query on the database and get the result set.                             
sql = ''           
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end