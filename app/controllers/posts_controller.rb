class PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destory, :join , :quit, :image]
  before_action :find_group

  def new
   @group = Group.find(params[:group_id])
   @post = Post.new
     if !current_user.is_member_of?(@group)
   	 	 	redirect_to group_path(@group), alert: "加入群组成员才可以发表文章."
  	end
 end

  def edit
    @post = @group.posts.find(params[:id])
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

  def update
   @post = @group.posts.find(params[:id])

   if @post.update(post_params)
     redirect_to group_path(@group), notice: "文章修改成功！"
   else
     render :edit
   end
 end


  def destroy
    @post = @group.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "文章已刪除"
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:note)
  end
end
