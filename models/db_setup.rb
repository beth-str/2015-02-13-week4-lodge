require 'sqlite3'

DATABASE = SQLite3::Database.new("database/lodge.db")


DATABASE.execute("CREATE TABLE IF NOT EXISTS admins
                (id INTEGER PRIMARY KEY,
                username TEXT NOT NULL,
                password TEXT NOT NULL,
                email TEXT NOT NULL)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS activities
                (id INTEGER PRIMARY KEY,
                name TEXT NOT NULL)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS guests
                (id INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                age INTEGER NOT NULL,
                reservations_id INTEGER,
                FOREIGN KEY (reservations_id) REFERENCES reservations(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS guests_activities
                (id INTEGER PRIMARY KEY,
                guests_id INTEGER,
                activities_id INTEGER,
                FOREIGN KEY (guests_id) REFERENCES guests(id),
                FOREIGN KEY (activities_id) REFERENCES activities(id))")

DATABASE.execute("CREATE TABLE IF NOT EXISTS reservations
                (id INTEGER PRIMARY KEY,
                name TEXT NOT NULL UNIQUE,
                email TEXT NOT NULL,
                address TEXT NOT NULL,
                city TEXT NOT NULL,
                state TEXT NOT NULL,
                phone INTEGER NOT NULL,
                no_adults INTEGER NOT NULL,
                no_children INTEGER,
                arrival_date TEXT NOT NULL,
                departure_date TEXT NOT NULL,
                group_activity TEXT,
                comments TEXT)")

DATABASE.results_as_hash = true
# DATABASE.execute("SELECT * FROM products INNER JOIN categories ON Products.category_id = Categories.id")
# DATABASE.execute("SELECT * FROM products INNER JOIN locations ON Products.location_id = Locations.id")