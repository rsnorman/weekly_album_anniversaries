class AddUuidFields < ActiveRecord::Migration
  def change
    add_column :albums, :uuid, :string
    add_column :genres, :uuid, :string
  end
end
