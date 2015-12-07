class CreateAnswers < ActiveRecord::Migration
  def change
	create_table :answers do |a|
	  a.string :answer_column
	  a.string :question_id
	  a.integer :user_id

	  a.timestamps null: false
	end
  end
end