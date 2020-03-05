class GenerateRandomUserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    post = Post.new
    post.title = Faker::Lorem.word
    post.description = Faker::Lorem.sentence
    post.user_id = 2
    post.save!
  end
end
