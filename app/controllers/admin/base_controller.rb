module Admin
  class BaseController < ApplicationController
    protect_from_forgery with: :exception
    before_action :authenticate_user!

    respond_to :html
    layout 'admin'

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def paging(collection)
      per_page = (params['per_page'] || 10).to_i

      collection.paginate(page: params[:page], per_page: per_page)
    end    
  end
end