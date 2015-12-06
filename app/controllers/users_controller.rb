# Display new user form
# Get, Post, Patch methods are HTML Methods.
# Post method is for deleting, updating, and creating
# Form is always Post method = sending data such as Username, Email, Password
# Google search is Get method

#difference between where and find_by
#find_by only return the 1st
#where returns all those list. 

# Display user edit form
#<form action="/users/<%@user.id%>" method="POST">
#	<input type="hidden" name="method" value="patch">
#users/:id/edit show which user specifically 

enable :sessions

# set the route from begining

get '/' do
  erb :"static/index"
end

# User login

post '/users/login' do
  user = User.find_by(email: params[:email], password: params[:password])
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

# User logout

get '/users/logout' do
  session[:user_id] = nil
  erb :"user/thankyou"
end

# Display new user form

get '/users/new' do
  erb :"user/new"
end

# Create new user

post '/users' do
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  redirect "/users/#{user.id}"
end

# Display user edit form

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'user/edit'
end 

# Update user

patch '/users/:id' do
  user = User.find(params[:id])
  user.update(name: params[:name], email: params[:email], password: params[:password], description: params[:description])
  redirect "/users/#{user.id}"
end

# Delete user

delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  erb :'static/index'
end

# View user profile

get '/users/:id' do
  @user = User.find(params[:id])
  erb :"user/show"
end

# View login page

get '/users' do
  erb :"user/index"
end
