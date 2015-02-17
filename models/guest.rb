#---------------------------------------------------------
# Class: Guest
# Facilitates management of the guests who visit the Lodge.
#
# Attributes:
# @id              - Integer (Primary Key - automatically assigned)
# @first_name      - String: first name of guest
# @last_name       - String: last name of guest
# @age             - Integer: age
# @gender          - String: gender
# @reservation_id - Integer: id from reservations table (Foreign Key)
#
# Public Methods:
# #insert
# .all  
# .delete 
#---------------------------------------------------------

class Guest
  attr_reader :id, :reservation_id
  attr_accessor :first_name, :last_name, :age, :gender
  
  def initialize(options)
    @id              = options["id"]
    @first_name      = options["first_name"]
    @last_name       = options["last_name"]
    @age             = options["age"]
    @gender          = options["gender"]
    @reservation_id = options["reservation_id"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO guests (first_name, last_name, age, gender, reservation_id) VALUES ('#{@first_name}', '#{@last_name}', '#{@age}', '#{@gender}', '#{@reservation_id}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end

  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Reservation object, this saves the changes to the database
  #---------------------------------------------------------
  def save(params)
    DATABASE.execute("UPDATE guests SET 
    first_name ='#{params[:first_name]}', 
    last_name ='#{params[:last_name]}', 
    age = #{params[:age]}, 
    gender = '#{params[:gender]}', 
    reservation_id = #{params[:reservation_id]}' 
    WHERE id = #{params[:id]}")
    return true
end

#---------------------------------------------------------
# Public: .where_id_is
# Searches the Guest class for a single id
#
# Parameter: Integer: id
#
# Returns: Single Guest object with matching id (passed as argument)
#---------------------------------------------------------
def where_id_is(id)
  x = DATABASE.execute("SELECT * FROM guests WHERE id = #{id}")
  results = Guest.new(params)
  return results
end

  
  #---------------------------------------------------------
  # Public: .all
  # Displays all guests
  #---------------------------------------------------------
  def self.all
    results = DATABASE.execute("SELECT * FROM guests")
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Guest.new(r)
      end
      results_as_objects = @results_as_objects
      return results_as_objects
  end

  # Public: #display_attributes
   # Returns the attributes of an object as a table.
   #
   # Parameters:
   # attributes              - Array: an array for the column headings      
   #
   # Returns:
   # Table -  String:  a detailed table for the object
   #
   # State changes:
   # creates a new row in table for each attribute of the object.
  
  def display_attributes
       attributes = []
       instance_variables.each do |i|
         # Example  :@name
         attributes << i.to_s.delete("@")
       end
      table = "<table><tr><th>FIELD</th><th>VALUE</th></tr>"
      attributes.each do |a|
        table += "<tr><td>#{a}</td><td>#{self.send(a)}</td></tr>"
      end
      table += "</table>"
      table
    end
end