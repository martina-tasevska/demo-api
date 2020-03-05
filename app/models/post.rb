class Post < ApplicationRecord
  belongs_to :user

  def self.create_random
    GenerateRandomUserJob.perform_later
  end
end
