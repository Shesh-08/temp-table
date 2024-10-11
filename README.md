# TempTable

You can create the temporary table using this gem so that you can make a temp table and store its data temproraly until the user's session is active.

To create temporary table.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'temp_table'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install temp_table

## Usage
    # To create copy of existing table Example:
    require "temp_table"
    TempTable.copy("original_table_name", "temp_table_name")

    # To create copy of existing table with extra columns Example:
    TempTable.copy("original_table_name", "temp_table_name", [{ name: "temp_table_id", data_type: "integer" }])

    # To insert row from original table to temp table Example:
    TempTable.insert_row_from_original("original_table_name", original_table_id, "temp_table_name")

    # To insert data to reference table Example:
    TempTable.insert_row_from_reference("temp_reference_id", reference_id, data, "original_table_name", "temp_table_name")

    # To create table Example:
    columns = { id: "integer", name: "varchar", phone: "bigint", email: "string" }
    TempTable.create("temp_table_name", columns)

    # To fetch data from temporary table
        # with condition
        conditions = {
            age: 25,
            status: 'active'
        }
        TempTable.fetch("temp_table_name", conditions)
        # without condition
        TempTable.fetch("temp_table_name") # to fetch all data of the table

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Shesh-08/temp_table.
