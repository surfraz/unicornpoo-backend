# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
Bundler.require
require 'json/pure'

# Our data table
all_things = [
 { :name => "team1-lemonheads", :value => "incomplete", :count => 0 },
 { :name => "team2-teethbrains", :value => "incomplete", :count => 0 },
 { :name => "team3-scuzzbuckets", :value => "incomplete", :count => 0 },
 { :name => "team4-turniptoes", :value => "incomplete", :count => 0 },
 { :name => "team5-brainiacs", :value => "incomplete", :count => 0 },
 { :name => "team6-noddyears", :value => "incomplete", :count => 0 },
 { :name => "team7-fennelteeth", :value => "incomplete", :count => 0 },
 { :name => "team8-britneybums", :value => "incomplete", :count => 0 },
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
      { :name => params[:namevalue],
        :value => params[:newvalue],
        :count => item[:count] + 1 }
    else
      item
    end
  end

  @thing = all_things.select do |item|
    item[:name] == params[:namevalue]
  end.first

  if @thing
    @thing.to_json
  else
    halt 404, "sorry, check your team name"
  end
end

