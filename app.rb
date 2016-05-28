# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require

# Our data table
all_things = [
 { :name => "team1-lemonheads", :value => "incomplete" },
 { :name => "team2-teethbrains", :value => "incomplete" },
 { :name => "team3-scuzzbuckets", :value => "incomplete" },
 { :name => "team4-turniptoes", :value => "incomplete" },
 { :name => "team5-brainiacs", :value => "incomplete" },
 { :name => "team6-noddyears", :value => "incomplete" },
 { :name => "team7-fennelteeth", :value => "incomplete" },
 { :name => "team8-britneybums", :value => "incomplete" },
]

get '/' do
  halt 404
end

get '/sponmed332/:namevalue' do
  content_type :json
  @thing = all_things.select do |item|
    item[:name] == params[:namevalue]
  end.first

  if @thing
    @thing.to_json
  else
    halt 404
  end
end

get '/sponmed332/get/all' do
  content_type :json

  all_things.to_json
end

get '/update/:namevalue/:newvalue' do
  all_things.map! do |item|
    if item[:name] == params[:namevalue]
      { :name => params[:namevalue], :value => params[:newvalue] }
    else
      item
    end
  end

  @thing = all_things.select do |item|
    item[:name] == params[:namevalue]
  end.first

  if @thing
    "cheers"
  else
    halt 404, "sorry, check your team name"
  end
end

