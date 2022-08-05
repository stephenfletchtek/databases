require 'cohort_repo'

def reset_cohorts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_cohorts_table
  end

  it "gets a cohort with students" do
    repo = CohortRepository.new
    cohort = repo.find_with_students(3)
    expect(cohort.name).to eq 'august22'
    expect(cohort.students.length).to eq 3
    expect(cohort.students[0].name).to eq 'Goldilocks'
  end
end