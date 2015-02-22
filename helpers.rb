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
  # Public: #populate_join
  # Inserts new join data for guest/activity to the guests_activities table
  # Params: guest_id, activity_id (passed from form)
  #---------------------------------------------------------
  def populate_join(params)
    DATABASE.execute("INSERT INTO guests_activities (guest_id, activity_id) VALUES ('#{params["guest_id"]}', '#{params["activity_id"]}')")
    @id = DATABASE.last_insert_row_id 
  end
  
end
