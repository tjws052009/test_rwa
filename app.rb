require 'sinatra'
require 'sinatra/reloader'
require 'awesome_print'
require 'yaml'

# require all models
Dir.glob('./model/*') {|f| require f}

# # # SETUP # # #
$config = YAML.load(File.open('./config/application.yml'))
# # # # # # # # #

# GET
# Search if given parameters
get '/users' do
  request.request_method
end

# GET by ID
# Get certian resource, defined by id
get '/users/:id' do
  request.request_method + ' ' + params[:id]
end

# POST
# Create new resource
post '/users' do
  request.request_method
end

# PUT
# Update resoruce
put '/users/:id' do
  request.request_method + ' ' + params[:id]
end

# DELETE
# Delete resource
delete '/users/:id' do
  request.request_method + ' ' + params[:id]
end
