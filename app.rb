#require "sinatra"
#require "sinatra/reloader"

#get("/") do

# erb(:homepage)
#end

#get("/:country_one") do
#  @country_one = params.fetch("country_one")
#  erb(:country_one) 
#end

#get("/:country_one/:country_two") do
#  @country_one = params.fetch("country_one")
#  @country_two = params.fetch("country_two")
#  erb(:result)
#end


require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

# define a route
get("/") do

  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
  
  # convert the raw request to a string
  raw_data_string = raw_data.to_s


  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  @currencies_hash = @parsed_data.fetch("currencies")

  erb(:homepage)
end

  get("/:from_currency") do
      # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
  
  # convert the raw request to a string
  raw_data_string = raw_data.to_s


  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  @currencies_hash = @parsed_data.fetch("currencies")
    @from_currency = params.fetch("from_currency")
  
    
    # some more code to parse the URL and render a view template
    erb(:country_one)
  end
  
  get("/:from_currency/:to_currency") do
    
    @original_currency = params.fetch("from_currency")
    @destination_currency = params.fetch("to_currency")
  
    api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
    
    raw_response = HTTP.get(api_url)

    parsed_data = JSON.parse(raw_response)

    @result = parsed_data.fetch("result")
    
    erb(:result)

  end
