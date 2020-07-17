require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_currencies
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

  cryptos = Array.new(0)

  page.css(".cmc-table-row").each.with_index do |line, index| # boucle pour extraire les informations
    
    symbol = line.css(".cmc-table__cell--sort-by__symbol").text
    price = line.css(".cmc-table__cell--sort-by__price").text.gsub("$", "").gsub(",", "").to_f

    cryptos[index] = { symbol => price } # On met les Hashs dans un Array

    puts "Couple Sigle et Prix (#{index}) :" + cryptos[index].to_s # On met un petit message

  end

  return cryptos
end

get_currencies()