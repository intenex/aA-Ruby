class AttrAccessorObject # love it interpolation works wonders so nuts lol
  def self.my_attr_accessor(*names) # ah god damn it right just use the provided define_method method to set instance variables love it
    names.each do |name|
      define_method(name) do
        instance_variable_get('@' + name.to_s)
      end

      define_method(name.to_s + '=') do |val|
          instance_variable_set('@' + name.to_s, val)
      end
    end
  end
end
