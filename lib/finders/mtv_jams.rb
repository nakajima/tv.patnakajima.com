module Finders
  class MtvJams
    def initialize(term)
      @term = term
    end

    def result
      doc.at('.onNow .pickable').text
    end

    private

    def doc
      @doc ||= Nokogiri::HTML(open('http://www.locatetv.com/listings/mtv-jams').read)
    end
  end
end
