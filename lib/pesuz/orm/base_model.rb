module Pesuz
  class BaseModel
    include ModelHelper
    extend ModelClassMethods
    extend Database
    @@db ||= connect

    attr_reader :table_name, :properties

    def self.to_table(table_name)
      @table_name = table_name
    end

    def self.table_name
      @table_name
    end

    def self.properties
      @properties
    end

    def self.property(column_name, args)
      @properties ||= {}
      @properties[column_name] = args
    end

    def self.create_table
      query = "CREATE TABLE IF NOT EXISTS #{@table_name} (#{get_column_properties})"
      @@db.execute(query)

      create_accessors
    end

    def self.all
      record = @@db.execute "SELECT * FROM #{@table_name} ORDER BY id DESC"
      record.map do |row|
        map_object(row)
      end
    end

    def self.destroy(id)
      @@db.execute "DELETE FROM #{@table_name} WHERE id = ?", id
    end

    def self.first
      query = @@db.execute(
        "SELECT * FROM #{@table_name} ORDER BY id LIMIT 1"
      ).first

      map_object(query)
    end

    def self.last
      query = @@db.execute(
        "SELECT * FROM #{@table_name} ORDER BY id DESC LIMIT 1"
      ).first

      map_object(query)
    end


    def self.find(id)
      record = @@db.execute("SELECT *
                FROM #{@table_name} WHERE id = ?", id).first

      map_object(record)
    end

    def self.destroy_all
      @@db.execute "DELETE FROM #{@table_name}"
    end

    def save
      table_name = self.class.table_name
      if id
        @@db.execute "UPDATE #{table_name} SET
        #{update_records_placeholders} WHERE id = ?", update_record_values
      else
        @@db.execute "INSERT INTO #{table_name} (#{get_columns})
        VALUES  (#{new_record_placeholders})", new_record_values
      end
    end

    def update(params)
      table_name = self.class.table_name
      @@db.execute "UPDATE #{table_name} SET
      #{update_placeholders(params)} WHERE id=?", update_values(params)
    end

    def destroy
      table_name = self.class.table_name

      @@db.execute "DELETE FROM #{table_name} WHERE id = ?", id
    end
  end
end
