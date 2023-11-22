class WorkBook < ApplicationRecord
    belongs_to :question_book
    belongs_to :question #正解の情報
    belongs_to :two_question, class_name: 'Question'
    belongs_to :three_question, class_name: 'Question'
end