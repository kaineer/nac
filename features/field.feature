@field
Feature: Not a conway game field
In order to play not-a-conway game
Player will need game field

  Scenario: Create empty field
    Given I have an empty default game field
     Then game field should look like this:
       | . . . . . |
       | . . . . . |
       | . . . . . |
       | . . . . . |
       | . . . . . |

  Scenario: Create custom sized field
    Given I have an empty 7x6 game field
     Then game field should look like this:
       | . . . . . . . |
       | . . . . . . . |
       | . . . . . . . |
       | . . . . . . . |
       | . . . . . . . |
       | . . . . . . . |
  
  Scenario: Pieces counts on board created
    Given I have an empty default game field
     Then I have no gold pieces on board
      And I have no silver pieces on board
  
  Scenario: Placing coins and counting
    Given I have an empty default game field
      And I place gold pieces at:
        | 0 0 | 
        | 1 1 | 
        | 2 2 | 
      And I place silver pieces at:
        | 1 0 | 
        | 2 1 |
     Then I have 3 gold pieces on board
      And I have 2 silver pieces on board    
      And game field should look like this:
        | G S . . . |
        | . G S . . |
        | . . G . . |
        | . . . . . |
        | . . . . . |

  Scenario: Placing coins and overwriting
    Given I have an empty default game field
      And I place gold pieces at:
        | 0 0 | 
        | 1 1 | 
      And I place silver pieces at:
        | 0 0 | 
     Then I have 1 gold piece on board
      And I have 1 silver piece on board    
      And game field should look like this:
        | S . . . . |
        | . G . . . |
        | . . . . . |
        | . . . . . |
        | . . . . . |

  @conway
  Scenario: Conway case 1, alone piece dies
    Given I have an empty 3x3 game field
      And I place gold piece at:
        | 1 1 |
      And I apply gold conway wave to field
     Then game field should look like this:
       | . . . |
       | . . . |
       | . . . |

  @conway
  Scenario: Conway case 2, group of two pieces dies
    Given I have an empty 4x4 game field
      And I place gold pieces at:
        | 1 1 |
        | 2 2 |
      And I apply gold conway wave to field
     Then game field should look like this:
       | . . . . |
       | . . . . |
       | . . . . |
       | . . . . |

  @conway
  Scenario: Conway case 3, birth in strange place
    Given I have an empty 7x6 game field
      And I place gold pieces at:
        | 2 0  |
        | 3 0 |
        | 4 0 |
        | 1 1 |
        | 1 2 |
        | 1 3 |
        | 2 4 |
        | 3 4 |
        | 4 4 |
        | 5 1 |
        | 5 2 |
        | 5 3 |
      And I apply gold conway wave to field
     Then game field should look like this:
       | . . G G G . . | 
       | . G . G . G . | 
       | G G G . G G G | 
       | . G . G . G . | 
       | . . G G G . . | 
       | . . . G . . . | 
 
  @conway
  Scenario: Conway case 4, birth and death
    Given I have an empty 4x4 game field
      And I place gold pieces at:
       | 0 2 |
       | 1 1 |
       | 2 0 |
       | 2 3 |
       | 3 2 |
      And I apply gold conway wave to field
     Then game field should look like this:
       | . . G . |
       | . G G . |
       | G G G . |
       | . . . . |
