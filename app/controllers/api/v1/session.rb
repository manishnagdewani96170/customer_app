module API
  module V1
    class Session < Grape::API
      include API::V1::Concerns::Controller

      resources :session do
        desc "Sign in"
        params do
          requires :session, type: Hash do
            requires :email, type: String, allow_blank: false
            requires :password, type: String, allow_blank: false
          end
        end
        post "", jbuilder: Session.view_path("session/show") do
          email = declared_params[:session][:email]
          password = declared_params[:session][:password]
          user = fetch_user_by_credentials(email, password)

          if can_login?(user, password)
            login_user(user)
          else
            raise_login_error(email)
          end
        end
      end

      helpers do
        def fetch_user_by_credentials(email, password)
          user = User.find_by_email(email.downcase)
          user
        end

        def can_login?(user, password)
          user && user.valid_password?(password)
        end
      end  
    end
  end
end        