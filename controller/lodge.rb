#--------WEBSITE (PUBLIC)--------

get "/about" do
  erb :"lodge/about"
end

get "/activities" do
  erb :"lodge/activities"
end

get "/prices" do
  erb :"lodge/prices"
end

get "/guest_reviews" do
  erb :"lodge/guest_reviews"
end

get "/photo_gallery" do
  erb :"lodge/photo_gallery"
end

get "/calendar" do
  erb :"lodge/calendar"
end

get "/new_reservation" do
  erb :"lodge/new_reservation"
end

get "/reservation_confirm" do
  x = Reservation.new(params)
  x.insert
  @reservation_id = params[:name]
  erb :"lodge/new_reservation_confirm"
end

get "/add_guest" do
  erb :"lodge/new_guest"
end

get "/guest_confirm" do
  x = Guest.new(params)
  x.insert
  erb :"lodge/new_guest_confirm"
end

get "/contact" do
  erb :"lodge/contact"
end

post "/contact" do
  send_message
  redirect to ('/contact_confirm')
end

get "/contact_confirm" do
  erb :"lodge/contact_confirm"
end