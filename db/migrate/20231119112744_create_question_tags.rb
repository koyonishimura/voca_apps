class CreateQuestionTags < ActiveRecord::Migration[7.0]
  def change
    create_table :question_tags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
