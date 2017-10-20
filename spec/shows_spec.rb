require 'spec_helper'

describe Show do
  describe '.new' do
    it 'initializes a show' do
      show = Show.new('rj', 'Jornal da Globo', '00:00', '01:00')
      expect(show.region).to eq('RJ')
      expect(show.name).to eq('Jornal da Globo')
      expect(show.starting_at).to eq(Time.parse('00:00'))
      expect(show.ending_at).to eq(Time.parse('01:00'))
    end
  end

  describe '#same?' do
    let(:show_1) { Show.new('RJ', 'Foo', '00:00', '01:00') }
    let(:show_2) { Show.new('RJ', 'Foo', '00:00', '01:00') }
    let(:show_3) { Show.new('RJ', 'Bar', '01:00', '02:00') }

    it 'checks if the target show is equal to the current show' do
      expect(show_1.same?(show_2)).to be(true)
      expect(show_1.same?(show_3)).to be(false)
    end
  end
end
