class UsersController < ApplicationController
  
  def new
  @user=User.new
  end

  def create
  @user = User.new
  @user.name = params[:user][:name]
  @user.email = params[:user][:email]
  @user.save
  flash[:notice] = "User Created Successfully!"
  redirect_to stories_url
  end
  
  def edit
  @user=User.find_by_id(params[:id])
  end
  
  def update
  @user=User.find_by_id(params[:id])
  @user.update_attributes(params[:user])
  @user.save
  flash[:notice] = "User Updated Successfully!"
  redirect_to stories_url
end

  def index
  @users=User.all
  end

  def destroy
  u=User.find_by_id(params[:id])
  u.destroy
  flash[:notice] = "User created Successfully!"
  redirect_to stories_url
  end


end