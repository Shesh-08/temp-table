# frozen_string_literal: true

module TempTable
  class InsertRowFromOriginal
    attr_accessor :table_name, :original_table_name, :original_id

    def initialize(original_table_name, original_id, table_name)
      super()
      @original_table_name = original_table_name
      @table_name = table_name
      @original_id = original_id
    end

    def perform
      result = ActiveRecord::Base.connection.execute <<-SQL.squish
        INSERT INTO #{@table_name} (original_id, #{column_names})
        SELECT id, #{column_names} FROM #{@original_table_name}
        WHERE id = #{ActiveRecord::Base.connection.quote(original_id)}
        RETURNING id;
      SQL

      result.getvalue(0, 0)
    end

    private

    def column_names
      ActiveRecord::Base.connection.columns(@original_table_name).reject { |c| c.name == "id" }.map(&:name).join(", ")
    end
  end
end
