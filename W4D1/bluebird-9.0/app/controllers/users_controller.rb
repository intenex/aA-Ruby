class UsersController < ApplicationController
    def index
        @users = User.all

        # controller actions must render OR redirect awesome
        render json: @users, status: 200
    end
    
    def show
        @user = User.find_by(id: params[:id]) # .find_by doesn't fail loudly .find does
        if @user
            render json: @user, status: 200
        else
            render plain: "No user found.", status: 418
            # redirect_to users_url # that's the url helper method thing fuck yeah get tons of experience here for sure
        end
    end

    def create
        @user = User.new(user_params)

        if @user.save
            render json: @user, status: 200
        else
            render json: @user.errors.full_messages, status: 418 # awesome can manually tack on the status: 418 and it'll actually send that
        end
    end

    private
    def user_params # get a 
        params.require(:user).permit(:username, :email, :age, :political_affiliation) # must be nested under a user key
        # expects params to have inside of it
        # params = { user: {username: "name", email: "email", age: "age"} } ... and other stuff in params as well
    end
end
