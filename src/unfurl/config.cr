require "./resolver"

module Unfurl
  alias ResolverList = Array(Resolver.class)

  class Config
    @resolvers = ResolverList.new

    property resolvers
  end
end
