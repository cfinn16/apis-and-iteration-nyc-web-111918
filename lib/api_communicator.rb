require 'rest-client'
require 'json'
require 'pry'


# url = "http://www.swapi.co/api/people/""
#
# def response_hash(url)
#   response_string = RestClient.get(url)
#   response_hash = JSON.parse(response_string)
# end
#
# until response_hash(url)["results"]character["name"].downcase == character_name
#
#
# end




# person = response_hash["results"].select do |character|
#   character["name"].downcase == character_name
# end
#
# person[0]["films"].map do |film_url|
#   films_string = RestClient.get("#{film_url}")
#   films_hash = JSON.parse(films_string)
# end

# def create_array
#   arr = []
#  count = 1
#  while count < 10
#    response_string = RestClient.get('http://www.swapi.co/api/people/?page=' + count.to_s)
#    arr << JSON.parse(response_string)
#    count += 1
#  end
#  arr
# end

def get_response_hash(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end


def get_character_movies_from_api(character_name)
  #make the web request
  character_name = character_name.downcase

  url = 'http://www.swapi.co/api/people/'
  hash = get_response_hash(url)

  until hash["results"].any? { |person| person["name"] = character_name }
    url = hash["next"]
  end

  person = hash["results"].select do |person|
    person["name"] = character_name
  end

  person[0]["films"].map do |film_url|
    get_response_hash(film_url)
  end




  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts "#{film["title"]}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end




## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
