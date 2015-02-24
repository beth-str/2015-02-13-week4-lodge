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

require_relative "controller/admin_activities"
require_relative "controller/admin_guests"
require_relative "controller/admin_reservation"
require_relative "controller/calendar"
require_relative "controller/public"


include LodgeHelper

DATABASE.results_as_hash = true



#--------------UTILITY-------------

not_found do
  erb :not_found
end

get "/error" do
  erb :error
end