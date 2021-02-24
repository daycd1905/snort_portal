module ApplicationHelper
  def active_menu(options = {})
    ActiveMenuService.new(controller, options).exec
  end
end
