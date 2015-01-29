class AddUuidFields < ActiveRecord::Migration
  def change
    add_column :people,  :uuid, :string
    add_column :clients, :uuid, :string
  end
end
