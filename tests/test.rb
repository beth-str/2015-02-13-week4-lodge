require 'minitest/autorun'
require 'sqlite3'
require 'pry'
DATABASE = SQLite3::Database.new("data_for_testing.db")
# require_relative 'db_setup.rb'
require_relative "../module.rb"
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
    DATABASE.execute("DELETE FROM guests WHERE id = x")
  end

  def test_activity_creation
    new_activity = Activity.new({'name' => 'Lawn darts', 'person_limit' => '8'})
    x = new_activity.insert
    assert_kind_of(Integer, x)
    DATABASE.execute("DELETE FROM activities WHERE name = 'Lawn darts'")
  end

  def test_list_all_reservations
    y = DATABASE.execute("SELECT * FROM reservations")
    assert_equal(y.length, Reservation.all.length)
  end

  # --------------------------



  def test_location_deletion
    new_location = Location.new({'city' => "Jacksonville FL"})
    x = new_location.insert
    array = Location.delete(x)
    assert_equal(0, array.length)
  end

  def test_category_deletion
    new_category = Category.new({'genre' => "sweetness"})
    x = new_category.insert
    array = Category.delete(x)
    assert_equal(0, array.length)
  end

  def test_location_deletion_with_existing_products
    location = Location.delete(3)
    assert_empty([], location)
  end

  def test_category_deletion_with_existing_products
    category = Category.delete(1)
    assert_empty([], category)
  end


end
