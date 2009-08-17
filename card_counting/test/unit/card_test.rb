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
end
