require 'sqlite3'

DATABASE = SQLite3::Database.new("database/lodge.db")


DATABASE.execute("CREATE TABLE IF NOT EXISTS admins
                (id INTEGER PRIMARY KEY,
                username TEXT NOT NULL,
                password TEXT NOT NULL,
                email TEXT NOT NULL)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS activities
                (id INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                person_limit INTEGER)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS guests
                (id INTEGER PRIMARY KEY,
                first_name TEXT NOT NULL,
                last_name TEXT NOT NULL,
                age INTEGER NOT NULL,
                gender TEXT NOT NULL,
                reservation_id INTEGER,
                FOREIGN KEY (reservation_id) REFERENCES reservations(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS guests_activities
                (id INTEGER PRIMARY KEY,
                guest_id INTEGER,
                activity_id INTEGER,
                FOREIGN KEY (guest_id) REFERENCES guests(id),
                FOREIGN KEY (activity_id) REFERENCES activities(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS reservations
                (id INTEGER PRIMARY KEY,
                name VARCHAR(60) NOT NULL,
                email VARCHAR(80) NOT NULL,
                address VARCHAR(80) NOT NULL,
                city VARCHAR(80) NOT NULL,
                state TEXT NOT NULL,
                phone VARCHAR(20) NOT NULL,
                no_adults INTEGER NOT NULL,
                no_children INTEGER,
                arrival_date TEXT NOT NULL,
                departure_date TEXT NOT NULL,
                comments TEXT,
                status TEXT)")

DATABASE.results_as_hash = true
# DATABASE.execute("SELECT * FROM guests_activities INNER JOIN categories ON Products.category_id = Categories.id")
# DATABASE.execute("SELECT * FROM products INNER JOIN locations ON Products.location_id = Locations.id")