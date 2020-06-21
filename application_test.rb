require "test/unit"

require_relative 'application.rb'

class ApplicationTest < Test::Unit::TestCase
  def setup
    @parsed_file = CSV.read('score.tsv', { :col_sep => "\t" })
  end

  def test_game_finished
    game = Game.new(@parsed_file)
    assert_equal true, game.is_finished?
  end

  def test_game_incomplete
    parsed_file = @parsed_file.first(83)
    game = Game.new(parsed_file)
    assert_equal false, game.is_finished?
  end

  def test_extra_moves
    parsed_file = @parsed_file
    parsed_file << ['Mark', '0']
    assert_raise_message('Error on line 85: There are no frames left for Mark to make this move...'){ Game.new(parsed_file) }
  end

  def test_jeff_score
    game = Game.new(@parsed_file)
    steve = game.find_or_create_player('Jeff')
    assert_equal [20, 39, 48, 66, 74, 84, 90, 120, 148, 167], steve.get_scores
  end

  def test_john_score
    game = Game.new(@parsed_file)
    steve = game.find_or_create_player('John')
    assert_equal [16, 25, 44, 53, 82, 101, 110, 124, 132, 151], steve.get_scores
  end

  def test_steve_score
    game = Game.new(@parsed_file)
    steve = game.find_or_create_player('Steve')
    assert_equal [17, 30, 37, 57, 77, 105, 123, 131, 151, 170], steve.get_scores
  end

  def test_perfect_score
    game = Game.new( Array.new(12) { [ 'Carl', '10' ] } )
    scores = game.players.first.get_scores
    assert_equal [ 30, 60, 90, 120, 150, 180, 210, 240, 270, 300], scores
  end

  def test_zero_score
    game = Game.new( Array.new(20) { [ 'Mark', '0' ] } )
    scores = game.players.first.get_scores
    assert_equal 0, scores.last
  end
end