#---------------------------------------------------------
# Class: Activity
# Manages activities for our guests.
#
# Attributes:
# @id           - Integer (Primary Key) in activities table (automatically assigned)
# @name         - String: the activity name (e.g., 'Horseback Riding')
# @person_limit - Integer: number of people who can do this activity (at one time)
#
# Public Methods:
# #insert
# #save
# .all  
#---------------------------------------------------------

class Activity
  
  attr_reader :id
  attr_accessor :name, :person_limit
  
  def initialize(options)
    @id           = options["id"]
    @name         = options["name"]
    @person_limit = options["person_limit"]
  end
  
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #---------------------------------------------------------
  def insert
    sql_query = "INSERT INTO activities (name, person_limit) VALUES ('#{@name}', #{@person_limit})"
    
    DATABASE.execute(sql_query)
    
    @id = DATABASE.last_insert_row_id 
  end
  
  
  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Reservation object, this saves the changes to the database
  #---------------------------------------------------------
  def save(params)
    sql_query = "UPDATE activities SET name = '#{params[:name]}', person_limit = #{params[:person_limit]} WHERE id = #{params[:id]}"
    
    DATABASE.execute(sql_query)
    return true
end
  
  
  #---------------------------------------------------------
  # Public: .all
  # Displays all activities
  #---------------------------------------------------------
  def self.all
    sql_query = "SELECT * FROM activities"
    
    results = DATABASE.execute(sql_query)
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Activity.new(r)
      end
      results_as_objects = @results_as_objects
      return results_as_objects
  end


  #---------------------------------------------------------
  # Public: .where_id_is
  # Searches the Activity class for a single id
  #
  # Parameter: Integer: id
  #
  # Returns: Single Activity object with matching id (passed as argument)
  #---------------------------------------------------------
  def self.where_id_is(id)
    sql_query = "SELECT * FROM activities WHERE id = '#{id}'"
    
    x = DATABASE.execute(sql_query)
    results = Activity.new(x[0])
    return results
  end


end