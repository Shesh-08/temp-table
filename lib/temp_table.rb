# frozen_string_literal: true

require_relative "temp_table/version"

module TempTable
  class Error < StandardError; end
  def self.fetch(table_name, conditions = nil)
    TempTable::Fetch.new(table_name, conditions).perform
  end

  def self.insert(table_name, data)
    TempTable::Insert.new(table_name, data).perform
  end

  def self.insert_row_from_original(original_table_name, original_id, table_name)
    TempTable::InsertRowFromOriginal.new(original_table_name, original_id, table_name).perform
  end

  def self.insert_row_from_reference(reference_column, reference_id, data, original_table_name, table_name)
    TempTable::InsertRowFromReferenceService.new(reference_column, reference_id, data, original_table_name, table_name).perform
  end

  def self.create(table_name, columns)
    TempTable::Create.new(table_name, columns).perform
  end

  def self.copy(original_table_name, table_name, extra_columns = nil)
    TempTable::Copy.new(original_table_name, table_name, extra_columns = nil).perform
  end
end
