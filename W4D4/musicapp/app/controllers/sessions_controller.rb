class SessionsController < ApplicationController
    before_action :only_if_logged_out, only: [:new, :create]
    before_action :only_if_logged_in, only: [:destroy]

    def new
        render :new
    end

    def create
        login!
    end

    def destroy
        logout!
    end
end
