class NacField
  def initialize( width = 5, height = nil )
    @width = width
    @height = height || @width

    @items = Array.new( @height ) {|| 
      Array.new( @width )
    }
  end

  attr_reader :width
  attr_reader :height

  # first side is gold
  # second is silver

  def gold_count
    tag_count( :gold )
  end

  def silver_count
    tag_count( :silver )
  end

  def tag_count( tag )
    @items.inject( 0 ) { |sum, row|
      sum + row.inject( 0 ) { |sum, value|
        value == tag ? sum + 1 : sum
      }
    }
  end

  def start_game
    place_gold_initial
  end

  def []( x, y )
    @items[ y ][ x ]
  end

  def place_gold_initial
    @items[ 2 ][ 1 ] = :gold
    @items[ 1 ][ 2 ] = :gold
    @items[ 2 ][ 3 ] = :gold
  end

  def print_item( item )
    case item
    when NilClass then "."
    when :gold then "G"
    when :silver then "S"
    else "E"
    end
  end

  def print
    @items.each do |row|
      row.each do |item|
        Kernel::print " "
        Kernel::print print_item( item )
      end
      puts
    end
  end

end
