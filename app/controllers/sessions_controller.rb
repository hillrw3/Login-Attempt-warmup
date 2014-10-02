class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    @user.update(last_login_attempt: Time.now)
    if @user.active == false
      flash[:notice] = "You've reached your maximum number of attempts. Please wait 1 minute."
      @user.wait_1_minute
      render :new
    else
      if @user && @user.password == params[:user][:password]
        session[:user_id] = @user.id
        @user.erase_logins
        p "You're Super smart"
        redirect_to root_path
      elsif @user
        if @user.logins < 4
          @user.login_attempt_counter
          @user.check_user_logins
          flash[:notice] = "#{@user.logins} out of 4 login attempts"
          render :new
        end
      end
    end
  end
end
