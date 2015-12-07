# display new question form

get '/questions/new' do
  erb :"/question/new"
end

#Show all questions list

# get '/questions/all' do
#   erb :"/question/index"
# end

# create new question

post '/questions' do
 	question = Question.create(question_title: params[:question_title], user_id: session[:user_id], question_body: params[:question_body])
 	redirect "/questions/#{question.id}"
end

# view all user's questions

get '/questions' do
	erb :"question/index"
end

# view specific question with all the answers

get '/questions/:id' do 
  @question =Question.find(params[:id])
  @user = @question.user #why save in @user?
  erb :"question/show" #show specific question with all the answer. 
end

# edit specific question

get '/questions/:id/edit' do
	@question = Question.find(params[:id])
	erb :"/question/edit"
end

# update existing user
patch '/questions/:id' do
	question = Question.find(params[:id])
	question.update(question_title: params[:question_title], question_body: params[:question_body])
	@user = question.user
 	redirect "/questions/#{question.id}"
end

# delete user
delete '/questions/:id' do
	question = Question.find(params[:id])
	question.destroy
	@user = question.user
	redirect "/users/#{@user.id}"
end
