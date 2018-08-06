class Thought < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  validates :user_id, presence: true
  acts_as_taggable

  before_save :set_tags

  private

  def set_tags
    self.tag_list = body.scan(/#([a-zA-Z0-9]+)/).flatten.map(&:downcase)
  end
end
