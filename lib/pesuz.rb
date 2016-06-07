require "pesuz/version"
require "pesuz/controller"
require "pesuz/utility/utility"
require "pesuz/utility/dependencies"
require "pesuz/routing/mapper"
require "pesuz/routing/route"
require "pesuz/routing/router"

module Pesuz
  class Application
    attr_reader :routes

    def initialize
      @routes = Routing::Router.new
    end

    def call(env)
      @request = Rack::Request.new(env)
      route = mapper.map_to_route(@request)
      if route
        route.dispatch
      else
        [404, {}, ["Route not found"]]
      end
    end

    def mapper
      @mapper ||= Routing::Mapper.new(routes.endpoints)
    end
  end
end
