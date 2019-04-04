class SessionsController < ApplicationController
    before_action :only_if_logged_out, only: [:new, :create]
    before_action :only_if_logged_in, only: [:destroy]

    def new
        @user = User.new # a dummy user so you can reuse the users form for the login page lol
        render :new
    end

    def create
        login!
    end

    def destroy
        logout!
    end
end
