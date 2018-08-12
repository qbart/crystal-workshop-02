require "../spec_helper"

describe Unfurl::DefaultResolver do
  describe "#unfurl" do
    it "returns og:image from html source" do
      resolver = Unfurl::DefaultResolver.new
      html = <<-HTML
        <!DOCTYPE html>
        <html>
        <head>
          <meta property="og:image" content="https://assets.example.org/image.jpg" />
        </head>
        </html>
        HTML
      WebMock.stub(:get, "http://example.org/product").to_return(status: 200, body: html)

      resolver.resolve(URI.parse("http://example.org/product")).should eq "https://assets.example.org/image.jpg"
    end
  end
end
