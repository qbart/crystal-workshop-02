require "./unfurl/*"
require "json"

module Unfurl
  class TescoResolver < Resolver
    def matches?(uri : URI) : Bool
      host = uri.host
      if host
        host.ends_with?(".tesco.pl")
      else
        false
      end
    end

    def resolve(uri : URI) : String?
      on_successful_page_fetch(uri) do |body|
        root = XML.parse(body)
        node = root.xpath_node("/html/head//script[@type='application/ld+json']")
        json = JSON.parse(node.not_nil!.content).as_a
        val = json.find { |j| j["@type"] == "Product" }
        if val
          val["image"][0].as_s
        end
      end
    end
  end

  Link.configure do |config|
    config.resolvers = [
      TescoResolver,
      DefaultResolver,
    ] of Resolver.class
  end
end

link = Unfurl::Link.new(URI.parse("https://allegro.pl/adapter-display-port-dp-displayport-do-hdmi-i6465480149.html"))
# link = Unfurl::Link.new(URI.parse("https://ezakupy.tesco.pl/groceries/pl-PL/products/2003120436379"))
puts link.unfurl
