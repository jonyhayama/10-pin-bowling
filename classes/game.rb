class Game
  attr_accessor :players

  def initialize(data)
    @players = []

    parse_data(data)
  end

  def run
    if is_finished? 
      print_score
    else
      puts "Game is incomplete!"
    end
  end

  def is_finished?
    return false if @players.empty?
    @players.each do |player|
      player.frames.each do |frame|
        return false unless frame.is_complete?
      end
    end

    return true
  end

  def print_score()
    puts "\n"
    @players.each do |player|
      scores = player.get_scores
      frame_template = player.frames.map{ |frame| { value: frame.num, colspan: frame.class.const_get('MAX_PLAYS'), alignment: :center } }
      
      rows = []
      rows << ['Frame', frame_template].flatten
      rows << ['Pinfalls', player.frames.map{ |frame| frame.results }].flatten
      rows << :separator
      rows << ['Score', frame_template.map.with_index { |t, i| t.clone.merge({ value: scores[i] }) }].flatten

      table = Terminal::Table.new title: player.name, :rows => rows
      puts table
      puts "\n"
    end
  end

  def parse_data(data)
    begin
      index = 1
      data.each do |chance|
        player = find_or_create_player(chance.first)
        player.add_ball(chance.last)
        index += 1
      end
    rescue Exception => e
      raise("Error on line #{index}: #{e.message}")
    end
  end

  def add_player(player)
    @players.push(player)
  end

  def find_player(name)
    @players.detect { |p| p.name == name }
  end

  def create_player(name)
    player = Player.new(name)
    add_player(player)

    player
  end

  def find_or_create_player(name)
    find_player(name) || create_player(name)
  end
end