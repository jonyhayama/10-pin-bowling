require_relative 'frame.rb'
class BonusFrame < Frame
  MAX_PLAYS = 3

  def is_complete?
    if is_strike? || is_spare?
      @plays.count == MAX_PLAYS 
    else 
      @plays.count == MAX_PLAYS - 1
    end
  end

  def invalid_number_of_pins?(pins)
    pins.to_i > TOTAL_PINS || pins.to_i + @plays.inject(:+).to_i > TOTAL_PINS * (@plays.count + 1)
  end

  def is_spare?
    !is_strike? && @plays.first(2).inject(:+) == 10
  end

  def results
    if is_strike?
      resp = @plays.map{ |p| p.to_s.gsub('10', 'X') }
    elsif is_spare?
      resp = [@plays.first, '/', @plays.last]
    else
      resp = [@plays, ' '].flatten
    end

    resp.map{ |p| p.to_s.gsub('0', '-') }.flatten
  end
end