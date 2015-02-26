#---------------------------------------------------------
# Class: Reservation
# Reservations and all the things they can do
#
# Attributes:
# @name           - String: the group name (last name)
# @email          - String: email
# @address        - String: address
# @city           - String: city
# @state          - String: state
# @phone          - String: phone
# @no_adults      - Integer: the number of adults in the group
# @no_children    - Integer: the number of children in the group (12 and under)
# @arrival_date   - String: the arrival date
# @departure_date - String: the departure date
# @comments       - String: add'l information
# @status         - Text: reservation status: requested, approved, cancelled, closed
#
# Public Methods:
# #insert
# #save
# .where_id_is 
# .where_name_is  
# .where_email_is
# .all  
#---------------------------------------------------------
class Reservation
  
  attr_reader :id
  attr_accessor :name, :email, :address, :city, :state, :phone, :no_adults, :no_children, :arrival_date, :departure_date, :comments, :status

  def initialize(options)
    @id             = options["id"]
    @name           = options["name"]
    @email          = options["email"]
    @address        = options["address"]
    @city           = options["city"]
    @state          = options["state"]
    @phone          = options["phone"]
    @no_adults      = options["no_adults"]
    @no_children    = options["no_children"]
    @arrival_date   = options["arrival_date"]
    @departure_date = options["departure_date"]
    @comments       = options["comments"]
    @status         = options["status"]
  end

  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #
  # Returns: The @id (Integer) of the newly created Activity object 
  #---------------------------------------------------------
  def insert
    sql_query = "INSERT INTO reservations (name, email, address, city, state, phone, no_adults, no_children, arrival_date, departure_date, comments, status) VALUES ('#{@name}', '#{@email}', '#{@address}', '#{@city}', '#{@state}', '#{@phone}', '#{@no_adults}', '#{@no_children}', '#{@arrival_date}', '#{@departure_date}', '#{comments}', '#{@status}')"

    DATABASE.execute(sql_query)
    @id = DATABASE.last_insert_row_id
  end

  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Reservation object, this saves the changes to the database
  #
  # Returns: True 
  #---------------------------------------------------------
  def save(params)
    sql_query = "UPDATE reservations SET 
    name = '#{params[:name]}', 
    email = '#{params[:email]}', 
    address = '#{params[:address]}', 
    city = '#{params[:city]}', 
    state = '#{params[:state]}', 
    phone = '#{params[:phone]}', 
    no_adults = #{params[:no_adults]}, 
    no_children = #{params[:no_children]}, 
    arrival_date = '#{params[:arrival_date]}', 
    departure_date = '#{params[:departure_date]}', 
    comments = '#{params[:comments]}', 
    status = '#{params[:status]}' WHERE id = #{params[:id]}"
    
    DATABASE.execute(sql_query)
    return true
end


  #---------------------------------------------------------
    # Public: .where_email_is
    # Searches the Reservation class for a single email address. 
    #
    # Parameter: String: email
    #
    # Returns: Single Reservation object with matching email (passed as argument)
  #---------------------------------------------------------
  def self.where_email_is(email)
    sql_query = "SELECT * FROM reservations WHERE email = '#{email}'"

    results = DATABASE.execute(sql_query)
      results_as_object = Reservation.new(results[0]) 
    return results_as_object
  end

  #---------------------------------------------------------
    # Public: .where_id_is
    # Searches the Reservation class for a single id.
    #
    # Parameter: Integer: id
    #
    # Returns: Single Reservation object with matching id (passed as argument)
  #---------------------------------------------------------
  def self.where_id_is(id)
    sql_query = "SELECT * FROM reservations WHERE id = '#{id}'"

    x = DATABASE.execute(sql_query)
    results = Reservation.new(x[0])
    return results
  end

  #---------------------------------------------------------
  # Public: .all
  # Displays all products
  #
  # Returns: An Array of reservation objects  
  #---------------------------------------------------------
  def self.all
    sql_query = "SELECT * FROM reservations"

    results = DATABASE.execute(sql_query)
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Reservation.new(r)
      end
      results_as_objects = @results_as_objects
      return results_as_objects
  end

  #---------------------------------------------------------
    # Public: .delete
    # Deletes a single reservation 
    #
    # Parameter: String: email
    #
    # Returns: Empty array
    #
    # State Changes: Deletes reservation from the database
  #---------------------------------------------------------
  def self.delete(email)
    sql_query = "DELETE FROM reservations WHERE email = '#{email}'"
    
      DATABASE.execute(sql_query)
  end
  
end