require_relative "model_helper.rb"

module Pesuz
  class BaseModel < ModelHelper
    class << self
      attr_reader :table_name

      def to_table(table_name)
        @table_name = table_name
      end

      def property(column_name, args)
        @properties ||= {}
        @properties[column_name] = args
      end

      def create_table
        query = "CREATE TABLE IF NOT EXISTS #{@table_name} (#{get_column_properties})"
        @@db.execute(query)

        create_accessors
      end

      def get_column_properties
        all_properties = []
        @properties.each do |key, value|
          properties ||= []
          properties << key.to_s
          value.each do |name, type|
            properties << send("#{name.downcase}_query", type)
          end
          all_properties << properties.join(" ")
        end
        all_properties.join(", ")
      end

      def primary_key_query(status)
        "PRIMARY KEY AUTOINCREMENT" if status
      end

      def create_accessors
        methods = @properties.keys.map(&:to_sym)
        methods.each { |method| attr_accessor method }
      end

      def nullable_query(status = true)
        "NOT NULL" unless status
      end

      def type_query(value)
        value.to_s
      end

      def properties_keys
        @properties.keys
      end

      def map_object(row)
        model = new

        @properties.each_key.with_index do |value, index|
          model.send("#{value}=", row[index])
        end

        model
      end
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
  end
end
