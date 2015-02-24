#--------WEBSITE (PUBLIC)--------

get "/" do
  erb :homepage
end

get "/about" do
  erb :about
end

get "/activities" do
  erb :activities
end

get "/prices" do
  erb :prices
end

get "/guest_reviews" do
  erb :guest_reviews
end

get "/photo_gallery" do
  erb :photo_gallery
end

get "/calendar" do
  erb :calendar
end

get "/new_reservation" do
  erb :new_reservation
end

get "/reservation_confirm" do
  x = Reservation.new(params)
  x.insert
  @reservation_id = params[:name]
  erb :new_reservation_confirm
end

get "/add_guest" do
  erb :new_guest
end

get "/guest_confirm" do
  x = Guest.new(params)
  x.insert
  erb :new_guest_confirm
end

get "/contact" do
  erb :contact
end

post "/contact" do
  send_message
  redirect to ('/contact_confirm')
end

get "/contact_confirm" do
  erb :contact_confirm
end

