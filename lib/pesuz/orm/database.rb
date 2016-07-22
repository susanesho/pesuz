require "sqlite3"

module Pesuz
  module Database
    def connect
      SQLite3::Database.new "app.db"
    end
  end
end
