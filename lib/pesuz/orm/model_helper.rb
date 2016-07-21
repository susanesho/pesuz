module Pesuz
  module ModelHelper
    private

    def update_placeholders(params)
      columns = params.keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def update_values(params)
      params.values << id
    end

    def get_columns
      columns = self.class.properties.keys
      columns.delete(:id)
      columns.join(",")
    end

    def new_record_placeholders
      placeholders = ["?"] * (self.class.properties.keys.size - 1)
      placeholders.join(",")
    end

    def update_records_placeholders
      columns = self.class.properties.keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def update_record_values
      properties = self.class.properties.keys
      properties.delete(:id)
      ppts = properties.map { |method| send(method) }
      ppts << send(:id)
    end

    def new_record_values
      properties = self.class.properties.keys
      properties.delete(:id)
      properties.map { |value| send(value) }
    end
  end
end
