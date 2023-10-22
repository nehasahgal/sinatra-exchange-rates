require "sinatra"
require "sinatra/reloader"

get("/") do

 erb(:homepage)
end

get("/:country_one") do
  @country_one = params.fetch("country_one")
  erb(:country_one)
  
end

get("/:country_one/:country_two") do
  @country_one = params.fetch("country_one")
  @country_two = params.fetch("country_two")
  erb(:result)
end
