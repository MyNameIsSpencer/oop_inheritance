require 'httparty'
require 'json'
# require_relative 'mathgenius'
# require_relative 'quote_collector'



# This class represents a world traveller who knows what languages are spoken in each country
# around the world and can cobble together a sentence in most of them (but not very well)
class Multilinguist

  TRANSLTR_BASE_URL = "http://bitmakertranslate.herokuapp.com"
  COUNTRIES_BASE_URL = "https://restcountries.eu/rest/v2/name"
  #{name}?fullText=true
  #?text=The%20total%20is%2020485&to=ja&from=en


  # Initializes the multilinguist's @current_lang to 'en'
  #
  # @return [Multilinguist] A new instance of Multilinguist
  def initialize
    @current_lang = 'en'
  end

  def current_lang
    @current_lang
  end

  # Uses the RestCountries API to look up one of the languages
  # spoken in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] A 2 letter iso639_1 language code
  def language_in(country_name)
    params = {query: {fullText: 'true'}}
    response = HTTParty.get("#{COUNTRIES_BASE_URL}/#{country_name}", params)
    json_response = JSON.parse(response.body)
    json_response.first['languages'].first['iso639_1']
  end

  # Sets @current_lang to one of the languages spoken
  # in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] The new value of @current_lang as a 2 letter iso639_1 code
  def travel_to(country_name)
    local_lang = language_in(country_name)
    @current_lang = local_lang
  end

  # (Roughly) translates msg into @current_lang using the Transltr API
  #
  # @param msg [String] A message to be translated
  # @return [String] A rough translation of msg
  def say_in_local_language(msg)
    params = {query: {text: msg, to: @current_lang, from: 'en'}}
    response = HTTParty.get(TRANSLTR_BASE_URL, params)
    json_response = JSON.parse(response.body)
    json_response['translationText']
  end
end

# require_relative 'multilinguist'

class MathGenius < Multilinguist

  # def initialize
  #   # super
  # end

  def report_total(array_x)
    summed = array_x.sum
    msg = "The total of all the numbers you said is #{summed}"
    msg_2 = say_in_local_language(msg)
    puts msg_2
  end

end


class QuoteCollector < Multilinguist


  def initialize
    # super
    @collection = ["Trying is the first step towards failure"]
  end

  def pusher(quote)
    @collection << quote
  end

  def collection
    return @collection
  end

  def rando_quote
    quote = @collection.sample
    return say_in_local_language(quote)

  end



end






me = MathGenius.new
puts me.report_total([23,45,676,34,5778,4,23,5465]) # The total is 12048
me.travel_to("India")
puts me.report_total([6,3,6,68,455,4,467,57,4,534]) # है को कुल 1604
me.travel_to("Italy")
puts me.report_total([324,245,6,343647,686545]) # È Il totale 1030767


quoter = QuoteCollector.new
quoter.pusher("They say no 2 snowflakes look alike but I'm not wearing my glasses")
quoter.pusher("Here on my left is the seat of fallacy, there on my right is the ladder of madness")
quoter.pusher("Where are my pants?")
quoter.pusher("I'm tired of those damned pigeons pooping in my coffee in the morning")
quoter.pusher("Do you love cheese?  I love cheese")
quoter.pusher("There comes a time in everyone's life, young and old, man and woman, far and near, when we must eat fruitcake")

puts quoter.collection.inspect

puts '*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*'
puts quoter.rando_quote
quoter.travel_to("China")
puts quoter.rando_quote
quoter.travel_to("Mexico")
puts quoter.rando_quote
quoter.travel_to("France")
puts quoter.rando_quote




puts "|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|"
