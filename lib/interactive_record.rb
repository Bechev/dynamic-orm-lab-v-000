require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    self.to_s.pluralize.downcase
  end

  def self.column_names
    sql = "PRAGMA table_info( #{self.table_name} )"
    columns_info = DB[:conn].execute(sql)
    columns_name = []
    columns_info.each do |column|
      columns_name << column[1]
    end
    columns_name
  end



  def initialize(option={})
    option.each do |key,value|
      self.send("#{key}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    #binding.pry
    test = self.class.column_names
    test = test.delete("id")
  end

end
