class AddUuidFields < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :uuid, :string
    add_column :genres, :uuid, :string
  end
end
