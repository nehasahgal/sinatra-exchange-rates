require "sinatra"
require "sinatra/reloader"

get("/") do

 erb(:homepage)
end

get("/:country_one") do
  @country_one = params.fetch("country_one")
  erb(:country_one)
  
end
