require 'spec_helper'

describe Statement do
  let(:raw_schedule_stmt) { 'S "DF" "Bom dia DF" 06:01 07:29' }
  let(:raw_query_stmt)    { 'Q "DF" 07:00' }

  describe '.new' do
    it 'initializes a statement' do
      stmt = Statement.new(raw_schedule_stmt)
      expect(stmt.instance_variable_get(:@type)).to eq('S')
      expect(stmt.instance_variable_get(:@region)).to eq('DF')
      expect(stmt.instance_variable_get(:@show_name)).to eq('Bom dia DF')
      expect(stmt.instance_variable_get(:@starting_at)).to eq('06:01')
      expect(stmt.instance_variable_get(:@ending_at)).to eq('07:29')
    end
  end

  describe '#execute!' do
    let(:valid_answer_stmt) { "A \"DF\" 07:00 \"DF\" \"Bom dia DF\"\n" }
    let(:noise_answer_stmt) { "A \"DF\" 07:00 noise\n" }

    before(:each) do
      Grid.instance.instance_variable_set(:@shows, [])
      @schedule_stmt = Statement.new(raw_schedule_stmt)
      @query_stmt = Statement.new(raw_query_stmt)
    end

    context 'when entering a scheduling statement' do
      it 'schedules a show' do
        @schedule_stmt.execute!
        expect(Grid.instance.instance_variable_get(:@shows)).not_to be_empty
      end
    end

    context 'when entering a query statement' do
      it 'returns the scheduled show if it exists' do
        @schedule_stmt.execute!
        expect { @query_stmt.execute! }.to output(valid_answer_stmt).to_stdout
      end

      it 'returns a noise answer if it does not exist' do
        expect { @query_stmt.execute! }.to output(noise_answer_stmt).to_stdout
      end
    end
  end
end
