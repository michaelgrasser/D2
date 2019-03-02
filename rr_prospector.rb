# Prospector class
class Prospector
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
    puts "Rubyist ##{@id} starting in Enumerable Canyon."
    (1..@turns).each do |i|
      prospect_turn
      new_pos = @map.move(@pos)
      i == @turns ? puts(ruby_count + end_string) : puts("Heading from #{@locations.at(@pos)} to #{@locations.at(new_pos)}.")
      @pos = new_pos
    end
  end

  def prospect_turn
    success = true
    while success
      turn = @map.mine(@pos)
      @real += turn.at(0)
      @fake += turn.at(1)
      success = !(turn.at(0) + turn.at(1)).zero?
      @days += 1
      puts turn_putter(turn.at(0), turn.at(1))
    end
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
