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
    @reservation_id  = options["reservation_id"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation into the database
  #
  # Returns: The @id (Integer) of the newly created Guest object 
  #---------------------------------------------------------
  def insert
    sql_query = "INSERT INTO guests (first_name, last_name, age, gender, reservation_id) VALUES ('#{@first_name}', '#{@last_name}', '#{@age}', '#{@gender}', '#{@reservation_id}')"
    
    DATABASE.execute(sql_query)
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end

  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Guest object, this saves the changes to the database
  #
  # Returns: True 
  #---------------------------------------------------------
  def save(params)
    sql_query = "UPDATE guests SET 
    first_name = '#{params[:first_name]}', 
    last_name = '#{params[:last_name]}', 
    age = #{params[:age]}, 
    gender = '#{params[:gender]}', 
    reservation_id = #{params[:reservation_id]} 
    WHERE id = #{params[:id]}"

    DATABASE.execute(sql_query)
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
  def self.where_id_is(id)
    sql_query = "SELECT * FROM guests WHERE id = '#{id}'"

    x = DATABASE.execute(sql_query)
    results = Guest.new(x[0])
    return results
  end


  #---------------------------------------------------------
  # Public: .all
  # Displays all guests
  #
  # Returns: An Array of Guest objects 
  #---------------------------------------------------------
  def self.all
    sql_query = "SELECT * FROM guests"

    results = DATABASE.execute(sql_query)
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Guest.new(r)
      end
      results_as_objects = @results_as_objects
      return results_as_objects
  end

end