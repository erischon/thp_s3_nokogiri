require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(URI.open("http://en.wikipedia.org/"))   
puts page.class   # => Nokogiri::HTML::Document

puts page.css("title")[0].name
puts page.css("title")[0].text