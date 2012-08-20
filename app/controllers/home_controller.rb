class HomeController < ApplicationController

	skip_before_filter :install_application, :only => [:install, :installing]
	layout "admin/application", :only => [:install]

	def index
		
	end

	def install
		
	end

	def installing
		@user = User.new params[:user]
		@user.admin = true
		if @user.save
			if !params[:setting].blank?
				Setting.app_name = params[:setting][:app_name]
				Setting.app_keywords = params[:setting][:app_keywords]
				Setting.app_description = params[:setting][:app_description]
				Setting.installed = true
			end
			redirect_to :admin_root, :notice => t("helpers.messages.installed")
		end
	end

end
