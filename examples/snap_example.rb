require 'sinatra'
require 'sinatra/snap'

path :home => '/index'
paths :add => '/add/:augend/:addend',
      :sum => '/sum/:augend/:addend',
    	:subtract => '/subtract/*/*',
    	:difference => %r{/difference/(\d+)/(\d+)}

get :home do
  "Hello World!"
end

get :multiply => '/multiply/:one/:two' do |one, two|
  "#{one.to_i * two.to_i}"
end

get :add do
  redirect(path_to(:sum).with(params[:augend], params[:addend]))
end

get :sum do
  "#{params[:augend]} + #{params[:addend]} = #{params[:augend].to_i + params[:addend].to_i}"
end

get :subtract do
  redirect path_to(:difference).with(params[:splat][0], params[:splat][1])
end

get :difference do
  "#{params[:captures][0]} - #{params[:captures][1]} = #{params[:captures][0].to_i - params[:captures][1].to_i}"
end

path :hello => '/hi/:name'

get '/index.html' do
  url = path_to(:hello).with('bcarlso')
  "<a href='#{url}'>xxx</a>"
  
end

get :hello do
  "Hi #{params[:name]}"
end