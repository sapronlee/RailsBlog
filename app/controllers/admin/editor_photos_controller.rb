class Admin::EditorPhotosController < Admin::ApplicationController

	def index
		album_id = params[:album_id]
		@photos = Photo.page(params[:page]).per(Setting.admin_PhotoPageSize).created_desc
									 .where(:album_id => album_id)
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

end
