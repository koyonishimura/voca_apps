class QuestionBook < ApplicationRecord
    has_many :work_books
    belongs_to :user

    def calculate_score
        correct_count = 0
    
        # WorkBooksの中から正解をカウント
        self.work_books.each do |work_book|
          correct_count += 1 if work_book.answer.to_i == work_book.question_id
        end
    
        correct_count
    end
end