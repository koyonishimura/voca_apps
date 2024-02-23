class Tag < ApplicationRecord
    has_many :question_tags
    has_many :questions, through: :question_tags
    belongs_to :user, optional: true
    validates :name, uniqueness: true, presence: true
end
