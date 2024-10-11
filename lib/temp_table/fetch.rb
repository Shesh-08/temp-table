# frozen_string_literal: true

module TempTable
  class Fetch
    attr_accessor :table_name, :conditions

    def initialize(table_name, conditions = nil)
      @table_name = table_name
      @conditions = conditions
    end

    def perform
      query = "SELECT * FROM #{table_name}"

      if conditions.present?
        condition_strings = conditions.map do |column, value|
          "#{column} = #{ActiveRecord::Base.connection.quote(value)}"
        end
        query += " WHERE #{condition_strings.join(' AND ')}"
      end

      ActiveRecord::Base.connection.execute(query).to_a
    end
  end
end
