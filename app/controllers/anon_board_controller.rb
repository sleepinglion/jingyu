class AnonBoardController < BoardController
  before_action :check_edit_password, :only => [:edit]
  before_action :check_destroy_password, :only => [:destroy]
  before_action :check_confirm, :only => [:destroy]

  def initialize(*params)
    super(*params)
    @controller_name='게시판'
  end

  def confirm_delete
    gg=self.get_gg
    gid=gg.id
    @gid=gid
    gname=gg.class.name

    unless session[gname]
      session[gname]={}
    end

    unless session[gname][:guest_confirm_id]
      session[gname][:guest_confirm_id]=[]
    end

    if(params[:confirm])
      session[gname][:guest_confirm_id]<<gid
      redirect_to(:action=>'destroy',:id=>gid)
    end
  end

  def password_fail
    self.get_gg
  end

  def password
    self._password(self.password_fail,session[:next_action])
  end

  def privileges?
    self._privileges
  end

  protected

  def _privileges
    gg=self.get_gg
    @gname=gg.class.name
    @gid=gg.id

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

  def _password(gg,next_action)
    gid=gg.id
    gname=gg.class.name
    @gid=gid

    session[gname]||={}
    session[gname][:guest_pass_id]||=[]

    if session[gname][:guest_pass_fail]
      if session[gname][:guest_pass_fail].key?(gid)
        if session[gname][:guest_pass_fail][gid].to_i>3
          redirect_to(:action=>'password_fail',:id=>gid)
        end
      else
        session[gname][:guest_pass_fail][gid]=0
      end
    else
      session[gname][:guest_pass_fail]={}
      session[gname][:guest_pass_fail][gid]=0
    end

    if params[:password]
      if gg.authenticate(params[:password])
        session[gname][:guest_pass_id]<<gid
        redirect_to(:action=>next_action,:id=>gid)
      else
        session[gname][:guest_pass_fail][gid]=session[gname][:guest_pass_fail][gid].to_i+1
        flash.now[:notice]='비밀번호가 일치하지 않습니다.'
      end
    else
      flash.now[:notice]='비밀번호를 입력해주세요.'
    end
  end

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
