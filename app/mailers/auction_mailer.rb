class AuctionMailer < ApplicationMailer

  def upcoming_auctions
    url = "https://bringatrailer.com/auctions/"
    unparsed_page = HTTParty.get(url)
    parsed_page ||= Nokogiri::HTML(unparsed_page)

    auction_postings = parsed_page.css("div.auctions-item-container")
    @posts = []
    auction_postings.each do |posting|
      auction_item = posting.css("div.auctions-item").first
      auction_item_details = auction_item.css("div.auctions-item-inner").first
      date_time = Time.at(posting.to_h["data-timestamp"].to_i) - 4.hours
      date_of_close = date_time.strftime("%Y-%m-%d")
      time_of_close = date_time.strftime("%I:%M %p")
      vehicle = auction_item.css("img.auctions-item-image").first.to_h.values[4]
      listing_url = auction_item.css("a.auctions-item-image-link").first.to_h.values[1]
      photo = auction_item.css("img.auctions-item-image").first.to_h.values[2]
      current_bid = posting.to_h["data-price"]

      post = {
        vehicle: vehicle,
        listing_url: listing_url,
        photo: photo,
        current_bid: current_bid,
        date_time: date_time,
        date_of_close: date_of_close,
        time_of_close: time_of_close
      }
      @posts << post
    end

    cutoff_time = Time.now + 12.hours
    max_dollar_amount = 20000
    @posts = @posts.reject{|p| p[:vehicle].nil?}.select{|p| p[:date_time] <= cutoff_time && p[:current_bid].to_i <= max_dollar_amount}

    unless @posts.empty?
      mail to: "tedmlopez@gmail.com", subject: "Auctions Ending In 12 Hours"
    end
  end
end
