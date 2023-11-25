class TagsController < ApplicationController
    def index
        @tags = Tag.all.order(:id)
        
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            redirect_to tags_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
    end

    def destroy
    end

    def new
        @tag = Tag.new
    end

    private

    def tag_params
        params.require(:tag).permit(:name)
    end

end
