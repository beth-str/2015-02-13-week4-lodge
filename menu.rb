require 'pry'
require 'sinatra'
require 'sqlite3'
DATABASE = SQLite3::Database.new("database/lodge.db")
require_relative "module.rb"
require_relative "models/db_setup.rb"
require_relative "models/activity.rb"
require_relative "models/reservation.rb"
require_relative "models/guest.rb"


DATABASE.results_as_hash = true

#--------WEBSITE (PUBLIC)--------

get "/" do
  erb :homepage
end

get "/about" do
  erb :hosts
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

get "/reservations" do
  erb :reservations
end


#------------ADMIN (PRIVATE)-----------
#-------------RESERVATIONS-------------

get "/admin/" do
  erb :"admin/admin_menu", :layout => :admin
end

get "/admin/add_reservation" do
  erb :"admin/add_reservation", :layout => :admin
end

get "/admin/add_reservation_confirm" do
  x = Reservation.new(params)
  x.insert
  erb :"admin/add_reservation_confirm", :layout => :admin
end

get "/admin/edit_reservation" do
  erb :"admin/edit_reservation", :layout => :admin
end

get "/admin/edit_reservation_form" do
  @form_values = Reservation.where_email_is(params[:email])
  erb :"admin/edit_reservation_form", :layout => :admin
end

get "/admin/edit_reservation_confirm" do
  x = Reservation.new(params)
  x.save(params)
  erb :"admin/edit_reservation_confirm", :layout => :admin
end

get "/admin/delete_reservation" do
  erb :"admin/delete_reservation", :layout => :admin
end

get "/admin/delete_reservation_confirm" do
  Reservation.delete(params["id"])
  erb :"admin/delete_product_confirm", :layout => :admin
end

# need to be able to see all requests then approve them / insert to db as reservation 
get "/admin/show_requests" do
  erb :"admin/show_requests", :layout => :admin
end

get "/admin/show_guests" do
  erb :"admin/show_guests", :layout => :admin
end

get "/admin/show_reservations" do
  erb :"admin/show_reservations", :layout => :admin
end

#-------------GUESTS-------------

get "/add_genre" do
  erb :add_genre, :layout => :admin
end

get "/add_genre_confirm" do
  @x = Category.new(params)
  @x.insert
  erb :add_genre_confirm, :layout => :admin
end

get "/delete_genre" do
  @results_as_objects = Category.all
  erb :delete_genre, :layout => :admin
end

before "/delete_genre_confirm" do
  @products = Product.where_category_id_is(params[:id].to_i)
  if @products != []
    request.path_info = "/error"
  end
end

get "/delete_genre_confirm" do
  @id = params[:id]
  Category.delete(params[:id])
  erb :delete_genre_confirm, :layout => :admin
end

get "/show_genre" do
  @results_as_objects = Category.all
  @products = Product.all 
  erb :show_genre, :layout => :admin
end



get "/add_location" do
  erb :add_location, :layout => :admin
end

get "/add_location_confirm" do
  @x = Location.new(params)
  @x.insert
  erb :add_location_confirm, :layout => :admin
end

get "/delete_location" do
  @results_as_objects = Location.all
  erb :delete_location, :layout => :admin
end

before "/delete_location_confirm" do
  @products = Product.where_location_id_is(params[:id].to_i)
  if @products != []
    request.path_info = "/error"
  end
end

get "/delete_location_confirm" do
  Location.delete(params[:id])
  erb :delete_location_confirm
end

get "/admin/show_guests" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :show_guests
end

not_found do
  erb :not_found
end

get "/error" do
erb :error
end
