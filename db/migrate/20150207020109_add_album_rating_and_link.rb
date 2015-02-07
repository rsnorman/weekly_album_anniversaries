class AddAlbumRatingAndLink < ActiveRecord::Migration
  def change
    # add_column :albums, :rating, :decimal, :scale => 3, :precision => 1
    add_column :albums, :link, :string
  end
end
