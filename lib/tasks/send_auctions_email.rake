namespace :email do
  desc "Sends email for upcoming auctions"
  task :send_auctions_email => :environment do
    AuctionMailer.upcoming_auctions.deliver_now
  end
end
