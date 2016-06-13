require "sqlite3"

module Pesuz
  module BaseMapper
    def self.connect
      SQLite3::Database.new "app.db"
    end
  end
end
