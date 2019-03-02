# Prospector class
class Prospector
  attr_reader :real
  attr_reader :fake
  def initialize(turns, map, id)
    @pos = 0
    @real = 0
    @fake = 0
    @turns = turns
    @map = map
    @id = id
    @days = 0
    @locations = ['Enumerable Canyon', 'Duck Type Beach', 'Monkey Patch City',
                  'Nil Town', 'Matzburg', 'Hash Crossing', 'Dynamic Palisades']
  end

  def prospect
    puts start_string
    (1..@turns).each do |i|
      turn = prospect_turn
      add_to_rubies(turn)
      new_pos = @map.move(@pos)
      puts check_end_of_rubyist(i, new_pos)
      @pos = new_pos
    end
  end

  def prospect_turn
    real = 0
    fake = 0
    success = true
    while success
      turn = @map.mine(@pos)
      puts turn_putter(turn.at(0), turn.at(1))
      success = !(turn.at(0) + turn.at(1)).zero?
      real += turn.at(0)
      fake += turn.at(1)
      @days += 1
    end
    [real, fake]
  end

  def add_to_rubies(rubies)
    @real += rubies.at(0)
    @fake += rubies.at(1)
  end

  def check_end_of_rubyist(turn, new_pos)
    turn == @turns ? ruby_count + end_string : moving_string(@pos, new_pos)
  end

  def start_string
    "Rubyist ##{@id} starting in Enumerable Canyon."
  end

  def turn_putter(real, fake)
    loc = @locations.at(@pos)
    if (real + fake).zero?
      "\tFound no rubies or fake rubies in #{loc}"
    else
      "\tFound #{ruby_string(real)}"\
      "#{(!real.zero? && !fake.zero? ? ' and ' : '')}"\
      "#{fake_string(fake)} in #{loc}"
    end
  end

  def ruby_string(rubies)
    case rubies
    when 0
      ''
    when 1
      '1 ruby'
    else
      "#{rubies} rubies"
    end
  end

  def fake_string(rubies)
    case rubies
    when 0
      ''
    when 1
      '1 fake ruby'
    else
      "#{rubies} fake rubies"
    end
  end

  def moving_string(pos, new_pos)
    "Heading from #{@locations.at(pos)} to #{@locations.at(new_pos)}."
  end

  def ruby_count
    "After #{@days} days, Rubyist ##{@id} found:\n"\
    "\t#{@real.zero? ? '0 rubies' : ruby_string(@real)}.\n"\
    "\t#{@fake.zero? ? '0 fake rubies' : fake_string(@fake)}.\n"\
  end

  def end_string
    if @real.zero?
      'Going home empty handed.'
    else
      @real < 10 ? 'Going home sad.' : 'Going home victorious!'
    end
  end
end
