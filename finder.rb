require 'rubygems'
require 'nokogiri'
require 'open-uri'

LISTINGS = "http://tvlistings.zap2it.com/tvlistings/ZCGrid.do?aid=zap2it"
CHANNEL_NAME_SELECTOR = 'a.zc-st-a'
SHOW_SELECTOR = '.zc-pg-t'

class Mapper
  def initialize(term)
    @term = term
  end

  def result
    return 'VH1 Clsc' if @term =~ /vh1\s*classic/i
    return 'MTV 2'    if @term =~ /mtv\s*2/i
    return 'Comedy'   if @term =~ /comedy\s*(central)?/i
    @term
  end
end

class Finder
  def initialize(term)
    @term = Mapper.new(term).result.downcase
  end

  def result
    node = doc.search('tr').detect do |tr|
      tr.search(CHANNEL_NAME_SELECTOR).detect { |a| a.text.downcase.include? @term }
    end
    name = node.at('.zc-pg-t').text
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(open(LISTINGS).read)
  end
end
