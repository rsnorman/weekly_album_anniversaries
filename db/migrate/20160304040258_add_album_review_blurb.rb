class AddAlbumReviewBlurb < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :review_blurb, :text
  end
end
