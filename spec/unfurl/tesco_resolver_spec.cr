require "../spec_helper"

describe Unfurl::TescoResolver do
  describe "#unfurl" do
    it "returns type from json" do
      resolver = Unfurl::TescoResolver.new
      html = <<-HTML
        <!DOCTYPE html>
        <html>
        <head>
          <script type="application/javascript"></script>
          <script type="application/ld+json">
            [
              {"@type": "Corporation", "name": "Tesco"},
              {"@type": "Product", "image": ["https://assets.example.org/image.jpg"]}
            ]
          </script>
        </head>
        </html>
        HTML
      WebMock.stub(:get, "http://tesco.pl/tea").to_return(status: 200, body: html)

      resolver.resolve(URI.parse("http://tesco.pl/tea")).should eq "https://assets.example.org/image.jpg"
    end
  end
end
