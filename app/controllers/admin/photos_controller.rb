class Admin::PhotosController < Admin::ApplicationController

	before_filter :fill_album

	def index
		if @album.blank?
			@photos = Photo.page(params[:page]).per(Setting.admin_PhotoPageSize).created_desc
		else
			@photos = Photo.page(params[:page])
										 .per(Setting.admin_PhotoPageSize)
										 .created_desc
										 .where(:album_id => @album.id)
		end
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new params[:photo]
		if @photo.save
			respond_to do |format|
				format.html {
					render :json => [@photo.to_jq_upload].to_json,
								 :content_type => "text/html",
								 :layout => :false
				}
				format.json {
					render :json => [@photo.to_jq_upload].to_json
				}
			end
		else
			render :json => [{ :error => "emptyAlbum" }]
		end
	end

	def destroy
		@photo = Photo.find params[:id]
		@photo.destroy
		respond_to do |format|
			format.html { redirect_to admin_album_photos_url(@album), 
									:notice => t("helpers.messages.destroy", :model_name => Photo.model_name.human) }
			format.json { render :json => true }
		end
	end

	def destroy_multiple
		if params[:photo_ids].blank?
			return redirect_to admin_album_photos_url(@album),
												 :alert => t("helpers.messages.selected_error",
												 :model_name => Photo.model_name.human)
		end
		if Photo.destroy(params[:photo_ids])
			redirect_to admin_album_photos_url(@album), 
									:notice => t("helpers.messages.destroy_multiple", 
									:count => params[:photo_ids].size,
									:model_name => Photo.model_name.human)
		else
			redirect_to admin_album_photos_url(@album), :alert => t("helpers.messages.notices.error")
		end
	end

	def galleries
		@photos = @album.photos.created_desc
	end

	protected
	def fill_album
		@album = Album.find(params[:album_id]) if !params[:album_id].blank?
	end
	
end
