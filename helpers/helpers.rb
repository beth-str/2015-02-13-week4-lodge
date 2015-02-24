#---------------------------------------------------------
# Module: LodgeHelper
# Helper methods for the Lodge project
#
# Public Methods:
# send_message (uses pony gem to send contact form via email)
# populate_join (adds to join table guests_activities)

#---------------------------------------------------------
module LodgeHelper


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
  # Initialization of calendar
  #---------------------------------------------------------
  cal = Google::Calendar.new(:client_id => '212643930905-2g9plm4m8kk8fk2prqs4ojf51p16ke7v.apps.googleusercontent.com', :client_secret => 'iTLIjzSm5cNzVwuH8FCPnhTD', :calendar => 'ld27870tkt6dmn85ksm6kibrrg@group.calendar.google.com', :redirect_url  => 'http://127.0.0.1:4567/', :refresh_token => '1/CadlbSaaYaNX-ftCafL69qHH9jsX_vL95fPNCZtOCQIMEudVrK5jSpoR30zcRFq6')

  #---------------------------------------------------------
  # Public: #populate_join
  # Inserts new join data for guest/activity to the guests_activities table
  # Params: guest_id, activity_id (passed from form)
  #---------------------------------------------------------
  def create_google_calendar_event(params)
    event = cal.create_event do |e|
       e.title = params[:title]
       e.start_time = params[:start_time]
       e.end_time = params[:end_time]
     end
  end


end
