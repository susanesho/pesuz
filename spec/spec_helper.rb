require "pesuz"
require "pry"
require "rack"
require "rspec"
require "simplecov"

SimpleCov.start
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

require "#{__dir__}/integration/suzsnam/config/application.rb"

require "rack/test"

# RSpec.shared_context type: :feature do
#   require "capybara/rspec"
#   before(:all) do
#    app = Rack::Builder.parse_file(
#      "#{__dir__}/integration/suzsnam/config.ru"
#    ).first
#    Capybara.app = app
#   end
# end

ENV["RACK_ENV"] = "test"

def create(n)
  todos = []
  n.times  do
    todo = Todo.new
    todo.name = Faker::StarWars.planet
    todo.body = Faker::StarWars.quote
    todo.created_at = Time.now.to_s
    todo.save
    todos << todo
  end
  todos
end
