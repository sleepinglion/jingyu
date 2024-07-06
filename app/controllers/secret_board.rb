module SecretBoard
  def read_password_fail
    
  end
  
  def read_password
    self._read_password
  end
  
  def read_privileges?
    self._read_privileges
  end
  
  protected
  
  def _read_privileges
    gg=self.get_gg
    @gname=gg.class.name 
    @gid=gg.id
    
    unless gg.secret?
      return true
    end
    
    if(gg.user_id)
      if(current_user)
        if(current_user.id===gg.user_id)
          return true
        else
          return false
        end
      else
        return false
      end
    end
    
    unless session.key?(@gname)
      return false
    else
      if session[@gname][:guest_pass_id]
        unless session[@gname][:guest_pass_id].include?(@gid)
          return false
        end
      else
        return false
      end
    end
    
    return true
  end
  
  def _read_password
    gg=self.get_gg
    @gid=gg.id
    @gname=gg.class.name
    
    session[@gname]||={}    
    session[@gname][:guest_pass_id]||=[]
    
    if session[@gname][:guest_pass_fail]
      if session[@gname][:guest_pass_fail].key?(@gid)
        if session[@gname][:guest_pass_fail][@gid].to_i>3
          render(:action=>'read_password_fail',:id=>@gid)
        end
      else
        session[@gname][:guest_pass_fail][@gid]=0
      end
    else
      session[@gname][:guest_pass_fail]={}
      session[@gname][:guest_pass_fail][@gid]=0
    end
    
    if(params[:password])
      if params[:password]==gg.password
        session[@gname][:guest_pass_id]<<@gid
        redirect_to(:action=>'show',:id=>@gid)
      else
        session[@gname][:guest_pass_fail][@gid]=session[@gname][:guest_pass_fail][@gid].to_i+1
        flash.now[:notice]='비밀번호가 일치하지 않습니다.'
      end
    else
      flash.now[:notice]='비밀번호를 입력해주세요.'
    end
  end
  
  def check_secret
    if self.read_privileges?
      return true
    end
    
    redirect_to(:action=>'read_password',:id=>@gid)
  end
end