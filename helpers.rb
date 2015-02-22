#---------------------------------------------------------
# Module: LodgeHelper
# Helper methods for the Lodge project
#
# Public Methods:
# send_message (uses pony gem to send contact form via email)


#---------------------------------------------------------


module LodgeHelper

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
  #---------------------------------------------------------
  def populate_join(params)
    DATABASE.execute("INSERT INTO guests_activities (guest_id, activity_id) VALUES ('#{@guest_id}', '#{@activity_id}')")
    @id = DATABASE.last_insert_row_id 
  end

end




  #---------------------------------------------------------
    # Public: .where_email_is
    # Searches the Reservation class for a single email address. 
    #
    # Parameter: String: email
    #
    # Returns: Single Reservation object with matching email (passed as argument)
  #---------------------------------------------------------
#   def where_email_is(email)
#     x = DATABASE.execute("SELECT * FROM reservations WHERE email = '#{email}'")
#       results = Reservation.new(params)
#     return results
#   end
#
#     # Public: .where_id_is
#     # Searches the Reservation class for a single id.
#     #
#     # Parameter: Integer: id
#     #
#     # Returns: Single Reservation object with matching id (passed as argument)
#   #---------------------------------------------------------
#   def where_id_is(id)
#     x = DATABASE.execute("SELECT * FROM reservations WHERE id = #{id}")
#     results = Reservation.new(params)
#     return results
#   end
# end
