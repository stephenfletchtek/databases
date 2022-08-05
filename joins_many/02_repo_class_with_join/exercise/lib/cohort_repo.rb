require 'cohort'
require 'student'

class CohortRepository
  def find_with_students(id)
    sql = 'SELECT cohorts.id,
                  cohorts.name, 
                  cohorts.starting_date,
                  students.id AS student_id,
                  students.name AS student_name
          FROM cohorts JOIN students
          ON students.cohort_id = cohorts.id
          WHERE cohorts.id = $1;'

    result = DatabaseConnection.exec_params(sql, [id])

    cohort = Cohort.new
    cohort.id = result[0]['id']
    cohort.name = result[0]['name']
    cohort.starting_date = result[0]['starting_date']

    result.each do |record|
      student = Student.new
      student.id = record['student_id']
      student.name = record['student_name']
      cohort.students << student
    end
    cohort
  end
end