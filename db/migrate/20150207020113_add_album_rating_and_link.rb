class AddAlbumRatingAndLink < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :rating, :decimal, :scale => 1, :precision => 2
    add_column :albums, :link, :string
  end
end
