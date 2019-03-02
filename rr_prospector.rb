# Prospector class
class Prospector
  def initialize(turns, map)
    @pos = 0
    @real = 0
    @fake = 0
    @turns = turns
    @map = map
    @days = 0
    @locations = ['Enumerable Canyon', 'Duck Type Beach', 'Monkey Patch City',
                  'Nil Town', 'Matzburg', 'Hash Crossing', 'Dynamic Palisades']
  end

  def prospect
    (1..@turns).each do
      rubies = prospect_turn
      @real += rubies.at(0)
      @fake += rubies.at(1)
    end
  end

  def prospect_turn
    success = true
    while success
      turn = @map.mine(@pos)
      real = turn.at(0)
      fake = turn.at(1)
      success = !(turn.at(0) + turn.at(1)).zero?
      @days += 1
      turn_putter(real, fake)
    end
    [real, fake]
  end

  def turn_putter(real, fake)
    loc = @locations.at(@pos)
    if (real + fake).zero?
      puts "Found no rubies or fake rubies in #{loc}"
    end
  end

  def ruby_string(rubies)
    case rubies
    when 0
      ''
    when 1
      '1 ruby'
    else
      '{rubies} rubies'
    end
  end
end
