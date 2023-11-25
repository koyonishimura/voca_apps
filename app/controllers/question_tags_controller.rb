class QuestionTagsController < ApplicationController
    def index
    end

    def create
        @question_tags = QuestionTag(question_tag_params)
        if @question_tags.save
            redirect_to question_tags_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
    end

    def destroy
    end
    
    def new
        @question_tag = QuestionTag.new
    end

    def edit
    end
    
end
