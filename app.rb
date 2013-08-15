require 'rubygems'
require 'sinatra'
require 'cgi'
require './finder'

class WhatsOn < Sinatra::Application
  get '/' do
    erb :index
  end

  get '/search' do
    redirect "/#{CGI.escape params[:q]}"
  end

  get '/:q' do
    @query = CGI.unescape params[:q]
    begin
      @result = Finder.new(@query).result
      erb :result
    rescue NoMethodError
      erb :nope
    end
  end
end
