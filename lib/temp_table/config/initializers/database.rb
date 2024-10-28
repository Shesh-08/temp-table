require "active_record"

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3", # or 'postgresql', 'mysql2', etc.
  database: "db/development.sqlite3"
)
