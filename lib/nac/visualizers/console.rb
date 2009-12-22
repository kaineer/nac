module Nac
  module ConsoleVisualizer
    def self.esc( sym, color )
      "\e[#{color}m#{sym}\e[0m"
    end


    def self.visualize_single_item( item )
      case item
      when NilClass then "."
      when :gold then esc( "G", "31" )
      when :silver then esc( "S", "32" )
      end
    end

    def self.display_items( items )
      items.each do |row|
        puts row.map {|item| visualize_single_item( item )} * " "
      end
    end
  end
end
