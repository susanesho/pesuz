APP_ROOT = __dir__
require_relative "./config/application.rb"
use Rack::Reloader, 0
use Rack::MethodOverride
SuzsnamApplication = Suzsnam::Application.new
require_relative "./config/routes.rb"
run SuzsnamApplication