class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(form_params)

        if @user.save_and_subscribe

            session[:user_id] = @user.id

            flash[:success] = "Thanks for signing up!"

            redirect_to root_path
        else
            render "new"
        end
    end

    def form_params
        params.require(:user).permit(:name, :username, :email, 
        :password, :password_confirmation, :subscription_plan, :stripe_token)
    end

end
