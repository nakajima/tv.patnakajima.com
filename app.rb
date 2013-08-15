require 'rubygems'
require 'sinatra'
require 'cgi'
require './finder'

class WhatsOn < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/search' do
    redirect "/#{params[:q]}"
  end

  get '/:q' do
    @result = Finder.new(CGI.escape params[:q]).result
    erb :result
  end
end
