require "xml"
require "http/client"

require "./resolver"

module Unfurl
  class DefaultResolver < Resolver
    def matches?(uri : URI) : Bool
      true
    end

    def resolve(uri : URI) : String?
      on_successful_page_fetch(uri) do |body|
        root = XML.parse(body)
        image_url = root.xpath_string("string(/html/head//meta[@property='og:image']/@content)")
        image_url if !image_url.empty?
      end
    end
  end
end
