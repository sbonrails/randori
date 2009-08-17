class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    Card::SUITS.keys.each do |suit|
      Card::INDICES.keys.each do | index|
        @cards << Card.new(suit, index)
      end
    end
  end
  
end