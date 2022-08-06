require 'tag_repo'

def reset_tags_table
  seed_sql = File.read('spec/blog_posts_tags.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_2' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_tags_table
  end

  it "gets all tags related to a post" do
    repo = TagRepository.new
    tags = repo.find_by_post(6)
    expect(tags.length).to eq 2
    expect(tags[0].name).to eq 'travel'
    expect(tags[1].name).to eq 'cooking'
  end
end