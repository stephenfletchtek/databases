require 'post'

class PostRepository
  def all
    sql = 'SELECT * FROM posts'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_post(record) }
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