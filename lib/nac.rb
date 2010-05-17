# --- Not a conway
#
#
require File.join( File.dirname( __FILE__ ), "nac/field" )
require File.join( File.dirname( __FILE__ ), "nac/game" )


module Nac
  VERSION = "0.0.1"
  DATE = "2009.12.18"
end

if $0 == __FILE__
  require File.join( File.dirname( __FILE__ ), "nac/visualizers/console" )
  require File.join( File.dirname( __FILE__ ), "nac/pause_input" )
  require File.join( File.dirname( __FILE__ ), "nac/console_input" )

  game = Nac::Game.new( Nac::Field.new( 15 ),
                        :visualizer => Nac::ConsoleVisualizer ,
                        # :command_source => Nac::ConsoleInput.new
                        :command_source => Nac::PauseInput.new( 0.1 )
                        )

  loop do
    game.round
  end
end
