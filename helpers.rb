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
      :to => 'bethstranz@gmail.com',
      :subject => params[:email] + " has contacted you - Phone: " + params[:phone], 
      :body => params[:email] + params[:message],
      :via => :smtp,
      :via_options            => {
        :address              => 'smtp.gmail.com', 
        :port                 => '587', 
        :enable_starttls_auto => true,
        :user_name            => 'bethstranz',
        :password             => 'secret',
        :authentication       => :plain,
        :domain               => 'localhost.localdomain'
      }}) 
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
