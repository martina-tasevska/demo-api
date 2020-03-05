class Post < ApplicationRecord
  belongs_to :user

  def self.create_random(n)
    n.times do
      GenerateRandomUserJob.perform_later
    end
  end
end
