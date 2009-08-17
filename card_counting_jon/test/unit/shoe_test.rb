require 'test_helper'

class ShoeTest < ActiveSupport::TestCase

  def test_create_shoe
    shoe = Shoe.new(6)
    assert_equal 6*52, shoe.cards.size
  end
  
  def test_deal
    shoe = Shoe.new(6)
    card = shoe.deal
    assert_equal 6*52 - 1, shoe.cards.size
    assert card.is_a?(Card)
  end
  
  def test_shoe_count
    shoe = Shoe.new(1)
    assert_equal 0, shoe.count
    shoe = Shoe.new(2)
    assert_equal -4, shoe.count
    shoe = Shoe.new(6)
    assert_equal -20, shoe.count
    shoe = Shoe.new(8)
    assert_equal -28, shoe.count
  end
end
