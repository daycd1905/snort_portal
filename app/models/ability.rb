#
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_admin?
      can :manage, :all
    else
      user.permissions.each do |permission|
        resource = begin
          permission.subject_class.constantize
        rescue => _e
          permission.subject_class
        end

        can permission.action.to_sym, resource
      end
    end
  end
end
