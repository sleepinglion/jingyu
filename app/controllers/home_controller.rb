class HomeController < ApplicationController
  def index
    @notices = Notice.order('id desc').page(0).per(5)
    @questions = Question.order('id desc').page(0).per(5)
    @galleries = Gallery.order('id desc').page(0).per(24)
    @blogs = Blog.order('id desc').page(0).per(5)
  end

  def no_aside
    if params[:no_aside].present?
      if params[:no_aside]
        session[:no_aside]=true
      else
        session.delete(:no_aside)
      end
    end

    respond_to do |format|
      format.html {redirect_to root_path}
      format.json { render :json => '{result: true}' }
    end
  end

  def feed
    @blogs = Blog.all.where(:enable=>true)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def popup
    @meta_description=t(:meta_description_popup)
  end
end
