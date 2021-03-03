module Admin
  class SnortRulesController < BaseController
    before_action :set_authorization
    
    def index
      @rules = paging SnortRule.all
    end

    def new
      @rule = SnortRuleForm.new
    end

    def create
      @rule = SnortRuleForm.new(rule_params)

      if @rule.valid?
        @rule = SnortRule.create(rule_params)
        error_msg = SnortApiService::SaveRuleService.new.execute

        if error_msg == ""
          flash[:success] = "Save rule successfully!"
          @rules = paging SnortRule.all
          redirect_to action: "index"
        else
          flash[:error]= "Failed to save rule to snort"
          @rules = paging SnortRule.all
          render 'index'
        end
      else
        render :new
      end
    end

    def restart_snort
      error_msg = SnortApiService::RestartSnort.new.execute

      if error_msg == ""
        flash[:success] = "Restart successfully!"
        @rules = paging SnortRule.all
        redirect_to action: "index"
      else
        flash[:error]= "Failed to restart"
        @rules = paging SnortRule.all
        render 'index'
      end
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