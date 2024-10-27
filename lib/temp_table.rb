# frozen_string_literal: true

require_relative "temp_table/version"
require_relative "temp_table/config/initializers/database"
require_relative "temp_table/copy"
require_relative "temp_table/create"
require_relative "temp_table/fetch"
require_relative "temp_table/insert_row_from_original"
require_relative "temp_table/insert_row_from_reference"
require_relative "temp_table/insert"
require "logger"

module TempTable
  class Error < StandardError; end
  $logger = Logger.new(STDOUT)
  class << self
    def fetch(table_name, conditions = nil)
      TempTable::Fetch.new(table_name, conditions).perform
    end

    def insert(table_name, data)
      TempTable::Insert.new(table_name, data).perform
    end

    def insert_row_from_original(original_table_name, original_id, table_name)
      TempTable::InsertRowFromOriginal.new(original_table_name, original_id, table_name).perform
    end

    def insert_row_from_reference(reference_column, reference_id, data, original_table_name, table_name)
      TempTable::InsertRowFromReferenceService.new(reference_column, reference_id, data, original_table_name, table_name).perform
    end

    def create(table_name, columns)
      TempTable::Create.new(table_name, columns).perform
    end

    def copy(original_table_name, table_name, extra_columns = nil)
      TempTable::Copy.new(original_table_name, table_name, extra_columns).perform
    end
  end
end
