module Finders
  class Mapper
    def initialize(term)
      @term = term
    end

    def result
      # Lol this list is so incomplete
      return 'VH1 Clsc' if @term =~ /vh1\s*classic/i
      return 'MTV 2'    if @term =~ /mtv\s*2/i
      return 'Comedy'   if @term =~ /comedy\s*(central)?/i
      @term
    end
  end

  class Generic
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
end
