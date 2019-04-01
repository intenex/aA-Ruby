class UsersController < ApplicationController
    def index
        @users = User.all

        # controller actions must render OR redirect awesome
        render json: @users, status: 200
    end
    
    def show
        @user = User.find_by(id: params[:id])
        if @user
            render json: @user, status: 200
        else
            redirect_to users_url # that's the url helper method thing fuck yeah get tons of experience here for sure
        end
    end

    private
    def user_params
    end
end
