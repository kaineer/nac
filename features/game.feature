@game
Feature: Not a conway game
In order to play something interesting
Player will need a game running

Scenario: Starting game
  Given I have started nac game with side 9
   Then game field should look like this:
     | . . . . . . . . . |
     | . . . . G . . . . |
     | . . . G . G . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |

Scenario: Starting game + first conway wave
  Given I have started nac game with side 9
    And nac game passed through gold conway wave
   Then game field should look like this:
     | . . . . . . . . . |
     | . . . . G . . . . |
     | . . . G G G . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
    And nac gold player should have 1 step to spend

Scenario: Giving a command
  Given I have started nac game with side 9
    And nac game passed through gold conway wave
    And nac game player issued commands:
     | 5 3 down | 
   Then game field should look like this:
     | . . . . . . . . . |
     | . . . . G . . . . |
     | . . . G . G . . . |
     | . . . . G . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
     | . . . . . . . . . |
    And nac gold player should have 0 steps to spend
