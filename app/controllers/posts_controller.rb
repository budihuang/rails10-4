
class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit#编辑
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if current_user != @group.user  #!=的意思是不等于
        redirect_to root_path, alert: "You have no permission."
    end
  end
  def update#修改新的内容
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
   if current_user != @group.user
    redirect_to root_path,alert: "you are no permission"
   end
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy#删除

    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if current_user != @group.user
       redirect_to root_path, alert: "You have no permission."
     end
    @group.destroy
    flash[:alert] = "Group deleted"
    redirect_to groups_path

  end



  private

  def post_params
    params.require(:post).permit(:content)
  end

end
