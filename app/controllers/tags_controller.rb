class TagsController < ApplicationController
    def index
        @tags = Tag.all.order(:id)

    end

    def questions
        @tag = Tag.find(params[:id])
        @questions = @tag.questions
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
        @tag = Tag.find(params[:id])
        if @tag.update(tag_params)
            # 更新に成功した場合を扱う
            redirect_to tags_path
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        Tag.find(params[:id]).destroy
        flash[:success] = "Tag deleted"
        redirect_to tags_url, status: :see_other
    end

    def new
        @tag = Tag.new
    end

    def edit
        @tag = Tag.find(params[:id])
    end

    private

    def tag_params
        params.require(:tag).permit(:name)
    end

end
