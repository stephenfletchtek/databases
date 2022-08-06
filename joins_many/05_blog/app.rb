require_relative 'lib/post_repo'
require_relative 'lib/tag_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog_2')

repo = PostRepository.new
results = repo.find_by_tag(1)

puts "posts with tag '1'"
results.each do |post|
  puts "#{post.id}. #{post.title}"
end

puts ""

repo = TagRepository.new
results = repo.find_by_post(6)

puts "tags on post '6'"
results.each do |tag|
  puts "#{tag.id}. #{tag.name}"
end