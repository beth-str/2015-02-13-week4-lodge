require 'google_calendar_oauth2'
#
# client = GoogleCalendar::Client.new "212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com", "iTLIjzSm5cNzVwuH8FCPnhTD", "http://localhost:4567/oauth2callback"

# refresh token: 1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6

# wrapper class

class Calendar


  # Find a Calendar (establishes connection with the calendar)
  def initialize
    calendar = GoogleCalendar::Calendar.find_by_name('The Lodge')
  end

# Event
# Find an event
#
  def find_event
    GoogleCalendar::Event.find_by_name(calendar.id, 'some event name')
  end
# List events for a calendar
#
# events = GoogleCalendar::Event.list(calendar.id)


# Create an event
#
# GoogleCalendar::Event.create({'summary' => 'Some cool event everyone wants to go to.', 'start' => {'dateTime' => '2012-01-29T12:00:00-06:00'}, 'end' => 'dateTime' => '2012-01-29T13:00:00-06:00'})
# Generat