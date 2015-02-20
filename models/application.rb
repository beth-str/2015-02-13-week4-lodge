require 'sinatra'
require 'rubygems'
require 'google_calendar_oauth2'

client = GoogleCalendar::Client.new "212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com", "iTLIjzSm5cNzVwuH8FCPnhTD", "http://localhost:4567/oauth2callback"

before do
  unless GoogleCalendar.connection.authorization.access_token || request.path_info =~ /^\/oauth2/
    redirect client.redirect_to
  end 
end

get '/oauth2callback' do
  GoogleCalendar.connection.authorization.code = params['code']
  GoogleCalendar.connection.authorization.fetch_access_token!
  redirect '/create_event'
end
# Create your Gemfile with the following.

# source 'http://rubygems.org'

# gem 'sinatra'
# gem 'google_calendar_oauth2'
# Finally, run

# bundle exec ruby application.rb
# In your application directory and go to http://localhost:4567/

# Calendar
# Find a Calendar
#
# calendar = GoogleCalendar::Calendar.find_by_name('Calendar Name')
# List your Calendars
#
# calendars = GoogleCalendar::Calendar.list
# Create a Calendar
#
# calendar = GoogleCalendar::Calendar.create({'summary' => 'New Calendar', 'timeZone' => 'America/Chicago'})
# Event
# Find an event
#
# GoogleCalendar::Event.find_by_name(calendar.id, 'some event name')
# List events for a calendar
#
# events = GoogleCalendar::Event.list(calendar.id)
# Create an event
#
# GoogleCalendar::Event.create({'summary' => 'Some cool event everyone wants to go to.', 'start' => {'dateTime' => '2012-01-29T12:00:00-06:00'}, 'end' => 'dateTime' => '2012-01-29T13:00:00-06:00'})
# Generat