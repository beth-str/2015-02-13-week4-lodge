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
# @phone          - Integer: phone
# @no_adults      - Integer: the number of adults in the group
# @no_children    - Integer: the number of children in the group
# @arrival_date   - String: the arrival date
# @departure_date - String: the departure date
# @group_activity - String: the group's activity
# @comments       - String: add'l information
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
  attr_accessor :name, :email, :address, :city, :state, :phone, :no_adults, :no_children, :arrrival_date, :departure_date, :group_activity, :comments

  def initialize(options)
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
    @group_activity = options["group_activity"]
    @comments       = options["comments"]
  end

  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO reservations (name, email, address, city, state, phone, no_adults, no_children, arrival_date, departure_date, group_activity, comments) VALUES ('#{@name}', '#{@email}', '#{@email}', '#{@email}', '#{@email}', '#{@email}', '#{@no_adults}', '#{@no_children}', '#{@arrival_date}', '#{@departure_date}', '#{@group_activity}', '#{comments}')")
    @id = DATABASE.last_insert_row_id
  end

  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Reservation object, this saves the changes to the database
  #---------------------------------------------------------
  def save(params)
    DATABASE.execute("UPDATE reservations SET name ='#{params[:name]}', email = '#{params[:email]}', address = '#{params[:address]}', city = '#{params[:city]}', state = '#{params[:state]}', phone = #{params[:phone]}, no_adults = #{params[:no_adults]}, no_children = #{params[:no_children]}, arrival_date = '#{params[:arrival_date]}', departure_date = '#{params[:departure_date]}', group_activity = '#{params[:group_activity]}', comments = '#{params[:comments]}' WHERE id = #{params[:id]}")
    return true
end

  #---------------------------------------------------------
  # Public: .all
  # Displays all products
  #---------------------------------------------------------
  def self.all
    results = DATABASE.execute("SELECT * FROM reservations")
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Product.new(r)
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
    # Returns: None
    #
    # State Changes: Deletes reservation
  #---------------------------------------------------------
  def self.delete(email)
      DATABASE.execute("DELETE FROM reservations WHERE email = '#{email}'")
  end

end
