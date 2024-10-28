# frozen_string_literal: true

require "temp_table"
require "fileutils"
require "active_record"

RSpec.describe TempTable do
  it 'does something expected' do
    expect(TempTable.copy("test", "temp_test")).to eq(nil)
  end
end
