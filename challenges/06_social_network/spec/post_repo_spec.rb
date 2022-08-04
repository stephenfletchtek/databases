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

  it "gets a single post" do
    repo = PostRepository.new
    post = repo.find(1)[0]
    
    expect(post.id).to eq '1'
    expect(post.title).to eq 'Plutonium in Springfield'
    str = 'Today, I will explain howe to mine plutonium from underneath Springfield lake!'
    expect(post.content).to eq (str) 
    expect(post.num_views).to eq '5'
    expect(post.user_account_id).to eq '1'  
  end

  it "creates a post" do
    pollute = Post.new
    pollute.title ='Pig poo disposal'
    str = 'Simply dump the silos in Springfield lake, no one will ever find out!'
    pollute.content = str 
    pollute.num_views = '20'
    pollute.user_account_id = '1'
    
    repo = PostRepository.new
    repo.create(pollute)
    
    posts = repo.all
    expect(posts.length).to eq 3
    
    expect(posts[2].id).to eq '3'
    expect(posts[2].title).to eq (pollute.title)
    expect(posts[2].content).to eq (pollute.content)
    expect(posts[2].num_views).to eq (pollute.num_views)
    expect(posts[2].user_account_id).to eq (pollute.user_account_id)
  end
end