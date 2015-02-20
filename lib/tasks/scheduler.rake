namespace :weekly_albums do
  desc "Downloads and inserts BNM albums"
  task :download_bnm => :environment do
    require "./lib/services/bnm_album_downloader_service"

    puts "Downloading Best New Music..."
    BnmAlbumDownloaderService.new(timeout: 5).download
    puts "Finished downloading Best New Music"
  end
end