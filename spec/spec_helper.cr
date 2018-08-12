require "spec"
require "webmock"
require "../src/unfurl/**"

Spec.before_each do
  Unfurl::Link.configure do |config|
    config.resolvers = Unfurl::ResolverList.new
  end
end
