require 'rubygems'
require 'nokogiri'
require 'open-uri'

def connect
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

  townhalls = Array.new(0)

  page.css('//a[@class=lientxt]/@href').each.with_index do |href, index|
    complete_url = "http://annuaire-des-mairies.com/#{href.to_s[2, href.to_s.length]}"
    townhall = Nokogiri::HTML(URI.open(complete_url))

    city = townhall.css("h1")[1].text.split(" - ")[0].to_s
    email = townhall.css("tr.txt-primary")[3].css("td")[1].text.to_s
    
    townhalls[index] = { city => email }

    puts "La mairie de #{city} a l'adresse email #{email}"

  end

  return townhalls
end

connect()
