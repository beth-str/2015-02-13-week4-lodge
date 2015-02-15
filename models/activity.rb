#---------------------------------------------------------
# Class: Location
# Facilitates management of the warehouse locations (city) to store our products.
#
# Attributes:
# @id     - Integer (Primary Key) in locations table (automatically assigned)
# @city   - String: the city name and state abbreviation (e.g., 'Omaha NE')
#
# Public Methods:
# #insert
# .all  
# .delete 
#---------------------------------------------------------

class Location
  attr_reader :id
  attr_accessor :city
  
  def initialize(options)
    # @id   = options["id"]
    @city = options["city"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #
  # Parameter: None
  #
  # Returns: None
  #
  # State Changes: None
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO locations (city) VALUES ('#{@city}')")
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

end