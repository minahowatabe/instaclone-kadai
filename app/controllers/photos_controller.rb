class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:index, :new, :show, :edit, :update, :destroy]

  def top
  end
  
  def index
    @photos = Photo.all
  end
  
  def new
    if params[:back]
      @photo = Photo.new(photo_params)
    else
      @photo = Photo.new
    end
  end
  
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
      if @photo.save
        NoticeMailer.contact_mail(current_user).deliver
        redirect_to photos_path, notice: "I posted new photo!"
      else
        render 'new'
      end
  end
  
  def show
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
  end
  
  def edit
  end
  
  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "I edited a my post"
    else
      render 'edit'  
    end  
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice:"I deleted a my post"
  end
  
  def confirm
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    render :new if @photo.invalid?
  end
  
  private
  def photo_params
    params.require(:photo).permit(:image, :content, :image_cache)
  end
  
  def set_photo
    @photo = Photo.find(params[:id])
  end
  
  def login_check
    unless logged_in?
      redirect_to new_session_path 
    end 
  end
end
