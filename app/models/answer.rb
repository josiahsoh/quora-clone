class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	belong_to :user
	belong_to :question
end
