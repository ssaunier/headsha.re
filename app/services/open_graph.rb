require 'nokogiri'

class OpenGraph
  attr_reader :title, :description, :properties, :metas

  PROPERTIES = /^((og:.+)|(twitter:.+))$/i

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
        name = m
        if m.attribute('property')
          result = parse_property(m, 'property')
          @properties[result.first] = result.last if result
        elsif m.attribute('name')
          result = parse_property(m, 'name')
          @metas[result.first] = result.last if result
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

    def parse_property(node, name)
      property = node.attribute(name).to_s
      if property.match(PROPERTIES)
        [$1, node.attribute('content').to_s + node.attribute('value').to_s]
      end
    end
end