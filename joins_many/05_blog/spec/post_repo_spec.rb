require 'post_repo'

def reset_posts_table
  seed_sql = File.read('spec/blog_posts_tags.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_2' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "gets all posts related to a tag" do
    repo = PostRepository.new
    posts = repo.find_by_tag(1)
    expect(posts.length).to eq 4
    expect(posts[0].title).to eq 'How to use Git'
    expect(posts[1].title).to eq 'Ruby classes'
    expect(posts[2].title).to eq 'Using IRB'
    expect(posts[3].title).to eq 'SQL basics'
  end
end