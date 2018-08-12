require "./resolver"
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
end
