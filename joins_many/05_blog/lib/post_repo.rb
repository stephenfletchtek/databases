require_relative 'post'

class PostRepository
  def find_by_tag(id)
    sql = 'SELECT posts.id, posts.title
      FROM posts
        JOIN posts_tags ON posts_tags.post_id = posts.id
        JOIN tags ON posts_tags.tag_id = tags.id
        WHERE tags.id = $1'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_post(record) }
  end

  private

  def make_post(record)
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post
  end
end