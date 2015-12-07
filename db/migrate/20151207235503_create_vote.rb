class CreateVote < ActiveRecord::Migration
	def change
		create_table :votes do |t|
			t.integer :vote_count
			t.belongs_to :question, index: true
			t.belongs_to :user, index: true
			t.timestamps null: false
		end
	end
end
