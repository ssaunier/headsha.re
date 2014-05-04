require 'nokogiri'

class OpenGraph
  attr_reader :title, :description, :properties, :metas

  def initialize(body)
    @body = body
    @properties = Hash.new
    @metas = Hash.new
  end

  def parse!
    @doc = Nokogiri::HTML(@body)
    parse_title!
    parse_description!
    parse_metas!
  end

  private

    def parse_metas!
      @doc.css('meta').each do |m|
        if m.attribute('property')
          property = m.attribute('property').to_s
          if property.match(/^(og:.+)$/i)
            @properties[$1] = m.attribute('content').to_s
          end
        elsif m.attribute('name')
          name = m.attribute('name').to_s
          if name.match(/^(twitter:.+)$/i)
            @metas[$1] = m.attribute('content').to_s
          end
        end
      end
    end

    def parse_title!
      begin
        @title = @doc.xpath("//head/title").first.content
      rescue
      end
    end

    def parse_description!
      begin
        @description = @doc.xpath("//head/meta[@name='description']/@content").first.value
      rescue
      end
    end
end