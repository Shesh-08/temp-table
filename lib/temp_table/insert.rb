# frozen_string_literal: true

module TempTable
  class Insert
    attr_accessor :table_name, :data

    def initialize(table_name, data)
      super()
      @table_name = table_name
      @data = data
    end

    def perform
      data.each do |row|
        column_names = row.keys.join(", ")
        values = row.values.map do |value|
          if value.is_a?(Array)
            ActiveRecord::Base.connection.quote(value.to_json)
          else
            ActiveRecord::Base.connection.quote(value)
          end
        end
        ActiveRecord::Base.connection.execute <<-SQL.squish
          INSERT INTO #{@table_name} (#{column_names})
          VALUES (#{values.join(', ')});
        SQL
      end
    end
  end
end
