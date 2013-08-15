require 'rubygems'
require 'nokogiri'
require 'open-uri'

LISTINGS = "http://tvlistings.zap2it.com/tvlistings/ZCGrid.do?aid=zap2it"
CHANNEL_NAME_SELECTOR = 'a.zc-st-a'
SHOW_SELECTOR = '.zc-pg-t'

class WhatsOnFinder
  def initialize(term)
    @term = term
  end

  def result
    finder.result
  end

  private

  def finder
    if @term =~ /mtv\s*jams/i
      Finders::MtvJams.new(@term)
    else
      Finders::Generic.new(@term)
    end
  end
end
