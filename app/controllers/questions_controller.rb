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

    def restart
        @question_book.update(score: 0, is_propose: false)
        @question_book.lists.update_all(answer_number: 0, is_answer: false, quiz_answer: 0) #全ての情報アップデートする
        redirect_to question_test_path(@question_book.id, @question_book.lists.find_by(question_book_id: 1).id)
    end
    
    def continue
        if @question_book.score == 0
            @question_book.lists.each do |list|
                @question_book.update(score: @question_book.score += 1) if list.right_answer == list.answer_number
            end
        end
    
        @question_book.update(is_propose: true)
        list = @question_book.lists.find_by(quiz_answer: 0)
        redirect_to question_test_path(question_book_id: @question_book.id, id: list.id)
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