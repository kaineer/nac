require 'nac'


Given /^I have started nac game with side (\d+)$/ do |side|
  @field = Nac::Field.new( side.to_i )
  @game = Nac::Game.new( @field )
  @game.start
end

Given /^nac game passed through (\S+) conway wave$/ do |color|
  item = color.to_sym
  @game.conway( item )
end

Then /^nac (\S+) player should have (\d+) steps? to spend$/ do |color, steps|
  item = color.to_sym
  assert_equal( item, @game.moving_side )
  assert_equal( steps.to_i, @game.steps_count )
end

Given /^nac game player issued commands:$/ do |table|
  @game.run_commands( table.raw.flatten.map do |command|
                        x, y, dir = command.split( /\s+/ )
                        [ x.to_i - 1, y.to_i - 1, dir ]
                      end
                      )
end
