class Question < ActiveRecord::Base
  attr_accessible :title
  belongs_to :user

  validates :user_id, 	presence: true
  validates :title, 	presence: true, length: { maximum: 150 }

  default_scope order: 'questions.created_at DESC'
end
