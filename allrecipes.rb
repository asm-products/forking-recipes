require 'rubygems'
require 'nokogiri'
require 'open-uri'

urls = ["http://allrecipes.com/recipe/thai-steamed-mussels/detail.aspx"]

urls.each do |url|
  doc = Nokogiri::HTML(open(url))

  title = doc.css('title').first.content.scan(/\r\n\t(.*) -/).first
  puts title

  image = doc.css('img#imgPhoto').first.attributes['src'].value
  image_title = doc.css('img#imgPhoto').first.attributes['title'].value

  ingredients = doc.css('#liIngredient').map { |e| e.content.strip.gsub(/\r\n +/, ' ') }
  directions = doc.css('.directLeft li').map { |e| e.content }


  puts "### Source"
  puts "[AllRecipes](#{url})"
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
  puts "![#{image_title}](#{image})"

  gets
  puts "-" * 200
end
