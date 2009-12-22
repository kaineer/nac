module Nac
  class ConsoleInput
    def get_commands( side )
      if side == :silver 
        str = gets.chomp
        return [] if str.nil? || str.empty?
        str.split( ";" ).map{|s|
          x, y, dir = s.split( "," )
          [ x.to_i, y.to_i, dir.downcase ]
        }
      else
        []
      end
    end
  end
end
