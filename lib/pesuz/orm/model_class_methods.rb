module ModelClassMethods
  private

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
