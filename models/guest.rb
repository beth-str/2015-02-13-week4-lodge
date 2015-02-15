#---------------------------------------------------------
# Class: Guest
# Facilitates management of the guests who visit the Lodge.
#
# Attributes:
# @id              - Integer (Primary Key - automatically assigned)
# @name            - String: name of guest
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
  attr_accessor :name, :age
  
  def initialize(options)
    @id              = options["id"]
    @name            = options["name"]
    @age             = options["age"]
    @reservations_id = options["reservations_id"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO guests (name, age, reservations_id) VALUES ('#{@name}', '#{@age}', '#{@reservations_id}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  #---------------------------------------------------------
  # Public: .all
  # Displays all locations
  #
  # Parameter: None
  #
  # Returns: None
  #
  # State Changes: None
  #---------------------------------------------------------
  def self.all
    x = DATABASE.execute("SELECT * FROM locations")
    x.each do |x|
        puts "#{x[0]}: #{x[1]}"
    end
  end

  def display
   attributes = []
   query_components_array = []

   instance_variables.each do |i|
     attributes << i.to_s.delete("@")
   end

   attributes.each do |a|
     value = self.send(a)
     if value.is_a?(Float)
       front_spacer = " " * (12 - a.length)
       back_spacer = " " * (49 - ("#{self.send(a)}".length))
       puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "$#{self.send(a)}"
     else
       front_spacer = " " * (12 - a.length)
       back_spacer = " " * (50 - ("#{self.send(a)}".length))
       puts "#{a}:" + "#{front_spacer}" + "#{back_spacer}" + "#{self.send(a)}"
     end
   end
   puts "=" * 63
   return
  end


  #---------------------------------------------------------
  # Public: .delete
  # Deletes a single location if no products are assigned to it
  #
  # Parameter: location_id
  #
  # Returns: None
  #
  # State Changes: Deletes location
  #---------------------------------------------------------
  def self.delete(id_to_remove)
    x = DATABASE.execute("SELECT location_id FROM products WHERE location_id = #{id_to_remove}")
    if x.length == 0
      DATABASE.execute("DELETE FROM locations WHERE id = #{id_to_remove}")
    else
      DATABASE.execute("SELECT * FROM products WHERE location_id = #{id_to_remove}")
    end
  end


  #---------------------------------------------------------
  # Public: #city
  # "Translates" between the location_id and the actual name of the city
  #---------------------------------------------------------
  def city
    DATABASE.execute("SELECT city FROM products INNER JOIN locations ON Products.location_id = Locations.id WHERE title = 'book_to_edit'8")
  end

end