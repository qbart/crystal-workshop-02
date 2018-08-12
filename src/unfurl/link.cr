module Unfurl
  class MissingResolverError < Exception; end

  class Link
    @@config = Config.new

    getter uri

    def self.configure
      yield @@config
    end

    def initialize(@uri : URI)
      raise MissingResolverError.new("Unfurl::Link should contain at least 1 resolver") if @@config.resolvers.empty?
    end

    def unfurl
      @@config.resolvers.each do |resolver_class|
        resolver = resolver_class.new
        if resolver.matches?(uri)
          result = resolver.resolve(uri)
          if result.nil?
            return {:not_found, "Image url not found on the page with current strategy"}
          else
            return {:ok, result}
          end
        end
      end

      {:error, "No resolvers matched"}
    end
  end
end
