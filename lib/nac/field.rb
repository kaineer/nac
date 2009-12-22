#
#
#
module Nac
  class Field
    def initialize( width = 5, height = nil )
      @width = width
      @height = height || @width
      
      init_field
    end

    attr_reader :width, :height

    def []( x, y )
      @items[ y ][ x ]
    end

    def []=( x, y, v )
      @items[ y ][ x ] = v
    end

    def count( sym )
      @items.flatten.select{|s|s == sym}.size
    end

    def in_limits( x, y )
      (0...@width).include?( x ) && (0...@height).include?( y )
    end

    def shift_coords( x, y, dir )
      sx, sy = x, y
      case dir
      when "up" then sy -= 1
      when "down" then sy += 1
      when "left" then sx -= 1
      when "right" then sx += 1
      end

      sx = sy = nil unless in_limits( sx, sy )

      [ sx, sy ]
    end

    def move( x, y, dir )
      dir = dir.downcase
      item = self[ x, y ]
      sx, sy = shift_coords( x, y, dir )

      # moving to empty place only
      if sx && sy && !self[ sx, sy ]
        self[ x, y ] = nil
        self[ sx, sy ] = item
      end
    end

    def neibours( x, y )
      cells = []
      ((x-1)..(x+1)).each do |cx|
        ((y-1)..(y+1)).each do |cy|
          if !( cx == x && cy == y ) && in_limits( cx, cy ) && @wave_item == self[ cx, cy ]
            cells << [ cx, cy ]
          end
        end
      end
      cells
    end

    def conway( item )
      @wave_item = item

      init_states
      apply_states
    end

  protected

    def empty_rectangle
      Array.new( @height ) {|| Array.new( @width )}
    end

    def init_field
      @items = empty_rectangle
    end

    def for_all_coordinates( &block )
      (0...@width).each do |x|
        (0...@height).each do |y|
          block.call( x, y )
        end
      end
    end

    def init_states
      @states = empty_rectangle

      for_all_coordinates do |x, y|
        ngb = neibours( x, y )

        # too lonely
        if ngb.size == 1 && self[ x, y ] == @wave_item
          ngb2 = neibours( *(ngb.first) )
          @states[ y ][ x ] = :death if ngb2.size < 2 
        end
        
        # time to birth
        if ngb.size == 3 && self[ x, y ] != @wave_item
          @states[ y ][ x ] = :birth
        end
        
        # too crowded
        if ngb.size >= 4 && self[ x, y ] == @wave_item
          @states[ y ][ x ] = :death
        end
      end
    end

    def apply_states
      for_all_coordinates do |x, y|
        case @states[ y ][ x ]
        when :death then self[ x, y ] = nil
        when :birth then self[ x, y ] = @wave_item
        end
      end
    end
  end
end
