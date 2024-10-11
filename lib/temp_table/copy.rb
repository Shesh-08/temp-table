# frozen_string_literal: true

module TempTable
  class Copy
    attr_accessor :table_name, :original_table_name, :extra_columns

    def initialize(original_table_name, table_name, extra_columns = nil)
      super()
      @table_name = table_name
      @original_table_name = original_table_name
      @extra_columns = extra_columns
    end

    def perform
      ActiveRecord::Base.connection.execute <<-SQL.squish
      CREATE TEMPORARY TABLE IF NOT EXISTS #{table_name} (
        id SERIAL PRIMARY KEY,
        original_id INTEGER
      );
      SQL
      add_columns_from_original
      add_extra_columns unless extra_columns.nil?
      add_foreign_key
    end

    private

    def add_columns_from_original
      original_columns = ActiveRecord::Base.connection.columns(original_table_name).reject do |c|
        c.name == "id"
      end

      return if original_columns.blank?

      column_definitions = fetch_column_definitions(original_columns)

      return if column_definitions.blank?

      column_definitions_string = column_definitions.join(", ")

      sql = <<-SQL.squish
        ALTER TABLE #{table_name}
        #{column_definitions_string};
      SQL

      Rails.logger.info("Executing SQL: #{sql}")

      ActiveRecord::Base.connection.execute(sql)
    rescue ActiveRecord::StatementInvalid => e
      Rails.logger.info("SQL Error: #{e.message}")
    end

    def add_foreign_key
      return unless temporary_table?(table_name)

      if temporary_table?(original_table_name)
        ActiveRecord::Base.connection.execute <<-SQL.squish
          ALTER TABLE #{table_name}
          ADD CONSTRAINT fk_original
          FOREIGN KEY (original_id) REFERENCES #{original_table_name}(id);
        SQL
      else
        Rails.logger.info("Cannot add foreign key: #{original_table_name} is not a temporary table.")
      end
    end

    def temporary_table?(table_name)
      ActiveRecord::Base.connection.tables.include?(table_name) &&
        ActiveRecord::Base.connection.execute("SELECT pg_is_temp('#{table_name}')").first["pg_is_temp"]
    end

    def fetch_column_definitions(original_columns)
      existing_columns = ActiveRecord::Base.connection.columns(table_name).map(&:name)

      column_definitions_from_original = original_columns.reject do |column|
        existing_columns.include?(column.name)
      end
      column_definitions_from_original.map do |column|
        "ADD COLUMN #{column.name} #{column.sql_type}"
      end
    end

    def add_extra_columns
      existing_columns = ActiveRecord::Base.connection.columns(table_name).map(&:name)

      column_definitions_from_original = extra_columns.reject do |column|
        existing_columns.include?(column[:name])
      end

      return if column_definitions_from_original.blank?

      column_definitions = extra_columns.map do |column|
        "ADD COLUMN #{column[:name]} #{column[:data_type]}"
      end

      extra_difinitions_columns = column_definitions.join(", ")

      ActiveRecord::Base.connection.execute <<-SQL.squish
        ALTER TABLE #{table_name}
        #{extra_difinitions_columns};
      SQL
    end
  end
end
