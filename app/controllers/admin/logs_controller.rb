class Admin::LogsController < Admin::ApplicationController

	def index
		@logs = Log.created_desc.page(params[:page]).per(Setting.admin_PageSize)
	end

	def categories
		@logs = Log.with_model(:Category).created_desc.page(params[:page]).per(Setting.admin_PageSize)
		render :index
	end

	def blogs
		@logs = Log.with_model(:Blog).created_desc.page(params[:page]).per(Setting.admin_PageSize)
		render :index
	end

	def albums
		@logs = Log.with_model(:Album).created_desc.page(params[:page]).per(Setting.admin_PageSize)
		render :index
	end

	def photos
		@logs = Log.with_model(:Photo).created_desc.page(params[:page]).per(Setting.admin_PageSize)
		render :index
	end

end
