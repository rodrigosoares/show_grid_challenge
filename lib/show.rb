class Show
  attr_reader :name, :region, :starting_at, :ending_at

  def initialize(region, name, starting_at, ending_at)
    @region = region.upcase
    @name = name
    @starting_at = Time.parse(starting_at)
    @ending_at = Time.parse(ending_at)
  end

  def same?(other)
    @region.eql?(other.region) &&
      @name.eql?(other.name) &&
      @starting_at.eql?(other.starting_at) &&
      @ending_at.eql?(other.ending_at)
  end
end
