 class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        user.try(:authenticate, params[:password])
        session[:user_id] = user.id
    #     @user = session[:user_id].to_i
    #     redirect_to home_path, notice: "Logged in!"
    # end
        if logged_in? and current_user.role? :employee
          redirect_to employee_profile_path, notice: "Logged in!"
        elsif logged_in? and current_user.role? :manager
          redirect_to dashboard_path, notice: "Logged in!"
        elsif logged_in? and current_user.role? :admin
          redirect_to admin_home_path, notice: "Logged in!"
        else
          redirect_to home_path, notice: "Logged in!"
        end
      else
        flash.now.alert = "Email or password is invalid"
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end
end

