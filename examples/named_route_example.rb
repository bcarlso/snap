require 'rubygems'
require 'sinatra'
require '../lib/sinatra/named_path_support'

path :home, '/index'
path :add, '/add/:augend/:addend'
path :result, '/sum/:augend/:addend'

get :home do
  "Hello World!"
end

get :add do
  redirect(path_to(:result).with(params[:augend], params[:addend]))
end

get :result do
  "#{params[:augend]} + #{params[:addend]} = #{params[:augend].to_i + params[:addend].to_i}"
end