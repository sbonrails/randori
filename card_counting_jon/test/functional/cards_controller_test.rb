require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  def setup
    get :index
  end
  
  def test_index
    assert_response :success
  end
    
  def test_index_displays_card
    card = assigns(:card)
    assert_not_nil card
    assert @response.body[card.filename], @response.body
  end
  
  def test_index_cards_left
    cards_left = assigns(:cards_left)
    assert_not_nil cards_left
    assert @response.body[cards_left.to_s], @response.body
  end
  
  def test_index_count
    count = assigns(:count)
    assert_not_nil count
    assert @response.body[count.to_s], @response.body
  end
  
end
