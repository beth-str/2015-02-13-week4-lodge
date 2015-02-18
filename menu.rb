require 'pry'
require 'sinatra'
require 'sqlite3'
require 'coffee-script'
require 'v8'
require 'forecast_io'
require 'rubygems'
require 'google_calendar'
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


#------------ADMIN (PRIVATE)-----------
#-------------RESERVATIONS-------------

get '/admin' do
  erb :ad_login, :layout => :layout_back
end

get '/admin/home' do
  erb :ad_admin_menu, :layout => :layout_back
end

get '/admin/add_reservation' do
  erb :ad_reservation_add, :layout => :layout_back
end

get '/admin/add_reservation_confirm' do
  x = Reservation.new(params)
  x.insert
  erb :ad_reservation_add_confirm, :layout => :layout_back
end

get '/admin/edit_reservation' do
  @reservations = Reservation.all
  erb :ad_reservation_edit, :layout => :layout_back
end

get '/admin/edit_reservation_form' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :ad_reservation_edit_form, :layout => :layout_back
end

get '/admin/edit_reservation_confirm' do
  x = Reservation.new(params)
  x.save(params)
  erb :ad_reservation_edit_confirm, :layout => :layout_back
end

get '/admin/approve_reservation' do
  erb :ad_reservation_approve, :layout => :layout_back
end

get '/admin/delete_reservation' do
  erb :ad_reservation_delete, :layout => :layout_back
end

get '/admin/delete_reservation_confirm' do
  Reservation.delete(params["email"])
  erb :ad_reservation_delete_confirm, :layout => :layout_back
end

get '/admin/cancel_reservation' do
  erb :ad_reservation_cancel, :layout => :layout_back
end

get '/admin/cancel_reservation_confirm' do
  x = Reservation.new(params)
  x.save(params)
  erb :ad_reservation_cancel_confirm, :layout => :layout_back
end

get '/admin/show_reservation' do
  erb :ad_reservation_show, :layout => :layout_back
end


#-------------GUESTS-------------

get '/admin/add_guest' do
  erb :ad_guest_add, :layout => :layout_back
end

get '/admin/add_guest_confirm' do
  @x = Guest.new(params)
  @x.insert
  erb :ad_guest_add_confirm, :layout => :layout_back
end

get '/admin/edit_guest' do
  @guests = Guest.all
  erb :ad_guest_edit, :layout => :layout_back
end

get '/admin/edit_guest_form' do
  @form_values = Guest.where_id_is(params[:id])
  erb :ad_guest_edit_form, :layout => :layout_back
end

get '/admin/edit_guest_confirm' do
  x = Guest.new(params)
  x.save(params)
  @x = x
  erb :ad_guest_edit_confirm, :layout => :layout_back
end

get '/admin/delete_guest' do
  @results_as_objects = Guest.all
  erb :ad_guest_delete, :layout => :layout_back
end

before "/admin/delete_guest_confirm" do
  @guests = Guest.where_reservation_id_is(params[:id].to_i)
  if @guests != []
    request.path_info = "/error"
  end
end

get "/admin/delete_guest_confirm" do
  @id = params[:id]
  Guest.delete(params[:id])
  erb :ad_guest_delete_confirm, :layout => :layout_back
end

get "/admin/show_guest" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :delete_guest_show, :layout => :layout_back
end


not_found do
  erb :not_found
end

get "/error" do
erb :error
end
