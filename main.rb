require 'pry'
require 'sinatra'
require 'sqlite3'
require 'forecast_io'
require 'google_calendar'
require 'google_calendar_oauth2'
require 'pony'
require 'date'
require 'time'
require 'active_support'
require 'active_support/core_ext/numeric/conversions.rb'

DATABASE = SQLite3::Database.new("database/lodge.db")
DATABASE.results_as_hash = true

require_relative "models/activity.rb"
require_relative "models/guest_activity.rb"
require_relative "models/guest.rb"
require_relative "models/reservation.rb"

require_relative "database/db_setup"

require_relative "controller/admin_activities"
require_relative "controller/admin_calendar"
require_relative "controller/admin_guests"
require_relative "controller/admin_reservation"
require_relative "controller/lodge"
require_relative "controller/index"

require_relative "helpers/helpers"

include LodgeHelper

