class Player
  attr_accessor :name
  attr_accessor :frames

  def initialize(name)
    @name = name
    @current_frame_index = 0
    @frames = Array.new(10) { |i| 
      num = i +1 
      (num) == 10 ? BonusFrame.new( num ) : Frame.new( num ) 
    }
  end

  def get_frame(index)
    @frames[index]
  end

  def current_frame
    get_frame(@current_frame_index)
  end

  def add_ball(pins)
    frame = current_frame
    raise "There are no frames left for #{self.name} to make this move..." if frame.nil?
    frame.play(pins) 
    if frame.is_complete?
      @current_frame_index += 1
    end
  end

  def next_two_balls(index)
    next_two_balls = []
    next_frame_index = index + 1

    while next_two_balls.length < 2
      next_frame = get_frame(next_frame_index)
      next_two_balls.concat(next_frame.plays)
      next_frame_index += 1
    end

    next_two_balls.first(2)
  end

  def get_scores
    total_score = 0
    scores = []
    self.frames.each_with_index do |frame, i|
      frame_score = frame.plays.inject(:+)
      if !frame.is_a?(BonusFrame) && ( frame.is_strike? || frame.is_spare? )
        next_two_balls = next_two_balls(i)
        frame_score += next_two_balls.first
        frame_score += next_two_balls.last if frame.is_strike?
      end

      total_score += frame_score
      scores << total_score
    end

    scores
  end
end