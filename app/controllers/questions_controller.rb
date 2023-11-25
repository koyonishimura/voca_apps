class QuestionsController < ApplicationController
    require 'csv'
    def index
        @questions = Question.all.order(:id)
        @range = params[:range]

        if @range == "タイトル"
            @questions = @questions.title_looks(params[:search], params[:word])
        elsif @range == "意味"
            @questions = @questions.description_looks(params[:search], params[:word])
        elsif @range == "類似語"
            @questions = @questions.similar_word_looks(params[:search], params[:word])

        end

        respond_to do |format|
          format.html
          format.csv do |csv|
            send_questions_csv(@questions)
          end
        end
    end

    def create
        @question = Question.new(question_params)    # 実装は終わっていないことに注意!
        if @question.save
            # 保存の成功をここで扱う。
            

            redirect_to questions_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            # 更新に成功した場合を扱う
            redirect_to questions_path
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        Question.find(params[:id]).destroy
        flash[:success] = "Question deleted"
        redirect_to questions_url, status: :see_other
    end

    def new
        @question = Question.new
        @question.similar_words.build

    end

    def edit
        @question = Question.find(params[:id])
    end


    def csv_output
        @questions = Question.all
        csv_data = CSV.generate do |csv|
          csv << ["タイトル", "意味"]
          @questions.each do |question|
            csv << [question.title, question.description]
          end
         end
        send_data(csv_data, filename: "単語帳リスト.csv")
        redirect_back(fallback_location: root_path)
    end
      

    private

    def send_questions_csv(questions)
        csv_data = CSV.generate(encoding: Encoding::SJIS) do |csv|
            #(encoding: Encoding::SJIS)で文字化け防止
          column_names = %w(タイトル 意味)
          csv << column_names
            questions.each do |question|
                column_values = [
                question.title,
                question.description,
                ]
                csv << column_values
            end
        end
        send_data(csv_data, filename: "単語一覧.csv")
    end

    def question_params
      params.require(:question).permit(:title, :description, :name, similar_words_attributes: [:id, :name, :_destroy], tag_ids: [])
    end
end