#
#
#

module Nac
  class Game
    def initialize( field, opts = {} )
      @field = field

      @command_source = opts[ :command_source ]
      @visualizer = opts[ :visualizer ]

      @playing_sides = [ :gold, :silver ]
      @current_side = @playing_sides.first
      @sides_initialized = {}
    end

    attr_reader :moving_side, :steps_count

    def middle
      @field.width / 2
    end

    def run
      until self.finished?
        self.round
      end
    end

    def round
      unless @sides_initialized[ @current_side ]
        init_side( @current_side )
        @sides_initialized[ @current_side ] = true
      end

      conway( @current_side )
      
      # TODO: visualize
      @field.visualize( @visualizer ) if @visualizer

      # TODO: make_a_move
      if @command_source
        run_commands( @command_source.get_commands( @current_side ) ) 
      else
        puts "Press ENTER to continue"
        gets if @visualizer
      end

      select_next_side
    end

    def run_commands( commands )
      commands.each do |cmd|
        break if @steps_count <= 0
        break unless @field.move( *cmd )
        @steps_count -= 1
      end
    end

    def finished?
      @field.count( @current_side ) == 0
    end

    def select_next_side
      @current_side =
        case @current_side
        when :gold then :silver
        when :silver then :gold
        end
    end

    def start
      init_gold
    end

    def conway( item )
      @field.conway( item )
      @moving_side = item
      @steps_count = [ 0, @field.count( item ) - 3 ].max
    end

    def init_side( side )
      case side
      when :gold then init_gold
      when :silver then init_silver
      end
    end

    def init_gold
      @field[ middle - 1, 2 ] = :gold
      @field[ middle + 0, 1 ] = :gold
      @field[ middle + 1, 2 ] = :gold
    end

    def init_silver
      bottom = @field.height - 2
      
      @field[ middle - 1, bottom - 1 ] = :silver
      @field[ middle + 0, bottom     ] = :silver
      @field[ middle + 1, bottom - 1 ] = :silver
    end
  end
end
