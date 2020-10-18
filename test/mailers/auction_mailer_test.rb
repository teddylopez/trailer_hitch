require 'test_helper'

class AuctionMailerTest < ActionMailer::TestCase
  test "upcoming_auctions" do
    mail = AuctionMailer.upcoming_auctions
    assert_equal "Upcoming auctions", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
