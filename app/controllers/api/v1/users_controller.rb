class Api::V1::UsersController < Api::V1::BaseController
    
    skip_before_action :authenticate, only: [:create, :index]
    
    # resource description
    resource_description do
      short 'APIs for managing user actions'
    end
    
    # common parameter
    def_param_group :user do
      param :user, Hash, required: true do
        param :email, String, desc: 'email for the user', required: true
        param :password, String, desc: 'Password for the user', required: true
        param :password_confirmation, String, desc: 'Password confirmation for the user password', required: true
      end
    end
    
    api 'POST', '/v1/user/create', 'Create new user'
    param_group :user    
    def create
      begin
        @user = User.new user_params
        if @user.save
            render json: {success: true, message: I18n.t('user.success_add_msg'), data: UserSerializer.new(@user, root: 'user')}, status: 201
        else
          render json: {success: false, message: @user.errors.full_messages, data: {}}, status: 400
        end        
      rescue Exception => e
        error_msg = e.message
        render json: {success: false, message: error_msg, data: {}}, status: 400
      end
    end
    
    api 'GET', '/v1/user/list', 'Get list of all users'      
    def index
        @users = User.all        
        render json: {success: true, message: I18n.t('success.success_msg'), data: ActiveModel::ArraySerializer.new(@users, each_serializer: UserSerializer, root: 'user')}, status: 200  if @users.present?
        render json: {success: false, message: I18n.t('user.empty'), data: {}}, status: 200  unless @users.present?                  
    end
    
    private
      
      def user_params
        params.require(:user).permit :email, :password, :password_confirmation
      end
end