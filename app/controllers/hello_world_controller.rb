class HelloWorldController < ApplicationController
  before_action :authenticate_user!
  layout "hello_world"

  def index
    @name = "Davy Brine"
  end
end