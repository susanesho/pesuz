require "coveralls"
require "pesuz"
require "pry"
require "rack"
require "rspec"
require_relative "../spec/integration/suzsnam/config/application.rb"

Coveralls.wear!
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

RSpec.configure do |conf|
  conf.include FactoryGirl::Syntax::Methods

  conf.before(:suite) do
    FactoryGirl.find_definitions
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

