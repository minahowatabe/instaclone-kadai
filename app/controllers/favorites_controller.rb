class FavoritesController < ApplicationController
  def index
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
  end
  
  def create
    favorite = current_user.favorites.create(photo_id: params[:photo_id])
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんの写真をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんの写真をお気に入り解除しました"
  end
end   
    
