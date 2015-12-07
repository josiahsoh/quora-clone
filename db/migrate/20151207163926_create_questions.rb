class CreateQuestions < ActiveRecord::Migration
  def change
	create_table :questions do |q|
	  q.string :question_title
	  q.string :question_body
	  q.integer :user_id

	  q.timestamps null: false
	end
  end
end
