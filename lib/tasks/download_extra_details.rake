namespace :weekly_albums do
  desc "Downloads and updates extra details for BNM albums"
  task download_extra_details: :environment do
    require "./lib/services/extra_album_details_downloader_service"

    puts "Downloading extra details for Best New Music..."
    Album.all.each do |album|
      if album.image.nil?
        sleep (1..5).to_a.sample
        puts "Downloading extra details for #{album.artist} - #{album.name}"
        ExtraAlbumDetailsDownloaderService.new(album).download
      end
    end
    puts "Finished downloading extra details for Best New Music"
  end
end
