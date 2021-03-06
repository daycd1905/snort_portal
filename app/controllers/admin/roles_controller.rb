module Admin
  class RolesController < BaseController
    before_action :set_permissions

    def index
      @roles = Role.all
    end

    def new
      @role = RoleForm.new
    end

    def create
      @role = RoleForm.new(role_params)

      if @role.valid?
        @role = Role.create(role_params)
      end
      
      respond_with :admin, @role
    end

    def edit
      @role = Role.find_by_id(params[:id])
      
      respond_with(@role)
    end

    def update
      @role = Role.find_by_id(params[:id])
      @role.update(role_params)

      redirect_to action: :index
    end

    private

    def set_permissions
      @permissions = Permission.order(created_at: :asc).group_by(&:subject_class)
    end

    def role_params
      params.require(:role).permit(:name, permission_ids: [])
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