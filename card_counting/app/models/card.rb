class Card
  attr_reader :suit, :index
  
  SUITS = {
    :heart => 'h',
    :spade => 's',
    :diamond => 'd',
    :club => 'c'
  }
  
  INDICES = { 
    1 => '1', 
    2 => '2', 
    3 => '3', 
    4 => '4', 
    5 => '5', 
    6 => '6',
    7 => '7', 
    8 => '8', 
    9 => '9', 
    10 => '10', 
    11 => 'j', 
    12 => 'q', 
    13 => 'k'
  }
  
  def initialize( suit, index )
    SUITS.keys.include?( suit ) or raise ArgumentError, "bad suit #{suit}"
    INDICES[index] or raise ArgumentError, "bad index #{index}"
    @suit = suit
    @index = index
  end
  
  def filename
    SUITS[@suit] + INDICES[@index] + ".png"
  end
  
  # def ==(other)
  #   self.suit == other.suit && self.index == other.index
  # end
end
