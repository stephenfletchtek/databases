require 'post'

class PostRepository
  def all
    sql = 'SELECT * FROM posts;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_post(record) }
  end

  def find(id)
    sql = 'SELECT * FROM posts WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_post(record) }
  end

  def create(post)
    sql = 'INSERT INTO posts
      (title, content, num_views, user_account_id) 
      VALUES ($1, $2, $3, $4)'
    params = [post.title, post.content, post.num_views, post.user_account_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def update(id, post)
    sql = 'UPDATE posts SET 
      (title, content, num_views, user_account_id) = ($1, $2, $3, $4) 
      WHERE id = $5'
    params = [post.title, post.content, post.num_views, post.user_account_id, id]
    DatabaseConnection.exec_params(sql, params)
  end

  private

  def make_post(record)
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.num_views = record['num_views']
    post.user_account_id = record['user_account_id']
    post
  end
end