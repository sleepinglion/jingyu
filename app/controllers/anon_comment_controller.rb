class AnonCommentController < AnonBoardController
  def initialize(*params)
    super(*params)
    @controller_name='댓글'
  end
  
  protected  
  
  def check_confirm 
    if self.privileges?
      return true
    end
    
    unless params[:confirm]
      redirect_to(:action=>'confirm_delete',:id=>@gid)
    end
  end
  
  def check_destroy_password
    if self.privileges?
      return true
    end
    
    session[:next_action]='confirm_delete'
    redirect_to(:action=>'password',:id=>@gid)
  end
  
  def check_edit_password
    if self.privileges?
      return true
    end
    
    session[:next_action]='edit'
    redirect_to(:action=>'password',:id=>@gid)
  end
end