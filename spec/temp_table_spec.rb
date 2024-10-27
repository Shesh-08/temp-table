require 'temp_table'

RSpec.describe TempTable do
  it 'does something expected' do
    debugger
    expect(TempTable.copy("test", "temp_test")).to eq('expected_result')
  end
end
