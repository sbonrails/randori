require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def test_create_card 
    card = Card.new(:spade, 5)
    
    assert_equal :spade, card.suit
    assert_equal 5, card.index
  end
  
  def test_suit_out_of_range
    assert_raises(ArgumentError) { Card.new(:colin, 5) }
  end
  
  def test_index_out_of_range
    assert_raises(ArgumentError) { Card.new(:spade, 14) }
    assert_raises(ArgumentError) { Card.new(:spade, 0) }
  end
  
  def test_filename
    card = Card.new(:spade, 7)
    
    assert_equal('s7.png', card.filename)
  end
  
  def test_count
    Card::SUITS.keys.each do |suit|
      card = Card.new(suit, 1)
      assert_equal -1, card.count
      card = Card.new(suit, 2)
      assert_equal 1, card.count
      card = Card.new(suit, 3)
      assert_equal 1, card.count
      card = Card.new(suit, 4)
      assert_equal 1, card.count
      card = Card.new(suit, 5)
      assert_equal 1, card.count
      card = Card.new(suit, 6)
      assert_equal 1, card.count
      card = Card.new(suit, 7)
      assert_equal 1, card.count
      card = Card.new(suit, 8)
      assert_equal 0, card.count
      card = Card.new(suit, 9)
      assert_equal 0, card.count
      card = Card.new(suit, 10)
      assert_equal -1, card.count
      card = Card.new(suit, 11)
      assert_equal -1, card.count
      card = Card.new(suit, 12)
      assert_equal -1, card.count
      card = Card.new(suit, 13)
      assert_equal -1, card.count
    end
  end
  
end
