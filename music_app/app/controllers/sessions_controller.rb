class SessionsController < ApplicationController
    def new
        render :new
    end

    def destroy
        logout_user!
        session[:session_token] = nil
        redirect_to new_session_url
    end

    def create
        user = User.find_by_credentials(
            params[:user][:email]
            params[:user][:password]
        )

        if user.nil?
            user = User.new
            flash.now[:errors] = ["Incorrect email and/or password"]
            render :new
        else
            login_user!(user)
            redirect_to user_url
        end
    end

end
