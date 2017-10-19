class Statement
  def initialize(raw_statement)
    parse(raw_statement)
  end

  def execute!
    if @type.eql?('S')
      show = Show.new(@region, @show_name, @starting_at, @ending_at)
      GRID.schedule(show)
    else
      shows = GRID.query(@region, @airing_at)
      output(shows)
    end
  end

  private

  GRID = Grid.instance

  STATEMENT_REGEX = %r(
    (?<type>[SQ])\s
    "(?<region>\w{2})"\s
    (
      "(?<show_name>.+)"\s
      (?<starting_at>([0]?\d|1\d|2[0-3]):([0-5]\d))\s
      (?<ending_at>([0]?\d|1\d|2[0-3]):([0-5]\d))
    |
      (?<airing_at>([0]?\d|1\d|2[0-3]):([0-5]\d))
    )
  )ix

  def parse(raw_statement)
    match = raw_statement.match(STATEMENT_REGEX)
    define_fields_from(match) unless match.nil?
  end

  def output(shows)
    if shows.empty?
      puts "A \"#{@region}\" #{@airing_at} noise"
    else
      shows.each do |show|
        puts "A \"#{@region}\" #{@airing_at} \"#{show.region}\" \"#{show.name}\""
      end
    end
  end

  def define_fields_from(match)
    @type        = match[:type]
    @region      = match[:region]
    @show_name   = match[:show_name]
    @starting_at = match[:starting_at]
    @ending_at   = match[:ending_at]
    @airing_at   = match[:airing_at]
  end
end
