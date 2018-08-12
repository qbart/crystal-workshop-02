require "./unfurl/*"
require "colorize"

module Unfurl
  Link.configure do |config|
    config.resolvers = ResolverList{TescoResolver, DefaultResolver}
  end
end

urls = [
  "https://allegro.pl/adapter-display-port-dp-displayport-do-hdmi-i6465480149.html",
  "https://ezakupy.tesco.pl/groceries/pl-PL/products/2003120436379",
]

urls.each do |url|
  puts "Visiting url: #{url}"
  result = Unfurl::Link.new(URI.parse(url)).unfurl
  _, image_url = result
  puts "Unfurled image: #{image_url.colorize(:blue)}"
end
