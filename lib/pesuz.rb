require "pesuz/version"
require "pesuz/utility/utility"
require "pesuz/routing/router"

module Pesuz
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [ 302, { "location" => "pages"}, [] ]
      end
      @rack_reqst = Rack::Request.new(env)
      path = @rack_reqst.path_info
      request_method = @rack_reqst.request_method.downcase
      return [500, {}, []] if path == "/favicon.ico"
      controller, action = get_controller_and_action_for(path, request_method)
      response = controller.new.send(action)
      [200, {"Content-Type" => "text/html"}, [response]]
    end

    def get_controller_and_action_for(path, verb)
      _, controller, action, others = path.split("/", 4)
      require "#{controller.downcase}_controller.rb"
      controller = Object.const_get(controller.capitalize! + "Controller")
      action = action.nil? ? verb : "#{verb}_#{action}"
      [controller, action]
    end
  end
end
