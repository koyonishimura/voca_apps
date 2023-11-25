class Addtags < ActiveRecord::Migration[7.0]
  def change
    add_column :question_tags, :tag_id, :integer
    add_column :question_tags, :question_id, :integer
  end
end
