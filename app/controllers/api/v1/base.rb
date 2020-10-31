# frozen_string_literal: true

module API
  module V1
    class APIError < StandardError
      attr :status, :name, :message

      def initialize(status, name, message)
        @status, @name, @message = status, name, message
      end
    end

    class SemanticError < APIError
      def initialize(message)
        super(422, "Semantic Error", message)
      end
    end

    class Base < Grape::API
      mount API::V1::Session
      mount API::V1::Users
      
      add_swagger_documentation

      route :any, "*path" do
        error!({ error:  "Not Found",
                 message: "No such route '#{request.path}'",
                 status: "404" },
               404)
      end
    end
  end
end
