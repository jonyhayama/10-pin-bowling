class Frame
  MAX_PLAYS = 2
  TOTAL_PINS = 10
  attr_accessor :num
  attr_accessor :plays

  def initialize(num)
    @num = num
    @plays = []
  end

  def invalid_number_of_pins?(pins)
    pins.to_i > TOTAL_PINS || pins.to_i + @plays.inject(:+).to_i > TOTAL_PINS
  end

  def play(pins)
    raise "max number of #{MAX_PLAYS} plays reached" if @plays.count == self.class::MAX_PLAYS
    raise "invalid input" if pins.match(/^(\d{1,2}|F)$/).nil?
    raise "you can't have knocked #{pins} pins" if invalid_number_of_pins?(pins)
    @plays << pins.to_i
  end

  def is_strike?
    @plays.first == TOTAL_PINS
  end

  def is_spare?
    !is_strike? && @plays.inject(:+) == TOTAL_PINS
  end

  def is_complete?
    is_strike? || @plays.count == MAX_PLAYS
  end

  def results
    resp = @plays
    if is_strike?
      resp = ['X', ' ']
    elsif is_spare?
      resp = [@plays.first, '/']
    end

    resp.map{ |r| r.to_s.gsub('0', '-') }
  end
end