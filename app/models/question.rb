class Question < ApplicationRecord
    
    validates :title,  presence: true, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 255 }

    has_many :similar_words, dependent: :destroy
    has_many :work_books
    has_many :question_tags
    belongs_to :question_tags
    accepts_nested_attributes_for :similar_words, reject_if: :all_blank, allow_destroy: true

    def self.title_looks(search, word)
        if search == "perfect_match"
          @question = Question.where("title LIKE?", "#{word}")
        elsif search == "forward_match"
          @question = Question.where("title LIKE?","#{word}%")
        elsif search == "backward_match"
          @question = Question.where("title LIKE?","%#{word}")
        elsif search == "partial_match"
          @question = Question.where("title LIKE?","%#{word}%")
        else
          @question = Question.all
        end
    end

    def self.description_looks(search, word)
        if search == "perfect_match"
          @question = Question.where("description LIKE?", "#{word}")
        elsif search == "forward_match"
          @question = Question.where("description LIKE?","#{word}%")
        elsif search == "backward_match"
          @question = Question.where("description LIKE?","%#{word}")
        elsif search == "partial_match"
          @question = Question.where("description LIKE?","%#{word}%")
        else
          @question = Question.all
        end
    end

    def self.similar_word_looks(search, word)
        if search == "perfect_match"
          @question = Question.joins(:similar_words).where(similar_words: {name: word})
        elsif search == "forward_match"
            @question = Question.joins(:similar_words).where("similar_words.name LIKE ?", "#{word}%")
        elsif search == "backward_match"
            @question = Question.joins(:similar_words).where("similar_words.name LIKE ?", "%#{word}")
        elsif search == "partial_match"
            @question = Question.joins(:similar_words).where("similar_words.name LIKE ?", "%#{word}%")
        else
          @question = Question.all
        end
    end
end
