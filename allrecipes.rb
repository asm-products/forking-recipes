require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open(ARGV[0]))

title = doc.css('title').first.content.scan(/\r\n\t(.*) -/).first
puts title

image = doc.css('.photo-body img').first.attributes['src'].value

ingredients = doc.css('#liIngredient').map { |e| e.content.strip.gsub(/\r\n +/, ' ') }
directions = doc.css('.directLeft li').map { |e| e.content }


puts "### Source"
puts "[AllRecipes](#{ARGV[0]})"
puts ""

puts '### Ingredients'
ingredients.each do |ingredient|
  puts  "* #{ingredient}"
end
puts ""
puts "### Directions"
directions.each do |direction|
  puts "* #{direction}"
end
puts ''
puts "### Pictures"
puts "![#{title.first}](#{image})"
