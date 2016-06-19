module Pesuz
  class ModelHelper
    extend BaseMapper
    @@db ||= BaseMapper.connect

    class << self

      def all
        record = @@db.execute "SELECT #{properties_keys.join(',')}
        FROM #{@table_name} ORDER BY id DESC"

        record.map do |row|
          map_object(row)
        end
      end

       def destroy(id)
        @@db.execute "DELETE FROM #{@table_name} WHERE id = ?", id
      end

       def first
        query = @@db.execute(
          "SELECT * FROM #{@table_name} ORDER BY id LIMIT 1"
        ).first

        map_object(query)
      end

      def last
        query = @@db.execute(
          "SELECT * FROM #{@table_name} ORDER BY id LIMIT 1"
        ).first

        map_object(query)
      end

      def find(id)
        record = @@db.execute("SELECT #{properties_keys.join(',')}
                  FROM #{@table_name} WHERE id = ?", id).first

        map_object(record)
      end

      def destroy_all
        @@db.execute "DELETE FROM #{@table_name}"
      end
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
