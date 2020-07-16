require 'rubygems'
require 'nokogiri'
require 'open-uri'

def connect
  page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))

  deputes = Array.new(0)

  page.css('//div[@id=deputes-list]//a').take(20).each.with_index do |link, index|
    if index > 0
      complete_url = "http://www2.assemblee-nationale.fr/#{link["href"].to_s}"
      depute = Nokogiri::HTML(URI.open(complete_url))

      begin
        full_name = depute.css('.titre-bandeau-bleu h1').text.to_s.split(" ")
        first_name = full_name[1].to_s
        last_name = full_name[2].to_s
      rescue => e
        first_name = "Non défini"
        last_name = "Non défini"
      end

      begin
        email = depute.css("a[href^=mailto]")[1].text.to_s
      rescue => e
        email = "Non défini"
      end

      deputes[index] = {
        "first_name" => first_name,
        "last_name" => last_name,
        "email" => email
      }

      puts "Le député #{last_name} #{first_name} peut être contacté via l'email : #{email}"
    end
  end

  return deputes
end

connect()
