class ApplicationController < ActionController::Base

    #make current_user available to views

    helper_method :current_user, :is_logged_in?


    #run before every action
    before_action :current_user

    def current_user
        if is_logged_in?
            @current_user = User.find(session[:user_id])
        else
            @current_user = nil
        end
        @current_user
    end

    def is_logged_in?
        session[:user_id].present?
    end
end
