require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns #omg amazing the fucking DBConnection::execute2 command will return the first element as an array of all the column names amazing
    @columns ||= DBConnection.execute2('SELECT * FROM cats')[0].map(&:to_sym) # smart to memoize dope
  end

  def self.finalize!
    columns.each do |column| # have to call the method because @columns won't be defined until the first run of that method love it
      define_method(column) do
        attributes_hash = attributes
        attributes_hash[column.to_sym]
      end

      define_method(column.to_s + '=') do |val|
        attributes_hash = attributes # fucking killed it got it heh you'll get it all in the end push forward keep pushing
        attributes_hash[column.to_sym] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize # name is a method defined on objects of class Class to get the name of that class in a string amazing lol
  end

  def self.all
    select_string = "SELECT * FROM #{table_name}" # fucking love it right need to do it outside the SQL pass of course just do it before construct it as a string before passing it in brilliant getting good at this solving everything on your own is the secret to everything so lucky to be good at it all
    parse_all(DBConnection.execute(select_string))
  end

  def self.parse_all(results)
    parsed_results = Array.new
    results.each do |result|
      parsed_results << new(result) # right new is a self method fucking love it can do self.new or just new
    end
    parsed_results
  end

  def self.find(id)
    select_string = "SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1" # always limit to 1 lol though unncessary for id
    parse_all(DBConnection.execute(select_string))[0] # fucking crushed it in one go no errors finally lmao
  end

  def initialize(params = {})
    columns = SQLObject.columns
    params.each do |param|
      raise ArgumentError.new("unknown attribute '#{param[0]}'") unless columns.include?(param[0].to_sym) # need a symbol in here in case it fucking is passed in as a string hilarious great debugging though lol
      self.send param[0].to_s+'=', param[1]
    end
  end

  def attributes
    @attributes ||= Hash.new
  end

  def attribute_values
    @attributes.values # well that was easy lmao wtf way easier than his method wtf hmmmm
  end

  # totally getting the right shit which is nuts almost done need to set the values after you figure out how to pass it correctly finish part 1 and do part 2 for sure
  def insert # ah puts the specific instance of an object into the table, like save basically
    columns = SQLObject.columns[1..-1].join(',') #remove the ID column right
    question_marks = (["?"] * (SQLObject.columns.length-1)).join(',')
    insert_string = "INSERT INTO #{self.class.table_name} (#{columns}) VALUES (#{question_marks})"
    DBConnection.execute(insert_string, *attribute_values) # fucking killed it it's working thank god lmfao you fucking got the fucking question marks and the splat operator working the splat operator will break a fucking array into all its elements and just pass all those in as separate arguments fucking love it
    self.id = DBConnection.last_insert_row_id # omfg killed it fuck yeah let's fucking do this shit!!!
  end

  def update
    columns = SQLObject.columns[1..-1].map do
      
    end.join(',') # your hilariously bad code when no one's watching lol good to know you can write very clean code though when needed
    update_string = "UPDATE #{self.class.table_name} SET #{columns} WHERE id = #{self.id}"
  end

  def save
    # ...
  end
end
