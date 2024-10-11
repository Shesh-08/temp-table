# frozen_string_literal: true

module TempTable
  class InsertRowFromReference
    attr_accessor :table_name, :original_table_name, :reference_column, :reference_id, :data, :original_id

    def initialize(reference_column, reference_id, data, original_table_name, table_name)
      super()
      @original_table_name = original_table_name
      @table_name = table_name
      @original_id = data.id
      @reference_column = reference_column
      @reference_id = reference_id
      @data = data
    end

    def perform
      formated_data = []
      formated_data << data.attributes
      formated_data[0]["original_id"] = original_id
      formated_data[0][reference_column] = reference_id
      InsertService.new(table_name, formated_data).perform
    end
  end
end
