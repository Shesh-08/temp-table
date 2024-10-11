# frozen_string_literal: true

module TempTable
  class Create
    attr_accessor :table_name, :columns

    def initialize(table_name, columns)
      super()
      @table_name = table_name
      @columns = columns
    end

    def perform
      column_definitions = columns.map { |name, type| "#{name} #{type}" }.join(", ")
      if column_definitions.empty?
        ActiveRecord::Base.connection.execute <<-SQL.squish
          CREATE TEMPORARY IF NOT EXISTS #{@table_name} (
            id SERIAL PRIMARY KEY
          );
        SQL
      else
        ActiveRecord::Base.connection.execute <<-SQL.squish
          CREATE TEMPORARY TABLE #{@table_name} (
            id SERIAL PRIMARY KEY,
            #{column_definitions}
          );
        SQL
      end
    end
  end
end
