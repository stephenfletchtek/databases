require_relative 'post'
require_relative 'comment'

class PostRepository
  # find_with_comments method
  def find_with_comments(id)
    sql = 'SELECT posts.id,
                  posts.title, 
                  posts.content,
                  comments.id AS comment_id,
                  comments.content AS comment_content,
                  comments.author
          FROM posts JOIN comments
          ON comments.post_id = posts.id
          WHERE posts.id = $1;'

    result = DatabaseConnection.exec_params(sql, [id])

    post = Post.new
    post.id = result[0]['id']
    post.title = result[0]['title']
    post.content = result[0]['content']

    result.each do |record|
      comment = Comment.new
      comment.id = record['comment_id']
      comment.content = record['comment_content']
      comment.author = record['author']
      post.comments << comment
    end
    post
  end
end