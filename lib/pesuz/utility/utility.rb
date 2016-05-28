class String
  def snakecase
    gsub!("::", "/")
    gsub!(/([A-Z]+)([A-Z][a-z])/, '1_2')
    gsub!(/([a-zd])([A-Z])/, '1_2')
    tr!("-", "_")
    downcase!
    self
  end
end