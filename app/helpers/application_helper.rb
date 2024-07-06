module ApplicationHelper
  def link_to_home
    link_to('홈', root_path, :title => '홈으로')
  end

  def manage_width(model)
    if can?(:delete, model) && can?(:update, model)
      return 'style="width:150px;"'
    else
      return 'style="width:90px"'
    end
  end

  def sl_get_thumb(url, type = 'origin')

    if type == 'origin'
      return url
    end

    case type
    when 'large'
      prefix = 'large_thumb'
    when 'medium'
      prefix = 'medium_thumb'
    when 'small'
      prefix = 'small_thumb'
    end

    url.gsub(File.basename(url), prefix + '_' + File.basename(url))
  end

  def flagToString(flag, no_html = false)
    if no_html
      if flag
        return t(:flag_true)
      else
        return t(:flag_false)
      end
    else
      if flag
        return '<span class="flag_true">' + t(:flag_true) + '</span>'
      else
        return '<span class="flag_false">' + t(:flag_false) + '</span>'
      end
    end
  end

  def actionNameChange(action_name)
    case action_name
    when 'index'
      return t(:action_index)
    when 'new'
      return t(:action_new)
    when 'edit'
      return t(:action_edit)
    when 'show'
      return t(:action_show)
    else
    end
  end

  def manage_width(model)
    if can?(:delete, model) && can?(:update, model)
      return 'style="width:180px;"'
    else
      return 'style="width:90px"'
    end
  end

  def get_dt_format(date)
    return I18n.l date, :format => :long
  end
end
