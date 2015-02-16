#---------------------------------------------------------
# Class: Guest
# Facilitates management of the guests who visit the Lodge.
#
# Attributes:
# @id              - Integer (Primary Key - automatically assigned)
# @first_name      - String: first name of guest
# @last_name       - String: last name of guest
# @age             - Integer: age
# @reservations_id - Integer: id from reservations table (Foreign Key)
#
# Public Methods:
# #insert
# .all  
# .delete 
#---------------------------------------------------------

class Guest
  attr_reader :id, :reservations_id
  attr_accessor :first_name, :last_name, :age
  
  def initialize(options)
    @id              = options["id"]
    @first_name      = options["first_name"]
    @last_name       = options["last_name"]
    @age             = options["age"]
    @reservations_id = options["reservations_id"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO guests (first_name, last_name, age, reservations_id) VALUES ('#{@first_name}', '#{@last_name}', '#{@age}', '#{@reservations_id}')")
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
    reservations_id = #{params[:reservations_id]}' 
    WHERE id = #{params[:id]}")
    return true
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