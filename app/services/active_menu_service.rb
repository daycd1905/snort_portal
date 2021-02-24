#
class ActiveMenuService
  attr_reader :controller,
              :options

  def initialize(controller, options = {})
    @controller = controller
    @options    = options
  end

  def exec
    return unless controller_name_valid?
    return unless action_name_valid?
    return unless params_valid?

    options[:active_class] || 'active'
  end

  private

  def controller_name_valid?
    return true if options[:controller_name].blank?

    controller_name.include? controller.controller_path
  end

  def action_name_valid?
    return true if options[:action_name].blank?

    action_name.include? controller.action_name
  end

  def params_valid?
    return true if options[:params].blank?

    (options[:params]).collect do |key, value|
      values = (value.is_a?(Array) ? value.map(&:to_s) : [value.to_s])
      
      return false unless values.include?(controller.params[key.to_sym].to_s)
    end

    true
  end

  def controller_name
    @controller_names ||= options[:controller_name].is_a?(Array) ? options[:controller_name] : [options[:controller_name]]
  end

  def action_name
    @action_name ||= options[:action_name].is_a?(Array) ? options[:action_name].map(&:to_s) : [options[:action_name].to_s]
  end
end