class Boolean; end

module MiOS

  def self.cast(value, type)
    result = case
    when type == Integer
      value.to_i
    when type == Time
      Time.at(value.to_i)
    when type == Boolean
      value.to_i == 1
    when type == Float
      value.to_f
    else
      value
    end
    result
  end

end
