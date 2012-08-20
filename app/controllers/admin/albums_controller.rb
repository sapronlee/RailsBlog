class Admin::AlbumsController < Admin::ApplicationController
	
	def index
		@albums = Album.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def new
		@album = Album.new
		@remote = params[:remote].blank? ? true : false
	end

	def create
		@album = Album.new params[:album]
		if @album.save
			respond_to do |format|
				format.html { redirect_to admin_album_photos_url(@album), 
									:notice => t("helpers.messages.new", :model_name => Album.model_name.human) }
				format.js
			end
		end
	end

	def edit
		@album = Album.find params[:id]
	end

	def update
		@album = Album.find params[:id]
    if @album.update_attributes params[:album]
      flash[:notice] = t("helpers.messages.edit", :model_name => Album.model_name.human)
    end
	end

	def delete
		@album = Album.find params[:id]
	end

	def destroy
		@album = Album.find params[:id]
		if !params[:delete_all].blank?
			@album.photos.destroy
		end
		if @album.destroy
			redirect_to :admin_albums, :notice => t("helpers.messages.destroy", :model_name => Album.model_name.human)
		else
			redirect_to :admin_albums, :alert => t("helpers.messages.error")
		end
	end
	
end
