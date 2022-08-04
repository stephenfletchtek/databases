require 'post_repo'

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it "gets all posts" do
    repo = PostRepository.new
    posts = repo.all
    
    expect(posts.length).to eq 2
    
    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'Plutonium in Springfield'
    str = 'Today, I will explain howe to mine plutonium from underneath Springfield lake!'
    expect(posts[0].content).to eq (str)
    expect(posts[0].num_views).to eq '5'
    expect(posts[0].user_account_id).to eq '1'
    
    expect(posts[1].id).to eq '2'
    expect(posts[1].title).to eq 'Prank my sister'
    str = 'I have thought of the best way to prank my baby sister.'
    expect(posts[1].content).to eq (str)
    expect(posts[1].num_views).to eq '10'
    expect(posts[1].user_account_id).to eq '2'
  end
end