class CreateArtists < ActiveRecord::Migration[4.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :uuid
      t.string :twitter_screen_name
      t.timestamps null: false
    end
  end
end
