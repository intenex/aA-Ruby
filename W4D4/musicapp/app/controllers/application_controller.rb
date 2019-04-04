class ApplicationController < ActionController::Base
    def login!
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user == false
            flash[:errors] = ["Invalid password."]
            redirect_to new_session_url
        elsif @user.nil?
            flash[:errors] = ["Email not found."]
            redirect_to new_session_url
        else
            session[:session_token] = @user.session_token
            redirect_to user_url(@user)
        end
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!(current_user)
    end

    def logout!
        @current_user.reset_session_token!
        @current_user = nil
        session[:session_token] = nil
    end

    def only_if_logged_out
        redirect_to users_url if logged_in?
    end

    def only_if_logged_in
        redirect_to new_session_url unless logged_in?
    end
end
