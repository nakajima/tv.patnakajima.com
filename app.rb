require 'rubygems'
require 'sinatra'
require 'cgi'
require './lib/finder'
require './lib/finders/generic'
require './lib/finders/mtv_jams'

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
      @result = WhatsOnFinder.new(@query).result
      erb :result
    rescue NoMethodError
      erb :nope
    end
  end
end
