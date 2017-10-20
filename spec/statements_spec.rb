require 'spec_helper'

describe Statement do
  let(:raw_schedule_stmt) { 'S "DF" "Bom dia DF" 06:01 07:29' }

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
    let(:raw_national_stmt)     { 'S "BR" "Globo Rural" 05:00 06:00' }
    let(:raw_query_stmt_sp)     { 'Q "SP" 05:28' }
    let(:raw_query_stmt_df)     { 'Q "DF" 07:00' }
    let(:valid_answer_output)   { "A \"DF\" 07:00 \"DF\" \"Bom dia DF\"\n" }
    let(:valid_national_output) { "A \"SP\" 05:28 \"BR\" \"Globo Rural\"\n" }
    let(:noise_answer_output)   { "A \"DF\" 07:00 noise\n" }

    before(:each) do
      Grid.instance.instance_variable_set(:@shows, [])
      @schedule_stmt = Statement.new(raw_schedule_stmt)
      @query_stmt = Statement.new(raw_query_stmt_df)
    end

    context 'when entering a scheduling statement' do
      it 'schedules a show' do
        @schedule_stmt.execute!
        show = Grid.instance.instance_variable_get(:@shows).sample
        expect(show).not_to be_nil
        expect(show.region).to eq('DF')
        expect(show.name).to eq('Bom dia DF')
      end
    end

    context 'when entering a query statement' do
      it 'returns the scheduled show if it exists' do
        @schedule_stmt.execute!
        expect { @query_stmt.execute! }.to output(valid_answer_output).to_stdout
      end

      it 'returns a noise answer if it does not exist' do
        expect { @query_stmt.execute! }.to output(noise_answer_output).to_stdout
      end

      it 'returns a national show if a regional does not exist' do
        Statement.new(raw_national_stmt).execute!
        sp_stmt = Statement.new(raw_query_stmt_sp)
        expect { sp_stmt.execute! }.to output(valid_national_output).to_stdout
      end
    end
  end
end
