#---------------------------------------------------------
# Class: GuestActivity
# Facilitates results as objects for join table.
#
# Attributes:
# @id              - Integer (from guests table)
# @first_name      - String: first name of guest
# @last_name       - String: last name of guest
# @age             - Integer: age
# @activity        - String: name of activity (from activities table)
#
# Public Methods:
# .show_guests_activities  
# .delete 
#---------------------------------------------------------

class GuestActivity
  attr_reader :id
  attr_accessor :first_name, :last_name, :age, :name

  def initialize(options)
    @id              = options["id"]
    @first_name      = options["first_name"]
    @last_name       = options["last_name"]
    @age             = options["age"]
    @activity        = options["name"]
    @reservation_id  = options["reservation_id"]
  end


  def self.show_guests_activities
    results = DATABASE.execute("SELECT guests.id, guests.first_name, guests.last_name, guests.age, guests.reservation_id, activities.name FROM guests JOIN guests_activities ON Guests.id = Guests_activities.guest_id JOIN activities ON Activities.id = Guests_activities.activity_id")
    @results_as_objects = []
      results.each do |r|
        @results_as_objects << GuestActivity.new(r)
        guest_activity = @results_as_objects
      return guest_activity
    end
  end

end