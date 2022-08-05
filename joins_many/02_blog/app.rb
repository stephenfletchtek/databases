require_relative 'lib/post_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog')

repo = PostRepository.new
post = repo.find_with_comments(1)

puts "#{post.id}. #{post.title} - #{post.content}"

post.comments.each do |comment|
  puts "   #{comment.id} - #{comment.content} - #{comment.author}"
end
