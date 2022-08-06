require_relative 'lib/post_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog_2')

repo = PostRepository.new
results = repo.find_by_tag(1)

results.each do |post|
  puts "#{post.id}. #{post.title}"
end