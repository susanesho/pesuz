module Pesuz
  class ModelHelper
    extend BaseMapper
    @@db ||= BaseMapper.connect

    def self.all
      record = @@db.execute "SELECT #{properties_keys.join(",")} FROM #{@table_name}"

      record.map do |row|
        map_object(row)
      end
    end

    def save
      table_name = self.class.table_name
      if id
       @@db.execute "UPDATE #{table_name} SET
       #{update_records_placeholders} WHERE id = ?", update_records
     else
       @@db.execute "INSERT INTO #{table_name} (#{get_columns})
       VALUES  (#{new_record_placeholders})", new_record_values
     end
    end

    def self.destroy(id)
    end

    def destroy
    end

    def self.find(id)
      record = @@db.execute("SELECT #{properties_keys.join(",")}
                FROM #{@table_name} WHERE id = ?", id).first
      map_object(record)
    end

    def self.destroy_all
    end

  end
end