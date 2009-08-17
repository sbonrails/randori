require 'test_helper'

class ShoeTest < ActiveSupport::TestCase

  def test_create_shoe
    shoe = Shoe.new(4)
    assert_equal 4*52, shoe.cards.size
  end
  
  def test_deal
    shoe = Shoe.new(4)
    card = shoe.deal
    assert_equal 4*52 - 1, shoe.cards.size
    assert card.is_a?(Card)
  end
  
end
