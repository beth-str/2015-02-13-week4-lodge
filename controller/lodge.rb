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

post "/reservation_confirm" do
  binding.pry
  params[:name] = check_for_apostrophes(params[:name])
  params[:comments] = check_for_apostrophes(params[:comments])
  x = Reservation.new(params)
  x.insert
  @reservation_id = params[:name]
  redirect "/thank_you"
end

get "/add_guest" do
  erb :"lodge/new_guest"
end

post "/guest_confirm" do
  x = Guest.new(params)
  x.insert
  redirect "/thank_you"
end

get "/thank_you" do
  erb :"lodge/thank_you"
end

get "/contact" do
  erb :"lodge/contact"
end

post "/contact" do
  send_message
  redirect to ('/thank_you')
end

get "/contact_confirm" do
  erb :"lodge/contact_confirm"
end