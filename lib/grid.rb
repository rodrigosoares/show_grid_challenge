class Grid
  include Singleton

  # Initializes a Grid object.
  def initialize
    @shows = []
  end

  # Adds a show to the grid.
  def schedule(show)
    @shows << show
  end

  # Queries for a show based on the region and the airing time.
  def query(region, airing_at)
    shows = find_shows_by(region.upcase, airing_at)
    shows = find_shows_by(NATIONAL_ABBREV, airing_at) if shows.empty?
    shows
  end

  private

  NATIONAL_ABBREV = 'BR'

  def find_shows_by(region, airing_at)
    @shows.select do |show|
      show.region.eql?(region) &&
        Time.parse(airing_at).between?(show.starting_at, show.ending_at)
    end
  end
end
