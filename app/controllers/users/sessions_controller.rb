class Users::SessionsController < Devise::SessionsController
  def initialize(*params)
    super(*params)   
    @controller_name=t(:login)
  end

  def index
  
  end
end