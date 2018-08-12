require "../spec_helper"

describe Unfurl::Link do
  describe ".new" do
    it "does not raise error when resolvers are specified" do
      setup_resolvers(Unfurl::DefaultResolver)

      Unfurl::Link.new(URI.parse("http://example.org")).should_not be_nil
    end

    it "raises error when resolvers are not specified" do
      expect_raises(Unfurl::MissingResolverError) do
        Unfurl::Link.new(URI.parse("http://example.org"))
      end
    end
  end

  describe "#unfurl" do
    it "returns ok with url when image found" do
      setup_resolvers(OkResolver)

      Unfurl::Link.new(URI.parse("http://example.org")).unfurl.should eq({:ok, "http://example.org/logo.png"})
    end

    it "returns not_found with nil when image not found" do
      setup_resolvers(NotFoundResolver)

      Unfurl::Link.new(URI.parse("http://example.org")).unfurl.should eq({:not_found, "Image url not found on the page with current strategy"})
    end

    it "returns error when didn't match" do
      setup_resolvers(ErrorResolver)

      Unfurl::Link.new(URI.parse("http://example.org")).unfurl.should eq({:error, "No resolvers matched"})
    end

    it "returns ok with url when image found" do
      setup_resolvers(ErrorResolver, OkResolver)

      Unfurl::Link.new(URI.parse("http://example.org")).unfurl.should eq({:ok, "http://example.org/logo.png"})
    end
  end
end

private def setup_resolvers(*resolvers)
  Unfurl::Link.configure do |config|
    config.resolvers = resolvers.map(&.as(Unfurl::Resolver.class)).to_a
  end
end

private class OkResolver < Unfurl::Resolver
  def matches?(uri : URI) : Bool
    true
  end

  def resolve(uri : URI) : String?
    "http://example.org/logo.png"
  end
end

private class NotFoundResolver < Unfurl::Resolver
  def matches?(uri : URI) : Bool
    true
  end

  def resolve(uri : URI) : String?
    nil
  end
end

private class ErrorResolver < Unfurl::Resolver
  def matches?(uri : URI) : Bool
    false
  end

  def resolve(uri : URI) : String?
    nil
  end
end
