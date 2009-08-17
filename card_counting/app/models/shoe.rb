class Shoe
  attr_reader :cards
  
  def initialize(decks)
    @cards = []
    decks.times do |i|
      deck = Deck.new
      @cards += deck.cards
    end
  end
  
  def deal
    @cards.shift
  end
end

