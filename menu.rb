require 'pry'
require 'sinatra'
require 'sqlite3'
require 'forecast_io'
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

get "/new_reservation" do
  erb :new_reservation
end

get "/reservation_confirm" do
  x = Reservation.new(params)
  x.insert
  @reservations_id = params[:name]
  erb :new_reservation_confirm
end

get "/add_guest" do
  erb :new_guest
end

get "/add_guest_confirm" do
  x = Guest.new(params)
  x.insert
  erb :new_guest_confirm
end


#------------ADMIN (PRIVATE)-----------
#-------------RESERVATIONS-------------

get "/admin" do
  erb :admin_menu, :layout => :admin
end

get "/admin/add_reservation" do
  erb :add_reservation, :layout => :admin
end

get "/admin/add_reservation_confirm" do
  x = Reservation.new(params)
  x.insert
  erb :add_reservation_confirm, :layout => :admin
end

get "/admin/edit_reservation" do
  erb :edit_reservation, :layout => :admin
end

get "/admin/edit_reservation_form" do
  @form_values = Reservation.where_email_is(params[:email])
  erb :edit_reservation_form, :layout => :admin
end

get "/admin/edit_reservation_confirm" do
  x = Reservation.new(params)
  x.save(params)
  erb :edit_reservation_confirm, :layout => :admin
end

get "/admin/approve_reservation" do
  erb :approve_reservation, :layout => :admin
end

get "/admin/cancel_reservation" do
  erb :cancel_reservation, :layout => :admin
end

get "/admin/cancel_reservation_confirm" do
  Reservation.delete(params["id"])
  erb :cancel_reservation_confirm, :layout => :admin
end

get "/admin/show_reservation" do
  erb :show_reservation, :layout => :admin
end



#-------------GUESTS-------------

get "/admin/add_guest" do
  erb :add_guest, :layout => :admin
end

get "/admin/add_guest_confirm" do
  @x = Guest.new(params)
  @x.insert
  erb :add_guest_confirm, :layout => :admin
end

get "/admin/edit_guest" do
  erb :edit_guest, :layout => :admin
end

get "/admin/edit_guest_form" do
  @form_values = Guest.where_email_is(params[:email])
  erb :edit_guest_form, :layout => :admin
end

get "/admin/edit_guest_confirm" do
  x = Guest.new(params)
  x.save(params)
  erb :edit_guest_confirm, :layout => :admin
end





get "/admin/delete_guest" do
  @results_as_objects = Category.all
  erb :delete_genre, :layout => :admin
end

before "/admin/delete_genre_confirm" do
  @products = Product.where_category_id_is(params[:id].to_i)
  if @products != []
    request.path_info = "/error"
  end
end

get "/admin/delete_guest" do
  @id = params[:id]
  Category.delete(params[:id])
  erb :delete_genre_confirm, :layout => :admin
end

get "/admin/delete_guest_confirm" do
  @id = params[:id]
  Category.delete(params[:id])
  erb :delete_genre_confirm, :layout => :admin
end

get "/admin/show_genre" do
  @results_as_objects = Category.all
  @products = Product.all 
  erb :show_genre, :layout => :admin
end

get "/admin/admin/show_guest" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :show_guest, :layout => :admin
end


not_found do
  erb :not_found
end

get "/error" do
erb :error
end