class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def top
  end
  
  def index
    @photos = Photo.all
  end
  
  def new
    if params[:back]
      @photo = Photo.new
    else
      @photo = Photo.new
    end
  end
  
  def create
    @photo = Photo.create(photo_params)
    @photo.user_id = current_user.id
      if @photo.save
        NoticeMailer.contact_mail(current_user).deliver
        redirect_to photos_path, notice: "ブログを作成しました！"
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
      redirect_to photos_path, notice: "ブログを編集しました！"
    else
      render 'edit'  
    end  
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice:"ブログを削除しました！"
  end
  
  def confirm
    @photo = Photo.new(photo_params)
    render :new if @photo.invalid?
  end
  
  private
  def photo_params
    params.require(:photo).permit(:image, :content)
  end
  
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
