class AddClientIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :client_id, :integer
  end
end
