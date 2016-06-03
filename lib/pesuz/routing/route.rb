require "pesuz/utility/utility"
module Pesuz
  module Routing
    class Route
      attr_reader :klass_name, :request, :method_name
      def initialize(request, klass_and_method)
        @klass_name, @method_name = klass_and_method
        @request = request
      end

      def klass
        klass_name.constantize
      end

      def dispatch
        controller = klass.new(request)
        controller.send(method_name)
        controller.render(method_name) unless controller.get_response
        controller.get_response
      end
    end
  end
end
