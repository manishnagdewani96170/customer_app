# frozen_string_literal: true

module API::V1
  module Concerns
    module Controller
      extend ActiveSupport::Concern

      included do

        version "v1"
        format :json
        default_format :json
        default_error_formatter :json

        formatter :json, Grape::Formatter::Jbuilder

        def self.view_path(name)
          "v1/" + name.to_s
        end
      end

      include DefaultHelpers
      include RescueFrom
    end
  end
end
