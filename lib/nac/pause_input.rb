module Nac
  class PauseInput
    def initialize( timeout = 0.5 )
      @timeout = timeout
    end

    def get_commands( side )
      puts
      Kernel::sleep( @timeout )
      return []
    end
  end
end
