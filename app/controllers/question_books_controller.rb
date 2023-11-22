class QuestionBooksController < ApplicationController
    def index
        @question_books = QuestionBook.all
    end

    def ranking
        @question_books = QuestionBook.all
        
    end
end