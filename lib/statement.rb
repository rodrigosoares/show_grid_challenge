class Statement
  # Initializes a Statement object.
  def initialize(raw_statement)
    parse(raw_statement)
  end

  # Executes the statement based on its type (S for scheduling or Q for querying).
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

  # Instantiates or retrieves a singleton Grid object (the show DB).
  GRID = Grid.instance

  # Matches 'S "XX" "show name" XX:XX YY:YY' or 'Q "XX" XX:XX'.
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

  # Parses the raw statement and defines its fields if there is a match.
  def parse(raw_statement)
    match = raw_statement.match(STATEMENT_REGEX)
    define_fields_from(match) unless match.nil?
  end

  # Prints the answer to the query depending if the show exists in the grid.
  def output(shows)
    if shows.empty?
      puts "A \"#{@region}\" #{@airing_at} noise"
    else
      shows.each do |show|
        puts "A \"#{@region}\" #{@airing_at} \"#{show.region}\" \"#{show.name}\""
      end
    end
  end

  # Defines the statement fields.
  def define_fields_from(match)
    @type        = match[:type]
    @region      = match[:region]
    @show_name   = match[:show_name]
    @starting_at = match[:starting_at]
    @ending_at   = match[:ending_at]
    @airing_at   = match[:airing_at]
  end
end
