require 'rubygems'
require 'sinatra'
require './finder'

class WhatsOn < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/search' do
    redirect "/#{params[:q]}"
  end

  get '/:q' do
    @result = Finder.new(params[:q]).result
    erb :result
  end
end
