require 'optparse'
require 'csv'
require 'terminal-table'

require_relative 'classes/player.rb'
require_relative 'classes/frame.rb'
require_relative 'classes/bonus_frame.rb'
require_relative 'classes/game.rb'

OptionParser.new do |opts|
  opts.on("-f", "--file FILE", "File path") do |file|
    parsed_file = CSV.read(file, { :col_sep => "\t" })
    begin
      Game.new(parsed_file).run
    rescue Exception => e
      puts e.message
    end
  end
end.parse!
