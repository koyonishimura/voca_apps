class QuestionTag < ApplicationRecord
    has_many :question
    belongs_to :question
end
