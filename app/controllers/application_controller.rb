class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :install_application

  protected
  def exist_user_admin?
  	!User.where(:admin => true).blank?
  end

  def web_installed?
  	Setting.installed
  end

  def install_application
  	if !web_installed? and !exist_user_admin?
  		return redirect_to :install
  	end
  end
end
