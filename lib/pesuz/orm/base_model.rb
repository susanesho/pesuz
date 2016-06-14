require_relative "model_helper.rb"

module Pesuz
  class BaseModel < ModelHelper
    def self.to_table(table_name)
      @table_name = table_name
    end

    class << self
      attr_reader :table_name
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
      all_properties.join(", ")
    end

    def self.primary_key_query(status)
      "PRIMARY KEY AUTOINCREMENT" if status
    end

    def self.create_accessors
      metds = @properties.keys.map(&:to_sym)
      metds.each { |mtd| attr_accessor mtd }
    end

    def self.nullable_query(status = true)
      "NOT NULL" unless status
    end

    def self.type_query(value)
      value.to_s
    end

    def self.properties_keys
      @properties.keys
    end

    def update_placeholders(params)
      columns = params.keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def update_values(params)
      params.values << id
    end

    def get_columns
      columns = self.class.properties_keys
      columns.delete(:id)
      columns.join(",")
    end

    def new_record_placeholders
      placeholders = ["?"] * (self.class.properties_keys.size - 1)
      placeholders.join(",")
    end

    def update_records_placeholders
      columns = self.class.properties_keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def update_record_values
      properties = self.class.properties_keys
      properties.delete(:id)
      ppts = properties.map { |method| send(method) }
      ppts << send(:id)
    end

    def new_record_values
      properties = self.class.properties_keys
      properties.delete(:id)
      properties.map { |value| send(value) }
    end

    def self.map_object(row)
      model = new

      @properties.each_key.with_index do |value, index|
        model.send("#{value}=", row[index])
      end

      model
    end
  end
end
