class AboutController < ApplicationController
  def initialize(*params)
    super(*params)   
    @controller_name=t('activerecord.models.site')
    @meta_description=t(:meta_description_about)
    @page_itemtype="http://schema.org/AboutPage"    
  end

  def index
    
  end
end
