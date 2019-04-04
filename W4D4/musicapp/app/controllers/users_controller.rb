class UsersController < ApplicationController
    before_action :only_if_logged_out, only: [:new, :create]
    before_action :only_if_logged_in, only: [:edit, :update]

    def new
        @user = User.new # dummy user for the form partial to have something to operate on
        render :new # can be symbol or string, a partial rendering in a view must be a string not a symbol yep awesome just play around with it anyway
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def edit
        @user = User.find_by(id: params[:id])
        if @user == current_user
            render :edit
        else
            flash[:errors] = ["You are not that user."]
            redirect_to user_url(current_user)
        end
    end

    def update
        @user = User.find_by(id: params[:id]) # oh interesting update goes to a specific wildcard
        if @user == current_user
            if @user.update(user_params) # this doesn't need an id of course because you already found the user and the id isn't being updated ofc, just everything else love it so can use the same users_params as below love it
                flash[:errors] = ["Successfully updated."]
                redirect_to user_url(current_user) # can be current_user or @user, identical
            else
                flash[:errors] = @user.errors.full_messages
                redirect_to edit_user_url(current_user)
            end
        else
            flash[:errors] = ["You are not this user."]
            redirect_to user_url(current_user)
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
