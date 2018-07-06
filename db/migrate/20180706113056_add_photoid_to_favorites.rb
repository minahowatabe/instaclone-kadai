class AddPhotoidToFavorites < ActiveRecord::Migration[5.1]
  def change
     add_column :favorites, :photo_id, :integer
  end
end
