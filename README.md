## Show Grid Challenge

This code is related to a challenge I took part, which consists of implementing a grid of TV shows for a major media group in Brazil. The chosen language is Ruby version 2.4.x, using RSpec version 3.6 as the TDD framework.

## Challenge description

The TV signal is geolocated, which means the show currently being broadcasted varies depending on where its spectators are. For example, there are local TV news like RJTV, SPTV and DFTV, which are broadcasted only in Rio de Janeiro, São Paulo and the Federal District regions, respectively.

If there are no local shows, the national signal is broadcasted instead. This means there are some shows that are broadcasted in all regions.

The challenge was to implement a code that receives show data to be inserted into the TV grid and, when asked by state and time, returns the current local show or a special keyword, if no show for the query is found. All the data should be inserted and queried via STDIN (standard input) and STDOUT (standard output).

### Data input: adding shows to the grid

- Each entry is given in a single line via STDIN.
- Expected format: `S <region> <show_name> <start_time> <end_time>`.
- Example: RJTV is aired at the noon: `S "RJ" "RJTV" 12:00 13:00`.

### Data input: querying shows from the grid

- Each entry is given in a single line via STDIN.
- Expected format: `Q <region> <time>`.
- Example: Which TV show is aired at the noon?: `Q "RJ" 12:00`.

### Data output: answering the queries

- Each answer is given in a single line via STDOUT.
- Expected format: `A <query_region> <time> <show_region> <show_name>`.
- Format when there is no available show: `A <query_region> <time> noise`.
- Example 1: RJTV is the show aired at the noon in Rio de Janeiro: `A "RJ" 12:00 "RJ" "RJTV"`.
- Example 2: No show is aired at 3 a.m. in Rio de Janeiro: `A "RJ" 03:00 noise`.

### More examples
----
Input:
```
S "GO" "Foo Show" 05:00 06:00
S "BR" "Bar Show" 05:00 06:00
Q "GO" 05:30
Q "SP" 05:28
```
Output:
```
A "GO" 05:30 "GO" "Foo Show"
A "SP" 05:28 "BR" "Bar Show"
```
----
Input:
```
S "DF" "DF News" 12:01 13:29
S "RJ" "RJ News" 12:01 13:29
S "SP" "SP News" 12:01 13:29
Q "RJ" 13:00
Q "GO" 12:50
```
Output:
```
A "RJ" 13:00 "RJ" "RJ News"
A "GO" 12:50 noise
```

## Instructions

- Install Ruby version 2.4.x (RVM is recommended to manage Ruby versions).
- Run `bundle install`.
- Run the program with `ruby show_grid.rb`.
- Enter any of the test strings listed before to add shows to the grid or to query them.
- Type `Ctrl-C` to leave.
- Run RSpec tests with `rspec --format d` (optional).
