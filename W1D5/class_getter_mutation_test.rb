class Class1
    attr_reader :str
    def initialize(string); @str = string end
end

class Class2
    def initialize; end
    def class1_replace_char(class1_obj, char, index); class1_obj.str[index] = char end
    def class1_concat_str(class1_obj, string); class1_obj.str << string end
end