# frozen_string_literal: true

class AddAlbumLargeImage < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :image, :string
  end
end
