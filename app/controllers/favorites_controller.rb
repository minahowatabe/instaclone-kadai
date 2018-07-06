class FavoritesController < ApplicationController
  def index
    # @favorite = current_user.favorites.find_by(photo_id: @photo.id)
    @favorites_photos = current_user.favorite_photos
  end
  
  def create
    favorite = current_user.favorites.create(photo_id: params[:photo_id])
    redirect_to photos_url, notice: "I added #{favorite.photo.user.name}'s Photo"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to photos_url, notice: "I deleted #{favorite.photo.user.name}'s Photo"
  end

end   
    
