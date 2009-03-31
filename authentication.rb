gem 'authlogic'
rake "gems:install", :sudo => true

#Generate controller
generate :session, 'user_session'
file 'app/controllers/user_sessions_controller.rb', <<-END
class UserSessionsController < ApplicationController
    def new
      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        redirect_to account_url
      else
        render :action => :new
      end
    end

    def destroy
      current_user_session.destroy
      redirect_to new_user_session_url
    end
  end
END
file 'app/controllers/application_controller.rb', <<-END
class ApplicationController < ActionController::Base
   helper_method :current_user_session, :current_user

   private
     def current_user_session
       return @current_user_session if defined?(@current_user_session)
       @current_user_session = UserSession.find
     end

     def current_user
       return @current_user if defined?(@current_user)
       @current_user = current_user_session && current_user_session.user
     end
 end
END
generate :model, 'User'