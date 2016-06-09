require "sqlite3"

module Pesuz
  class BaseMapper
    def self.connect
      SQLite3::Database.new File.join "db", "app.db"
    end
  end
end