require 'post_repo'

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "gets a post with comments" do
    repo = PostRepository.new
    post = repo.find_with_comments(1)
    expect(post.title).to eq 'Monday'
    expect(post.comments.length).to eq 3
    expect(post.comments[0].author).to eq 'Bart Simpson'  
  end
end