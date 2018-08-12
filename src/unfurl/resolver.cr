require "uri"

module Unfurl
  abstract class Resolver
    abstract def matches?(uri : URI) : Bool
    abstract def resolve(uri : URI) : String?

    protected def on_successful_page_fetch(uri : URI)
      response = HTTP::Client.get(uri)
      if response.status_code == 200
        yield response.body
      end
    end
  end
end
