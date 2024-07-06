module BoardHelper
  def link_to_delete(obj,parent=nil)

    if(checkPriv(obj))
      if(parent)
        return link_to '삭제', [parent,obj] ,  method: :delete, data: { confirm: '정말로 삭제합니까?' }
      else
        return link_to '삭제', obj, method: :delete, data: { confirm: '정말로 삭제합니까?' }
      end
    else
      if(parent)
        return link_to '삭제', [parent,obj], method: :delete
      else
        return link_to '삭제', obj, method: :delete
      end
    end
  end

  def checkPriv(obj)
    gg=obj
    gname=gg.class.name
    gid=gg.id

   # if(current_user.admin)
   #   return true
   # end

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

    unless session.key?(gname)
      return false
    else
      if session[gname][:guest_pass_id]
        unless session[gname][:guest_pass_id].include?(gid)
          return false
        end
      else
        return false
      end
    end

    return true
  end


  def userName(gg,length=false)
    if length
      if gg.user
        return gg.user.nickname
      else
        return gg.name
      end
    else
      if gg.user
        return gg.user.nickname
      else
        return gg.name
      end
    end
  end
end
