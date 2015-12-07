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
  user = User.find_by(email: params[:email])
  
 if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/users/#{user.id}" #Do you know why have to use "user.id"?
  elsif user.authenticate(params[:password]) != user.password
    redirect '/users/wrong_password'
  else
    redirect '/'
  end
end 
#if submit without enter text it will create NoMethodError...how to solve?
#how to create a minimum password? At least 8 characters?

# Wrong password enter
get '/users/wrong_password' do
  erb :"user/wrong_password"
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
  redirect "/users/#{user.id}" #It does not pass the variables if using @user
end

# Delete user

delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  erb :'static/index'
end

# View user profile

get '/users/:id' do
  authorize
  @user = User.find(params[:id])
  owner_only(@user.id)
  erb :"user/show"
end

# View login page

get '/users' do
  erb :"user/index"
end

# user authorization
def authorize
  if session['user_id']
    true
  else
    redirect '/'
  end
end

# only can view by user after login
def owner_only(user_id)
  if session['user_id'] == user_id
    true
  else
    redirect '/'
  end
end