require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open(ARGV[0]))

title = doc.css('title').first.content.scan(/(.*)\|/).first.first.strip
puts title

image = doc.css('.recipe-image img').first.attributes['src'].value

ingredient_units = doc.css('.recipe-unit.intelligent-quantity').map { |e| e.content.strip }
ingredients = doc.css('.recipe-ingredients').map { |e| e.content.strip.gsub(/\n +/, ' ') }
directions = doc.css('.recipe-instructions ol li').map { |e| e.content }
ingredients = ingredient_units.zip(ingredients).map { |a| a.join(' ') }

source = doc.css('td a').first.attributes['href'].value
author = doc.css('.recipe-meta tbody tr td')[4].content.strip.gsub(/\n/,'')

puts "### Source"
puts "[#{author}](#{source})"
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
puts "![#{title}](#{image})"
