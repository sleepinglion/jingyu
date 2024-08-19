class BoardController < ApplicationController
  #impressionist :actions=>[:show]
  before_action :authenticate_user!, :except => [:index,:show]
end
