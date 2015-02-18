#---------------------------------------------------------
# Module: LodgeHelper
# Class Methods for Reservation - moved into module
#
# Public Methods:
# where_title_is
# where_id_is
# where_category_id_is
# where_location_id_is 
#---------------------------------------------------------


module LodgeHelper

  #---------------------------------------------------------
    # Public: .where_email_is
    # Searches the Reservation class for a single email address. 
    #
    # Parameter: String: email
    #
    # Returns: Single Reservation object with matching email (passed as argument)
  #---------------------------------------------------------
  def where_email_is(email)
    x = DATABASE.execute("SELECT * FROM reservations WHERE email = '#{email}'")  
      results = Reservation.new(params) 
    return results
  end

    # Public: .where_id_is
    # Searches the Reservation class for a single id.
    #
    # Parameter: Integer: id
    #
    # Returns: Single Reservation object with matching id (passed as argument)
  #---------------------------------------------------------
  def where_id_is(id)
    x = DATABASE.execute("SELECT * FROM reservations WHERE id = #{id}")
    results = Reservation.new(params)
    return results
  end
end
