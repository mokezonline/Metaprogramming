require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @cols if @cols
    @cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
      #{self.table_name}
    SQL

    @cols.map!(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        attributes[col]
      end
      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    self.to_s.downcase.split(" ").join("_") + 's'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.each do |attr_name, val|
      attr_name.to_sym
      if self.class.columns.include?(attr_name)
        self.send.("#{attr_name} = val")
      else
        raise unknown attribute "#{attr_name}"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...

  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
