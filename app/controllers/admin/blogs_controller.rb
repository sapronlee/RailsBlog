class Admin::BlogsController < Admin::ApplicationController

	def index
		@blogs = Blog.page(params[:page]).per(Setting.admin_PageSize).includes(:category)
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new params[:blog]
		if @blog.save
			redirect_to :admin_blogs, :notice => t("helpers.messages.new", :model_name => Blog.model_name.human)
		else
			render :new
		end
	end

	def edit
		@blog = Blog.find params[:id]
	end

	def update
		@blog = Blog.find params[:id]
    if @blog.update_attributes params[:blog]
      redirect_to :admin_blogs, :notice => t("helpers.messages.edit", :model_name => Blog.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
		@blog = Blog.find params[:id]
    if @blog.destroy
      redirect_to :admin_blogs, :notice => t("helpers.messages.destroy", :model_name => Blog.model_name.human)
    else
      redirect_to :admin_blogs, :alert => t("helpers.messages.error")
    end
	end

	def destroy_multiple
		if params[:blog_ids].blank?
			return redirect_to :admin_blogs,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Blog.model_name.human)
		end
		if Blog.destroy(params[:blog_ids])
			redirect_to :admin_blogs, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:blog_ids].size,
																:model_name => Blog.model_name.human)
		else
			redirect_to :admin_blogs, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:blog][:name].blank?
			redirect_to :admin_blogs, :alert => t("helpers.messages.search_error")
			return
		else
			@blogs = Blog.search_name(params[:blog][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end
	
end
