#---------------------------------------------------------
# Module: LodgeHelper
# Helper methods for the Lodge project
#
# Public Methods:
# send_message (uses pony gem to send contact form via email)
# populate_join (adds to join table guests_activities)
# date_parse (converts date from google calendar to display)
# reverse_date_parse (coverts date from string to google calendar format)
#---------------------------------------------------------
module LodgeHelper

  #---------------------------------------------------------
    # Public: .check_for_apostrophes
    # Searches for ' in string and changes to blank space (to avoid SQL error) 
    #
    # Parameter: String: (from params)
    #
    # Returns: String (without ')
    #
    # State Changes: Deletes ' from the string
  #---------------------------------------------------------
  def check_for_apostrophes(string)
    # if params includes ' replace with blank space
   string.gsub(/(')/, ' ')
   return self
  end


  #---------------------------------------------------------
  # Public: #send_message
  # Facilitates sending form data as email
  # Params: email, phone, message (passed from contact form)
  #---------------------------------------------------------
  def send_message
    Pony.mail({
      :from => params[:email], 
      :to => 'info_the_lodge@gmail.com',
      :subject => params[:email] + " has contacted you - Phone: " + params[:phone], 
      :body => params[:email] + params[:message],
      :via => :smtp,
      :via_options            => {
        :address              => 'smtp.gmail.com', 
        :port                 => '587', 
        :enable_starttls_auto => true,
        :user_name            => 'info_the_lodge',
        :password             => 'secret',
        :authentication       => :plain,
        :domain               => 'localhost.localdomain'
      }}) 
  end

  #---------------------------------------------------------
  # Public: date_parse
  # Converts date from google calendar to display (as a string)
  # Params: (start_time or end_time - from event object)
  #---------------------------------------------------------
  def date_parse(time_object)       # 2015-03-26 11:00:00 -0600
    @time_s = time_object.to_s
    @time_s = Date.parse(@time)
    @time_s = @time.strftime("%A, %d %b %Y")
    return @time_s                  # Thursday, Mar 26 2015
  end

  
  #---------------------------------------------------------
  # Public: reverse_date_parse
  # Converts date string to a datetime object
  # Params: (start_time or end_time - from event object)
  #---------------------------------------------------------
  def reverse_date_parse(time_string)       # "03/25/2015"  => 2015-03-26 11:00:00 -0600
    array = []
    @time_o = time_string.to_s.split('/')   # ["03", "25", "2015"]
    rev = @time_o.reverse                   # ["2015", "25", "03"]
    rev.push(rev[1])                        # ["2015", "25", "03", "25"]
    rev.slice!(1)                           # ["2015", "03", "25"]
    x = rev.join("-")
    array << x
    array.push("11:00:00")
    array.push("-0600")
    @time_o = array.join(" ")               # "2015-03-25 11:00:00 -0600"
  end


  #---------------------------------------------------------
  # Initialization of google calendar
  #---------------------------------------------------------
  cal = Google::Calendar.new(:client_id => '212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com', 
		:client_secret => 'iTLIjzSm5cNzVwuH8FCPnhTD', 
		:calendar => 'ld27870tkt6dmn85ksm6kibrrg@group.calendar.google.com', 
		:redirect_url  => 'http://127.0.0.1:4567/', 
		:refresh_token => '1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6')

  #---------------------------------------------------------
  # Public: #create_google_calendar_event
  # Creates a new calendar event
  #---------------------------------------------------------
  def create_google_calendar_event(params)
    event = cal.create_event do |e|
       e.title = params[:title]
       e.start_time = params[:start_time]
       e.end_time = params[:end_time]
     end
  end


end
