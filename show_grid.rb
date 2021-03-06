#!/usr/bin/env ruby

# Requirements.
$LOAD_PATH << './lib'
require 'singleton'
require 'time'
require 'grid'
require 'show'
require 'statement'

# STDIN reading method to capture user statements.
def run!
  $stdin.each do |raw_statement|
    stmt = Statement.new(raw_statement.chomp)
    stmt.execute!
  end
end

# Main execution flux.
begin
  run!
rescue Interrupt
  puts
end
