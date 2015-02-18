#---------------------------------------------------------
# Class: Activity
# Manages activities for our guests.
#
# Attributes:
# @id           - Integer (Primary Key) in activities table (automatically assigned)
# @name         - String: the activity name (e.g., 'Horseback Riding')
# @person_limit - Integer: number of people who can do this activity 
#
# Public Methods:
# #insert
# #save
# .all  
#---------------------------------------------------------

class Activity
  include LodgeHelper
  attr_reader :id
  attr_accessor :name, :limit
  
  def initialize(options)
    @id   = options["id"]
    @name  = options["name"]
    @person_limit = options["person_limit"]
  end
  
  #---------------------------------------------------------
  # Public: #insert
  # Inserts new instantiation to the database
  #---------------------------------------------------------
  def insert
    DATABASE.execute("INSERT INTO activities (name, limit) VALUES ('#{@name}', '#{@person_limit}')")
    @id = DATABASE.last_insert_row_id     # will return the value of the row id
  end
  
  #---------------------------------------------------------
  # Public: #save
  # When changes are made to a Reservation object, this saves the changes to the database
  #---------------------------------------------------------
  def save(params)
    DATABASE.execute("UPDATE activities SET name ='#{params[:name]}', person_limit = #{params[:person_limit]}' WHERE id = #{params[:id]}")
    return true
end
  
  
  #---------------------------------------------------------
  # Public: .all
  # Displays all activities
  #---------------------------------------------------------
  def self.all
    results = DATABASE.execute("SELECT * FROM activities")
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << Activity.new(r)
      end
      results_as_objects = @results_as_objects
      return results_as_objects
  end

end