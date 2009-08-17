class Shoe
  attr_reader :cards
  attr_reader :count
  
  def initialize(decks)
    @cards = []
    @count = 4 - (4 * decks)
    decks.times do |i|
      deck = Deck.new
      @cards += deck.cards
    end
  end
  
  def deal
    card = @cards.shift
    @count += card.count
    card
  end
  
end

