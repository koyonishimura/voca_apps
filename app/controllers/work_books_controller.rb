class WorkBooksController < ApplicationController
    def index
        @question_books = QuestionBook.all
        # @user = current_user
    end
    def new
        @question_book = QuestionBook.new(user_id: current_user.id) #  @user.id ログインしているユーザーのIDを指定
        if @question_book.save
            10.times do
                @work_book = @question_book.work_books.build

                # ランダムに3つのquestionデータを取得
                question_ids = Question.pluck(:id).sample(3)

                # question_idに1つ、two_question_idに1つ、three_question_idに1つを保存
                @work_book.question_id = question_ids[0]
                @work_book.two_question_id = question_ids[1]
                @work_book.three_question_id = question_ids[2]

                @work_book.save
            end

            redirect_to work_books_path, notice: '問題と設問が作成されました。'
        else
            render :new
        end
    end

    def question_test
        @question_book = QuestionBook.find_by(id: params[:id])
        QuestionBook.find_by(id: params[:id])
        @question_book.work_books[0]
        @work_book_number = params[:number].to_i
        @work_book = @question_book.work_books[(@work_book_number - 1)]
    end

    def update
        @work_book = WorkBook.find(params[:id])
        @question_book = @work_book.question_book
        if params[:mode] == "prev"
            @work_book_number = (params[:number].to_i - 1)
            @work_book = @question_book.work_books[(@work_book_number - 1)]
        else
            @work_book.answer = params[:work_book][:answer] rescue nil
            @work_book.save
            @work_book_number = (params[:number].to_i + 1)
            if @work_book_number < 11
                @work_book = @question_book.work_books[(@work_book_number - 1)]
            else
                # calculate_scoreメソッドを呼び出して正解数を計算
                correct_count = @question_book.calculate_score

                # 正解数をquestion_booksのscoreカラムに設定
                @question_book.update!(score: correct_count, user_id: current_user.id) # @user.id ログインしているユーザーのIDを指定

                respond_to do |format|
                    format.js
                end
                @finished = true
            end
        end

        respond_to do |format|
            format.js
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

    def question_test_user_answer
    end

    def question_test_answer
        @question_book = QuestionBook.find_by(id: params[:id])
        @work_books = @question_book.work_books
    end
end







