class Admin::CategoriesController < Admin::ApplicationController

	def index
		@categories = Category.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new params[:category]
		if @category.save
			redirect_to :admin_categories, :notice => t("helpers.messages.new", :model_name => Category.model_name.human)
		else
			render :new
		end
	end

	def edit
		@category = Category.find params[:id]
	end

	def update
		@category = Category.find params[:id]
    if @category.update_attributes params[:category]
      redirect_to :admin_categories, :notice => t("helpers.messages.edit", :model_name => Category.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
		@category = Category.find params[:id]
    if @category.destroy
      redirect_to :admin_categories, :notice => t("helpers.messages.destroy", :model_name => Category.model_name.human)
    else
      redirect_to :admin_categories, :alert => t("helpers.messages.error")
    end
	end

	def destroy_multiple
		if params[:category_ids].blank?
			return redirect_to :admin_categories,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Category.model_name.human)
		end
		if Category.destroy(params[:category_ids])
			redirect_to :admin_categories, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:category_ids].size,
																:model_name => Category.model_name.human)
		else
			redirect_to :admin_categories, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:category][:name].blank?
			redirect_to :admin_categories, :alert => t("helpers.messages.search_error")
			return
		else
			@categories = Category.search_name(params[:category][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end
	
end
