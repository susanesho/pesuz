module Pesuz
  class BaseModel < BaseMapper
    @@db ||= BaseMapper.connect

    def self.to_table(table_name)
      @table_name = table_name
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

    def self.get_column_properties
      all_properties = []
      @properties.each do |key, value|
        properties ||= []
        properties << key.to_s
        value.each do |key, value|
          properties << send("#{key.downcase}_query", value)
        end
        all_properties << properties.join(" ")
      end
    end

    def self.primary_key_query(status)
      "PRIMARY KEY AUTOINCREMENT" if status
    end

    def self.nullable_query(status = true)
      "NOT NULL" unless  status
    end

    def self.type_query(value)
      value.to_s
    end
  end
end