require 'minitest/autorun'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("data_for_testing.db")
# require_relative 'db_setup.rb'
require_relative "../helpers.rb"
require_relative "../models/activity.rb"
require_relative "../models/guest.rb"
require_relative "../models/reservation.rb"


class LodgeTest < Minitest::Test

  # include WarehouseHelper   #if using module only
  # def setup
  #   DATABASE.execute("DELETE FROM categories")
  #   DATABASE.execute("DELETE FROM locations")
  #   DATABASE.execute("DELETE FROM products")
  # end

  # assert equal(expected, actual)

  def test_reservation_creation
    new_reservation = Reservation.new({'name' => 'Hammrich Family', 'email' => 'info@hammrich.com', 'city' => 'Ipswich', 'state' => 'SD', 'phone' => '6058870000', 'no_adults' => 2, 'no_children' => 0, 'arrival_date' => '03/26/2015', 'departure_date' => '03/28/2015', 'comments' => 'None', 'status' => 'requested'})
    
    x = new_reservation.insert
    assert_kind_of(Integer, x)
  end

  def test_reservation_deletion
    new_reservation = Reservation.new({'name' => 'Hamm Family', 'email' => 'info@hammric.com', 'city' => 'Ipswich', 'state' => 'SD', 'phone' => '6058870000', 'no_adults' => 2, 'no_children' => 3, 'arrival_date' => '03/26/2015', 'departure_date' => '03/28/2015', 'comments' => 'None', 'status' => 'requested'})
    x = new_reservation.insert
    array = Reservation.delete(new_reservation.email)
    assert_equal(0, array.length)
  end

  def test_guest_creation
    new_guest = Guest.new({'first_name' => 'Jen', 'last_name' => 'Lacey', 'age' => 17, 'gender' => 'female', 'reservation_id' => 4})
    x = new_guest.insert
    assert_kind_of(Integer, x)
  end

  def test_activity_creation
    new_activity = Activity.new({'name' => 'Lawn darts', 'person_limit' => '8'})
    x = new_activity.insert
    assert_kind_of(Integer, x)
  end

  def test_list_all_reservations
    binding.pry
    y = DATABASE.execute("SELECT * FROM reservations")
    assert_equal(y.length, Reservation.all.length)
  end

  def test_list_all_activities
    y = DATABASE.execute("SELECT * FROM activities")
    assert_equal(y.length, Activity.all.length)
  end

  def test_list_all_guests
    y = DATABASE.execute("SELECT * FROM guests")
    assert_equal(y.length, Guest.all.length)
  end

end
