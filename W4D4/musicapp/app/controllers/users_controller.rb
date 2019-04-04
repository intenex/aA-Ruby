class UsersController < ApplicationController
    def new
        render :new # can be symbol or string, a partial rendering in a view must be a string not a symbol yep awesome just play around with it anyway
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!
            render user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
