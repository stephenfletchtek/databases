require_relative 'lib/cohort_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('student_directory_2')
cohort = CohortRepository.new
result = cohort.find_with_students(3)

puts "Cohort name: #{result.name}"
puts "Students:"
result.students.each do |student|
  puts "#{student.id} - #{student.name}"
end