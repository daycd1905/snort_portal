module Admin
  class UsersController < BaseController
    before_action :set_authorization

    def index
      @users = paging User.all
    end

    def new
      @user = UserForm.new
    end

    def create
      @user = UserForm.new(user_params)
      
      if @user.valid?
        @user = User.create(user_params)

        redirect_to action: "index"
      else
        render :new
      end
    end

    def show
      @user = User.find_by_id(params[:id])
      
      respond_with(@user)
    end

    def edit
      @user = User.find_by_id(params[:id])
      
      respond_with(@user)
    end

    def update
      @user = User.find_by_id(params[:id])
      @user.update(user_params)

      respond_with @user, location: admin_user_path(@user)
    end

    private

    def user_params
      params.require(:user).permit(:username, :name, :phone, :email, :password, :password_confirmation, role_ids: [])
    end

    def set_authorization
      begin  
        case action_name
        when 'edit', 'update'
          authorize!(:update, @user || User)
        when 'new', 'create'
          authorize!(:create, @user || User)
        when 'destroy'
          authorize!(:destroy, @user || User)
        else
          authorize!(:read, @user || User)
        end
      rescue => e
        render(
        html: "<script>alert('You do not have permission to access that action!')</script>".html_safe,
          layout: 'admin'
        )
      end
    end
  end
end