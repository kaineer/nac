require 'nac'

module Nac
  class Field
    def visualize_item( item )
      case item
      when NilClass then "."
      when :gold then "G"
      when :silver then "S"
      else "E"
      end
    end

    def visualize
      @items.map{|row|
        row.map {|item| visualize_item( item )}.join
      }
    end
  end
end

Given /^I have an empty default game field$/ do
  @field = Nac::Field.new
end

Then /^game field should look like this:$/ do |table|
  assert_equal(
               table.raw.flatten.map {|str|
                 str.gsub( /\s+/, "" )
               }, @field.visualize 
               )
end

Given /^I have an empty (\d+)x(\d+) game field$/ do |width, height|
  @field = Nac::Field.new( width.to_i, height.to_i )
end

Then /^I have (\S+) (\S+) pieces? on board$/ do |count, color|
  quantity = ( count == "no" ) ? 0 : count.to_i
  item = color.to_sym

  assert_equal( quantity, @field.count( item ) )
end

Given /^I place (\S+) pieces at:$/ do |color, table|
  item = color.to_sym
  table.raw.flatten.each do |coords|
    x, y = coords.split( /\s+/ ).map{|s|s.to_i}
    @field[ x, y ] = item
  end
end
