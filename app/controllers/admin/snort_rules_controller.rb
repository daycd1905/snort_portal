module Admin
  class SnortRulesController < BaseController
    before_action :set_authorization
    
    def index
      @rules = paging SnortRule.all.order(created_at: :desc)
    end

    def new
      @rule = SnortRuleForm.new
    end

    def create
      error_msg = ""
      @rule = SnortRuleForm.new(rule_params)

      if @rule.valid?
        begin
          @rule = SnortRule.create(rule_params)
          error_msg = SnortApiService::SaveRule.new.execute

          raise error_msg if error_msg.present?

          flash[:success] = "Save rule successfully!"
          @rules = paging SnortRule.all.order(created_at: :desc)
          redirect_to action: "index"
        rescue StandardError => e
          flash[:error]= error_msg
          @rules = paging SnortRule.all.order(created_at: :desc)
          redirect_to action: "index"
        end
      else
        render :new
      end
    end

    def show
      @rule = SnortRule.find_by_id(params[:id])
      
      respond_with(@rule)
    end

    def edit
      @rule = SnortRule.find_by_id(params[:id])
      
      respond_with(@rule)
    end

    def update
      error_msg = ""
      @rule = SnortRule.find_by_id(params[:id])

      begin
        @rule.update(rule_params)
        error_msg = SnortApiService::SaveRule.new.execute

        raise error_msg if error_msg.present?

        flash[:success] = "Save rule successfully!"
        @rules = paging SnortRule.all.order(created_at: :desc)
        redirect_to action: "index"
      rescue StandardError => e
        flash[:error]= error_msg
        render 'edit'
      end
    end

    def restart_snort
      error_msg = SnortApiService::RestartSnort.new.execute

      if error_msg == ""
        flash[:success] = "Restart successfully!"
        @rules = paging SnortRule.all
        redirect_to action: "index"
      else
        flash[:error]= error_msg
        @rules = paging SnortRule.all
        render 'index'
      end
    end

    def save_rule
      error_msg = SnortApiService::SaveRule.new.execute
    
      if error_msg == ""
        flash[:success] = "Save Rules successfully!"
        @rules = paging SnortRule.all
        redirect_to action: "index"
      else
        flash[:error]= error_msg
        @rules = paging SnortRule.all
        render 'index'
      end
    end

    def deactive_rule
      @rule = SnortRule.find_by_id(params[:id])

      @rule.update(status: false)
      render 'show'
    end

    def active_rule
      @rule = SnortRule.find_by_id(params[:id])

      @rule.update(status: true)
      render 'show'
    end

    def destroy
      @rule = SnortRule.find_by_id(params[:id])
      
      @rule.destroy
      redirect_to action: 'index'
    end
  
    private

    def rule_params
      params.require(:snort_rule).permit(:action, :protocol, :src_address, :src_port, :direction, :dest_address, :dest_port, :status, :options)
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