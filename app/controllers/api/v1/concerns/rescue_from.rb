# frozen_string_literal: true

module API::V1
  module Concerns
    module RescueFrom
      extend ActiveSupport::Concern

      included do
        format_message = -> (error, _klass) do
          message = error.message
          message
        end

        rescue_from Grape::Exceptions::ValidationErrors,
          ActiveRecord::RecordInvalid,
          BaseService::ValidationError do |e|
          error_response status: 400, message: {
            error: "Validation Error",
            message: format_message.call(e, BaseService::ValidationError)
          }
        end

        rescue_from CanCan::AccessDenied do |e|
          message, full_message = format_message(e, CanCan::AccessDenied)
          error_response status: 403, message: {
            error: "Access Denied",
            message: message
          }
        end

        rescue_from APIError do |e|
          error_response status: e.status, message: {
            error: e.name,
            message: format_message.call(e, APIError)
          }
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response status: 404, message: {
            error: "Not Found",
            message: format_message.call(e, ActiveRecord::RecordNotFound)
          }
        end

        rescue_from :all do |e|
          Rails.logger.error(e)

          backtrace = e.backtrace || []
          ruby_gems_traces = Regexp.new('/ruby-.\\..\\../gems/.+')
          cleaned_backtrace = backtrace.reject { |line| line.match(ruby_gems_traces) }
          cleaned_backtrace.join("\n")
          message = "#{e.message}\n#{cleaned_backtrace}"

          error_response status: 500, message: {
            error: "Server Fault",
            message: message
          }
        end
      end
    end
  end
end
