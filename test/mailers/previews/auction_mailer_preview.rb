# Preview all emails at http://localhost:3000/rails/mailers/auction_mailer
class AuctionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/auction_mailer/upcoming_auctions
  def upcoming_auctions
    AuctionMailer.upcoming_auctions
  end

end
