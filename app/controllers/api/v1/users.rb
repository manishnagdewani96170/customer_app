module API
  module V1
    class Users < Grape::API
      include API::V1::Concerns::Controller
      before { authenticate_api_call }

      resources :users do
       
        desc "List of users"
        params do
          requires :role, type: String, default: 'customer'
        end
        get "", jbuilder: Users.view_path("users/index") do
          validate_role(params[:role])
          authorize! :list, User
          users  = User.role_based_user(params[:role])
          @users = paginate(users)
        end

        
        desc "Show User"
        params do
          requires :id, type: Integer
        end
        get "/:id", jbuilder: Users.view_path("users/show") do
          @user = User.find(params[:id])
          authorize! :read, @user
        end

        desc "Delete User"
        params do
          requires :id, type: Integer
        end
        delete "/:id" do
          @user = User.find(params[:id])
          authorize! :delete, @user
          @user.destroy!
          {}
        end

        desc "Create new User"
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :role, type: String, default: 'customer'
            requires :user_name, type: String
            requires :gender, type: String, default: 'M'
            optional :date_of_birth, type: Date
            optional :phone_number, type: String
          end
        end
        post "", jbuilder: Users.view_path("users/show") do
          authorize! :create, User
          role = validate_role(params[:user][:role])
          @user = role.create_user(params[:user])
        end
      end
    end
  end
end        