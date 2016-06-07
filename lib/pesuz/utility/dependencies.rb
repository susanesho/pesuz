class Object
  def self.const_missing(c)
    require c.to_s.snakize
    Object.const_get(c)
  end
end
