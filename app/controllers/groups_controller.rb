class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  def index
    @groups = Group.all

  end
  def new
    @group = Group.new
  end
def create#新增
  @group = Group.new(group_params)
    @group.user = current_user
  if @group.save

   redirect_to groups_path
  else
   render :new
  end
end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
end

def edit#编辑
  @group = Group.find(params[:id])
  if current_user != @group.user  #!=的意思是不等于
      redirect_to root_path, alert: "You have no permission."
  end
end
def update#修改新的内容
  @group = Group.find(params[:id])
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
  @group = Group.find(params[:id])
  if current_user != @group.user
     redirect_to root_path, alert: "You have no permission."
   end
  @group.destroy
  flash[:alert] = "Group deleted"
  redirect_to groups_path

end


private

def group_params
  params.require(:group).permit(:title, :description)

end



end
