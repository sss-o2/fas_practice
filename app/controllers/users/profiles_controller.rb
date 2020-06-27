class Users::ProfilesController < ApplicationController
  def contact
    @title = params[:title]
    @message=params[:message]
    InquiryMailer.test_mail(@title,@message).deliver
    redirect_to action: :show,notice: 'メール送信しました'
  end

  def show
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
    # bc_numはベストコメントもらった数
    @bc_num=Comment.where(best_flag: true).where(user_id: @user.id).count
    @fa_num=Favorite.where(user_id: @user.id).count

    @user_posts=Post.where(user_id: @user.id)
    #binding.pry
  end

  def edit
    @profile = Profile.find(params[:id])
    @user=User.find(@profile.user_id)
    @bc_num=Comment.where(best_flag: true).where(user_id: @user.id).count
    # binding.pry
  end

  def update
    profile = Profile.find(params[:id])
    if profile.update(profile_params)
      redirect_to action: :show,notice: '編集しました'
    else
      render :show
    end
  end

  def profile_params
    params.require(:profile).permit(:introduce,:hp_url,:address,:icon_image) 
  end

end