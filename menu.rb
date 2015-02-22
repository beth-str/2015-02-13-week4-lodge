require 'pry'
require 'sinatra'
require 'sqlite3'
require 'coffee-script'
require 'v8'
require 'forecast_io'
require 'google_calendar'
require 'google_calendar_oauth2'
require 'pony'
require 'date'
require 'time'
require 'active_support'
require 'active_support/core_ext/numeric/conversions.rb'
DATABASE = SQLite3::Database.new("database/lodge.db")
require_relative "helpers.rb"
require_relative "models/db_setup.rb"
require_relative "models/activity.rb"
require_relative "models/reservation.rb"
require_relative "models/guest.rb"
require_relative "models/guest_activity.rb"

include LodgeHelper

DATABASE.results_as_hash = true


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

get '/admin/reservation_status' do
  erb :ad_reservation_status, :layout => :layout_back
end

get '/admin/edit_reservation_status' do
  @form_values = Reservation.where_email_is(params[:email])
  erb :ad_reservation_status_edit, :layout => :layout_back
end

get '/admin/delete_reservation' do
  erb :ad_reservation_delete, :layout => :layout_back
end

get '/admin/cancel_reservation' do
  erb :ad_reservation_status, :layout => :layout_back
end

get '/admin/show_reservation' do
  @reservations = Reservation.all
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

get "/admin/show_guest" do
  @results_as_objects = Reservation.all
  @guests = Guest.all 
  erb :ad_guest_show, :layout => :layout_back
end

get '/admin/show_activities' do
  @reservations = Reservation.all
  @guest_activity = GuestActivity.show_guests_activities
  @activities = Activity.all
  erb :ad_activity_show, :layout => :layout_back
end

#------------ACTIVITIES------------

get '/admin/activity_add' do
  erb :ad_activity_add, :layout => :layout_back
end

get '/admin/activity_add_confirm' do
  x = Activity.new(params)
  x.insert
  erb :ad_activity_add_confirm, :layout => :layout_back
end

get '/admin/activity_edit' do
  @activities = Activity.all
  erb :ad_activity_edit, :layout => :layout_back
end

get '/admin/activity_edit_form' do
  @form_values = Activity.where_id_is(params[:id])
  erb :ad_activity_edit_form, :layout => :layout_back
end

get '/admin/activity_edit_confirm' do
  x = Activity.new(params)
  x.save(params)
  erb :ad_activity_edit_confirm, :layout => :layout_back
end

get '/admin/activity_list' do
  @activities = Activity.all
  erb :ad_activity_list, :layout => :layout_back
end

get '/admin/activity_assign' do
  erb :ad_activity_assign, :layout => :layout_back
end

get '/admin/activity_assign_confirm' do
  populate_join(params)
  erb :ad_activity_assign_confirm, :layout => :layout_back
end


#-------------CALENDAR-------------

get '/admin/calendar_add' do
  @reservations = Reservation.all
  erb :ad_calendar_add, :layout => :layout_back
end

get '/admin/calendar_add_form' do
  @event = Reservation.where_id_is(params[:id])
  erb :ad_calendar_add_form, :layout => :layout_back
end

before '/admin/calendar_add_confirm' do



end

get '/admin/calendar_add_confirm' do
  create_google_calendar_event(params)
  erb :ad_calendar_confirm, :layout => :layout_back
end

get '/admin/calendar_edit' do
  @reservations = Reservation.all
  erb :ad_calendar_edit, :layout => :layout_back
end

get '/admin/calendar_delete' do
  erb :ad_calendar_delete, :layout => :layout_back
end

get '/admin/calendar_show' do
  cal = Google::Calendar.new(:client_id => '212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com', :client_secret => 'iTLIjzSm5cNzVwuH8FCPnhTD', :calendar => 'ld27870tkt6dmn85ksm6kibrrg@group.calendar.google.com', :redirect_url  => 'http://127.0.0.1:4567/', :refresh_token => '1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6')
  @events = cal.events
  erb :ad_calendar_show, :layout => :layout_back
end


#--------------UTILITY-------------

not_found do
  erb :not_found
end

get "/error" do
  erb :error
end