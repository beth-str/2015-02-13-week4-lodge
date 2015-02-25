#---------------------------------------------------------
# Class: GuestActivity
# Facilitates results as objects for join table.
#
# Attributes:
# @id              - Integer (from guests table)
# @first_name      - String: first name of guest
# @last_name       - String: last name of guest
# @age             - Integer: age
# @name            - String: activity name
# @reservation_id  - Integer: id of reservation (foreign key)
#
# Public Methods:
# .show_guests_activities  
# .delete 
#---------------------------------------------------------

class GuestActivity
  
  attr_reader :id
  attr_accessor :first_name, :last_name, :age, :name, :reservation_id

  def initialize(options)
    @id              = options["id"]
    @first_name      = options["first_name"]
    @last_name       = options["last_name"]
    @age             = options["age"]
    @name            = options["name"]
    @reservation_id  = options["reservation_id"]
  end


  def self.show_guests_activities
    sql_query = "SELECT guests.id, guests.first_name, guests.last_name, guests.age, guests.reservation_id, activities.name FROM guests JOIN guests_activities ON Guests.id = Guests_activities.guest_id JOIN activities ON Activities.id = Guests_activities.activity_id"
    
    results = DATABASE.execute(sql_query)
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << GuestActivity.new(r)
      end
    return @results_as_objects
  end

  #---------------------------------------------------------
  # Public: #populate_join
  # Inserts new join data for guest/activity to the guests_activities table
  # Params: guest_id, activity_id (passed from form)
  #---------------------------------------------------------
  def populate_join(params)
    sql_query = "INSERT INTO guests_activities (guest_id, activity_id) VALUES ('#{params["guest_id"]}', '#{params["activity_id"]}')"
    
    DATABASE.execute(sql_query)
    @id = DATABASE.last_insert_row_id 
  end


end