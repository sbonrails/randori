require 'test_helper'

class DeckTest < ActiveSupport::TestCase

  def test_deck_size
    deck = Deck.new
    assert_equal 52, deck.cards.size
  end
  
  def test_initialize__uniqueness
    deck = Deck.new
    assert_equal 1, deck.cards.select{|card| card.suit == :spade && card.index == 5}.size
    
    # assert_equal 52, deck.cards.uniq.size
  end
  
  
end