# Display new user form
# Post method is for deleting, updating, and creating
get '/users/new' do
  erb :"user/new" #get the new user form
end

# Create new user
post '/users' do
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  redirect "/users/#{user.id}" #to users/id below. And redirect cannot pass @variable, have to use erb to pass instance variable.
end

# Display user edit form
#<form action="/users/<%@user.id%>" method="POST">
#	<input type="hidden" name="method" value="patch">
get '/users/:id/edit' do #users/:id/edit show which user specifically 
  @user = User.find(params[:id])
  erb :"user/edit"
end

# Update user
patch '/users/:id' do
  user = User.find(params[:id])
  user.update(name: params[:name], email: params[:email], password: params[:password], description: params[:description])
  redirect "/users/#{user.id}" # use this to reduce memory
end

# Delete user

delete 'users/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect :'static/index'
end

# View user profile

get '/users/:id' do
  @user = User.find(params[:id]) #params[:id] refer to users/:id
  erb :"user/show"
end

# View login page
get '/users' do
 
end
