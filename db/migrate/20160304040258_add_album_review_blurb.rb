class AddAlbumReviewBlurb < ActiveRecord::Migration
  def change
    add_column :albums, :review_blurb, :text
  end
end
