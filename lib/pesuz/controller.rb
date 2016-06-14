require "tilt"

module Pesuz
  class Controller
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def params
      request.params
    end

    def response(body, status = 200, header = {})
      @response = Rack::Response.new(body, status, header)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end

    def get_instance_variables
      vars = {}
      instance_variables.each do |var|
        key = var.to_s.delete("@").to_sym
        vars[key] = instance_variable_get(var)
      end
      vars
    end

    def render_template(view_name, locals = {})
      template = Tilt::ERBTemplate.new(
        File.join(
          APP_ROOT,
          "app",
          "views",
          controller_name,
          "#{view_name}.html.erb"
        )
      )
      template.render(self, locals.merge(get_instance_variables))
    end

    def redirect_to(url)
      @response = Rack::Response.new({}, 302, "location" => url)
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").snakize
    end
  end
end
