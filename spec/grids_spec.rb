require 'spec_helper'

describe Grid do
  let(:show) { Show.new('RJ', 'Jornal da Globo', '00:00', '01:00') }

  subject { Grid.instance }

  before(:each) { subject.instance_variable_set(:@shows, []) }

  describe '.new' do
    it 'initializes a show grid' do
      expect(subject.instance_variable_get(:@shows)).to be_empty
    end
  end

  describe '#schedule' do

    before(:each) { subject.schedule(show) }

    it 'adds a show to the grid if the show does not exist yet' do
      expect(subject.instance_variable_get(:@shows).size).to be(1)
    end

    it 'does not add a show to the grid if it already exists' do
      subject.schedule(show)
      expect(subject.instance_variable_get(:@shows).size).to be(1)
    end
  end

  describe '#query' do
    let(:national_show) { Show.new('BR', 'Jornal Nacional', '20:00', '21:00') }

    it 'queries for a regional show in the airing time' do
      subject.schedule(show)
      expect(subject.query('RJ', '00:30')).to contain_exactly(show)
    end

    it 'queries for a national show if a regional is not found' do
      subject.schedule(national_show)
      expect(subject.query('SC', '20:45')).to contain_exactly(national_show)
    end
  end
end
