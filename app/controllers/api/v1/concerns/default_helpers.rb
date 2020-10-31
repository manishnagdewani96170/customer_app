# frozen_string_literal: true
module API::V1
  module Concerns
    module DefaultHelpers
      extend ActiveSupport::Concern
     
      included do
        helpers do

          def raise_login_error(email)
            message = "Incorrect email or password"
            raise(APIError.new(403, "Access Denied", message))
          end

          
          def current_user
            @current_user ||= begin
              token = headers["X-Authentication-Token"]
              if token.present?
                User.find_by(authentication_token: token)
              end  
            end
          end


          def authenticate_api_call
            fail(CanCan::AccessDenied.new("Access Denied")) if headers["X-Forwarded-For"] == ENV['ACCOUNT_APP_DOMAIN']
          end

          def validate_role(role_code)
            role = Role.find_by(role_code: role_code)
            raise(APIError.new(400, "Invalid Request", "Role not exist")) unless role
            role
          end  


          def authorize!(*args)
            result = Ability.new(current_user).authorize!(*args)
            result
          rescue CanCan::AccessDenied => error
            raise(error)
          end

          def can?(*args)
            Ability.new(current_user).can?(*args)
          end

          def declared_params
            @declared_params ||= declared(params, include_missing: false)
          end

        end
      end
    end
  end
end
