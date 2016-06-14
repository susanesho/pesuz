require "coveralls"
require "pesuz"
require "rack"
require "rspec"
# require_relative "../spec/integration/suzsnam/config/application.rb"

Coveralls.wear!
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

module Suzsnam
  class Application < Pesuz::Application
  end
end

RSpec.shared_context type: :feature do
  require "capybara/rspec"
  before(:all) do
   app = Rack::Builder.parse_file(
     "#{__dir__}/integration/suzsnam/config.ru"
   ).first
   Capybara.app = app
  end
end

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
