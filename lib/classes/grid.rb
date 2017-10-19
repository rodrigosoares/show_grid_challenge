class Grid
  include Singleton

  def initialize
    @shows = []
  end

  def schedule(show)
    @shows << show
  end

  def query(region, airing_at)
    @shows.select do |show|
      show.region.eql?(region.upcase) &&
        Time.parse(airing_at).between?(show.starting_at, show.ending_at)
    end
  end
end
