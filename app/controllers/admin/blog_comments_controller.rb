class Admin::BlogCommentsController < Admin::AdminController
  def show   
    @recipe_comment = RecipeComment.find(params[:id])
    @parent=@recipe_comment.recipe
    return @recipe_comment
  end
  
  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_comments=@recipe.recipe_comment.order('id desc').page(params[:page]).per(10)    
  end  
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    if(current_user)
      params[:recipe_comment][:user_id]=current_user.id
    end
    @recipe_comment = @recipe.recipe_comment.create(params[:recipe_comment])
    redirect_to recipe_path(@recipe)
  end
 
  def destroy
    @recipe_comment = RecipeComment.find(params[:id])
    @recipe_comment.destroy
    
    redirect_to recipe_path(@recipe_comment.recipe)    
  end
end
